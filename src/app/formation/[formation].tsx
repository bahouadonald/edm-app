import { router, useLocalSearchParams } from 'expo-router';
import type { Href } from 'expo-router';
import { useEffect, useMemo, useState } from 'react';
import { Pressable, StyleSheet, Text, View } from 'react-native';
import { SymbolView } from 'expo-symbols';
import * as Haptics from 'expo-haptics';
import Animated, { FadeInDown, ZoomIn } from 'react-native-reanimated';

import { ActionButton, BrandHeader, Card, Heading, LoadingState, Notice, Screen } from '@/components/edm-ui';
import { RequireAuth } from '@/components/require-auth';
import { EDM, FORMATION_CARDS, FORMATION_WEEKS } from '@/constants/edm';
import { useAuth } from '@/contexts/auth-context';
import { supabase } from '@/lib/supabase';

type FormationType = 'formation' | 'saison' | 'spirituel';
type ModuleRow = {
  id: string;
  formation: FormationType;
  numero: number;
  partie: number;
  semaine: number | null;
  semaine_titre: string | null;
  titre: string;
  sous_titre: string | null;
  texte: string | null;
  audio_url: string | null;
};
type QuestionRow = {
  id: string;
  ordre: number;
  question: string;
  option_a: string;
  option_b: string;
  option_c: string;
  bonne_reponse: 'a' | 'b' | 'c';
};
type ModuleProgress = { module_id: string; ecoute: boolean; quiz_reussi: boolean; score: number | null };
type WeekProgress = { semaine: number; step: string; validated: boolean };
type Enrollment = { user_id: string; zoom_dispo: string; engagement: boolean };
type ModuleStage = 'intro' | 'quiz' | 'done';

const validFormations: FormationType[] = ['formation', 'saison', 'spirituel'];
const zoomChoices = ['Oui, je suis disponible', 'Oui, selon mon horaire'];
const parts: Record<'saison' | 'spirituel', Record<number, string>> = {
  saison: { 1: 'Partie I — Connaître', 2: 'Partie II — Discerner', 3: 'Partie III — Activer' },
  spirituel: {
    1: 'Partie I — Comprendre le spirituel',
    2: 'Partie II — Ce que confère le spirituel',
    3: 'Partie III — La pratique',
    4: 'Partie IV — Les obstacles',
    5: 'Partie V — La plénitude',
  },
};

export default function FormationRoute() {
  return <RequireAuth><FormationContent /></RequireAuth>;
}

function FormationContent() {
  const { formation: routeFormation } = useLocalSearchParams<{ formation?: string }>();
  const { user } = useAuth();
  const formation = validFormations.find((item) => item === routeFormation);
  const [modules, setModules] = useState<ModuleRow[]>([]);
  const [progress, setProgress] = useState<Record<string, ModuleProgress>>({});
  const [weeksProgress, setWeeksProgress] = useState<WeekProgress[]>([]);
  const [enrollment, setEnrollment] = useState<Enrollment | null>(null);
  const [checkingEnrollment, setCheckingEnrollment] = useState(true);
  const [justRegistered, setJustRegistered] = useState(false);
  const [loading, setLoading] = useState(true);
  const [loadError, setLoadError] = useState('');
  const [selectedWeek, setSelectedWeek] = useState<number | null>(null);
  const [activeModule, setActiveModule] = useState<ModuleRow | null>(null);
  const [questions, setQuestions] = useState<QuestionRow[]>([]);
  const [questionsLoading, setQuestionsLoading] = useState(false);
  const [currentQuestionIndex, setCurrentQuestionIndex] = useState(0);
  const [questionAnswered, setQuestionAnswered] = useState(false);
  const [stage, setStage] = useState<ModuleStage>('intro');
  const [answers, setAnswers] = useState<Record<string, 'a' | 'b' | 'c'>>({});
  const [result, setResult] = useState<{ score: number; correct: number; passed: boolean } | null>(null);
  const [saving, setSaving] = useState(false);
  const [moduleError, setModuleError] = useState('');
  const [zoomAvailability, setZoomAvailability] = useState('');
  const [engaged, setEngaged] = useState(false);
  const [registrationError, setRegistrationError] = useState('');
  const [registering, setRegistering] = useState(false);
  const [refreshing, setRefreshing] = useState(false);
  const [refreshKey, setRefreshKey] = useState(0);

  const course = FORMATION_CARDS.find((item) => item.key === formation);

  useEffect(() => {
    if (!formation || !user) return;
    let mounted = true;
    const load = async () => {
      const [modulesResult, progressResult, weeksResult, enrollmentResult] = await Promise.all([
        supabase
          .from('formation_modules')
          .select('id,formation,numero,partie,semaine,semaine_titre,titre,sous_titre,texte,audio_url')
          .eq('formation', formation)
          .eq('actif', true)
          .order('numero', { ascending: true }),
        supabase
          .from('formation_module_progression')
          .select('module_id,ecoute,quiz_reussi,score')
          .eq('user_id', user.id),
        formation === 'formation'
          ? supabase.from('formation_progression').select('semaine,step,validated').eq('user_id', user.id)
          : Promise.resolve({ data: [], error: null }),
        formation === 'formation'
          ? supabase.from('formation_inscriptions').select('user_id,zoom_dispo,engagement').eq('user_id', user.id).maybeSingle()
          : Promise.resolve({ data: null, error: null }),
      ]);

      if (!mounted) return;
      if (modulesResult.error || progressResult.error || weeksResult.error || enrollmentResult.error) {
        setLoadError('Impossible de charger cette formation. Vérifie ta connexion puis réessaie.');
      }
      setModules((modulesResult.data ?? []) as ModuleRow[]);
      setProgress(Object.fromEntries(((progressResult.data ?? []) as ModuleProgress[]).map((item) => [item.module_id, item])));
      setWeeksProgress((weeksResult.data ?? []) as WeekProgress[]);
      setEnrollment((enrollmentResult.data ?? null) as Enrollment | null);
      setCheckingEnrollment(false);
      setLoading(false);
      setRefreshing(false);
    };

    void load();
    return () => { mounted = false; };
  }, [formation, refreshKey, user]);

  const doneCount = useMemo(() => modules.filter((module) => progress[module.id]?.quiz_reussi).length, [modules, progress]);

  useEffect(() => {
    if (!routeFormation || formation) return;
    router.replace('/formations');
  }, [formation, routeFormation]);

  const isDone = (module: ModuleRow) => Boolean(progress[module.id]?.quiz_reussi);

  const openModule = async (module: ModuleRow) => {
    void Haptics.selectionAsync();
    setActiveModule(module);
    setQuestions([]);
    setAnswers({});
    setResult(null);
    setCurrentQuestionIndex(0);
    setQuestionAnswered(false);
    setModuleError('');
    setQuestionsLoading(true);
    setStage(progress[module.id]?.quiz_reussi ? 'done' : progress[module.id]?.ecoute ? 'quiz' : 'intro');
    const { data, error } = await supabase
      .from('formation_questions')
      .select('id,ordre,question,option_a,option_b,option_c,bonne_reponse')
      .eq('module_id', module.id)
      .order('ordre', { ascending: true });
    if (error) setModuleError('Impossible de charger les questions de ce module.');
    setQuestions((data ?? []) as QuestionRow[]);
    setQuestionsLoading(false);
  };

  const startQuiz = async () => {
    if (!user || !activeModule) return;
    setSaving(true);
    setModuleError('');
    const { error } = await supabase.from('formation_module_progression').upsert({
      user_id: user.id,
      module_id: activeModule.id,
      ecoute: true,
      updated_at: new Date().toISOString(),
    }, { onConflict: 'user_id,module_id' });
    if (error) setModuleError(error.message);
    else {
      setProgress((current) => ({
        ...current,
        [activeModule.id]: { ...current[activeModule.id], module_id: activeModule.id, ecoute: true, quiz_reussi: false, score: current[activeModule.id]?.score ?? null },
      }));
      setStage('quiz');
    }
    setSaving(false);
  };

  const submitQuiz = async () => {
    if (!user || !activeModule || questions.length === 0 || Object.keys(answers).length !== questions.length) return;
    const correct = questions.filter((question) => answers[question.id] === question.bonne_reponse).length;
    const score = Math.round((correct / questions.length) * 100);
    const passed = score >= 70;
    setSaving(true);
    setModuleError('');
    const { error } = await supabase.from('formation_module_progression').upsert({
      user_id: user.id,
      module_id: activeModule.id,
      ecoute: true,
      quiz_reussi: passed,
      score,
      updated_at: new Date().toISOString(),
    }, { onConflict: 'user_id,module_id' });
    if (error) {
      setModuleError(error.message);
    } else {
      setProgress((current) => ({
        ...current,
        [activeModule.id]: { module_id: activeModule.id, ecoute: true, quiz_reussi: passed, score },
      }));
      setResult({ score, correct, passed });
      if (passed) setStage('done');
    }
    setSaving(false);
  };

  const register = async () => {
    if (!user || !zoomAvailability || !engaged) return;
    setRegistering(true);
    setRegistrationError('');
    const { data, error } = await supabase
      .from('formation_inscriptions')
      .insert({
        user_id: user.id,
        phone: user.email?.replace('@edm.app', '') ?? '',
        zoom_dispo: zoomAvailability,
        engagement: true,
      })
      .select('user_id,zoom_dispo,engagement')
      .single();
    if (error) setRegistrationError(error.message);
    else {
      setEnrollment(data as Enrollment);
      setJustRegistered(true);
    }
    setRegistering(false);
  };

  const closeModule = () => {
    setActiveModule(null);
    setQuestions([]);
    setSelectedWeek(null);
  };

  if (!formation || !course) return null;
  if (activeModule) {
    return (
      <Screen refreshing={refreshing} onRefresh={() => { setRefreshing(true); setRefreshKey((key) => key + 1); }}>
        <BrandHeader />
        <Pressable onPress={closeModule} style={styles.backButton}>
          <SymbolView name={{ ios: 'chevron.left', android: 'chevron_left', web: 'chevron_left' }} tintColor={EDM.textMuted} size={16} />
          <Text style={styles.backText}>Les modules</Text>
        </Pressable>
        <Heading eyebrow={`Module ${activeModule.numero}`} title={activeModule.titre} subtitle={activeModule.sous_titre ?? undefined} />
        {questionsLoading ? <LoadingState label="Chargement du questionnaire..." /> : null}
        {moduleError ? <Notice tone="red"><Text style={styles.body}>{moduleError}</Text></Notice> : null}
        {stage === 'intro' ? (
          <Card>
            <Text style={styles.contentLabel}>Contenu du module</Text>
            {activeModule.texte ? <Text style={styles.moduleText}>{activeModule.texte}</Text> : <Text style={styles.body}>{activeModule.sous_titre ?? activeModule.titre}</Text>}
            {activeModule.audio_url ? (
              <Notice><Text style={styles.body}>La lecture audio sera ajoutée dans une prochaine phase.</Text></Notice>
            ) : null}
            <ActionButton label="J'ai consulté le contenu — commencer le questionnaire" onPress={() => void startQuiz()} disabled={saving || questionsLoading} />
          </Card>
        ) : null}
        {stage === 'quiz' ? (
          <>
            <View style={styles.questionProgressBlock}>
              <View style={styles.progressCaption}>
                <Text style={styles.body}>Question {Math.min(currentQuestionIndex + 1, questions.length)} sur {questions.length}</Text>
                <Text style={styles.progressCount}>Seuil : 70 %</Text>
              </View>
              <View style={styles.progressTrack}>
                <View style={[styles.progressFill, { width: `${questions.length ? ((currentQuestionIndex + 1) / questions.length) * 100 : 0}%` }]} />
              </View>
            </View>
            {questions[currentQuestionIndex] ? (() => {
              const question = questions[currentQuestionIndex];
              const chosen = answers[question.id];
              const answerIsCorrect = chosen === question.bonne_reponse;
              return (
                <Animated.View key={question.id} entering={FadeInDown.duration(240)}>
                  <Card style={styles.questionCard}>
                    <Text style={styles.questionTitle}>{question.question}</Text>
                    {([
                      ['a', question.option_a],
                      ['b', question.option_b],
                      ['c', question.option_c],
                    ] as const).map(([answer, label], index) => {
                      const selected = chosen === answer;
                      const correctAnswer = questionAnswered && answer === question.bonne_reponse;
                      const incorrectAnswer = questionAnswered && selected && answer !== question.bonne_reponse;
                      return (
                        <Animated.View key={answer} entering={FadeInDown.delay(index * 45).duration(200)}>
                          <Pressable
                            disabled={questionAnswered || saving}
                            onPress={() => {
                              setAnswers((current) => ({ ...current, [question.id]: answer }));
                              setQuestionAnswered(true);
                              void Haptics.notificationAsync(answer === question.bonne_reponse
                                ? Haptics.NotificationFeedbackType.Success
                                : Haptics.NotificationFeedbackType.Error);
                            }}
                            style={[
                              styles.answer,
                              selected && styles.answerSelected,
                              correctAnswer && styles.answerCorrect,
                              incorrectAnswer && styles.answerIncorrect,
                            ]}>
                            <View style={[styles.answerLetter, selected && styles.answerLetterSelected]}>
                              <Text style={[styles.answerLetterText, selected && styles.answerLetterTextSelected]}>{answer.toUpperCase()}</Text>
                            </View>
                            <Text style={styles.answerText}>{label}</Text>
                            {correctAnswer ? <SymbolView name={{ ios: 'checkmark.circle.fill', android: 'check_circle', web: 'check_circle' }} tintColor={EDM.green} size={21} /> : null}
                            {incorrectAnswer ? <SymbolView name={{ ios: 'xmark.circle.fill', android: 'cancel', web: 'cancel' }} tintColor={EDM.red} size={21} /> : null}
                          </Pressable>
                        </Animated.View>
                      );
                    })}
                    {questionAnswered ? (
                      <Animated.View entering={ZoomIn.duration(220)} style={[styles.answerFeedback, answerIsCorrect ? styles.feedbackCorrect : styles.feedbackIncorrect]}>
                        <Text style={[styles.feedbackTitle, { color: answerIsCorrect ? EDM.green : EDM.red }]}>
                          {answerIsCorrect ? 'Bonne réponse' : 'Pas tout à fait'}
                        </Text>
                        {!answerIsCorrect ? <Text style={styles.body}>La bonne réponse est {question.bonne_reponse.toUpperCase()}.</Text> : null}
                      </Animated.View>
                    ) : null}
                  </Card>
                </Animated.View>
              );
            })() : null}
            {questions.length === 0 && !questionsLoading ? <Notice tone="red"><Text style={styles.body}>Aucune question n&apos;est disponible pour ce module.</Text></Notice> : null}
            {result ? (
              <Notice tone={result.passed ? 'green' : 'red'}>
                <Text style={styles.resultScore}>{result.score}%</Text>
                <Text style={styles.body}>{result.correct} bonnes réponses sur {questions.length}. {result.passed ? 'Module validé.' : 'Il en faut 70 % pour valider. Tu peux modifier tes réponses et réessayer.'}</Text>
                {!result.passed ? <ActionButton label="Réessayer" secondary onPress={() => { setAnswers({}); setResult(null); setCurrentQuestionIndex(0); setQuestionAnswered(false); }} /> : null}
              </Notice>
            ) : questionAnswered ? (
              <ActionButton
                label={currentQuestionIndex === questions.length - 1 ? 'Terminer le questionnaire' : 'Question suivante'}
                onPress={() => {
                  if (currentQuestionIndex === questions.length - 1) void submitQuiz();
                  else {
                    setCurrentQuestionIndex((index) => index + 1);
                    setQuestionAnswered(false);
                  }
                }}
                disabled={saving}
              />
            ) : (
              <ActionButton
                label="Choisis une réponse"
                onPress={() => undefined}
                disabled
              />
            )}
          </>
        ) : null}
        {stage === 'done' ? (
          <Card style={styles.doneCard}>
            <SymbolView name={{ ios: 'checkmark.seal.fill', android: 'verified', web: 'verified' }} tintColor={EDM.green} size={42} />
            <Text style={styles.doneTitle}>Module validé</Text>
            <Text style={styles.body}>Ta progression est enregistrée et partagée avec le site EDM.</Text>
            {progress[activeModule.id]?.score !== null ? <Text style={styles.savedScore}>Dernier score : {progress[activeModule.id]?.score}%</Text> : null}
            <ActionButton label="Continuer la formation" onPress={closeModule} />
          </Card>
        ) : null}
      </Screen>
    );
  }

  const sortedModules = modules.slice().sort((left, right) => left.numero - right.numero);
  const openSequentialModule = (module: ModuleRow) => {
    const position = sortedModules.findIndex((item) => item.id === module.id);
    return position === 0 || isDone(sortedModules[position - 1]);
  };

  const weekStatus = (week: number) => {
    const current = weeksProgress.find((item) => item.semaine === week);
    if (current?.validated) return 'Validé';
    if (current?.step === 'attente') return 'En attente';
    if (week === 1 && !current) return 'En cours';
    const previous = weeksProgress.find((item) => item.semaine === week - 1);
    return previous?.validated ? 'En cours' : 'Verrouillé';
  };

  const currentWeekModules = selectedWeek === null ? [] : sortedModules.filter((module) => module.semaine === selectedWeek);
  const currentWeekComplete = currentWeekModules.length > 0 && currentWeekModules.every(isDone);

  return (
    <Screen refreshing={refreshing} onRefresh={() => { setRefreshing(true); setRefreshKey((key) => key + 1); }}>
      <BrandHeader />
      <Pressable onPress={() => router.back()} style={styles.backButton}>
        <SymbolView name={{ ios: 'chevron.left', android: 'chevron_left', web: 'chevron_left' }} tintColor={EDM.textMuted} size={16} />
        <Text style={styles.backText}>Toutes les formations</Text>
      </Pressable>
      <Heading
        eyebrow={`Formation ${FORMATION_CARDS.findIndex((item) => item.key === formation) + 1}`}
        title={course.title}
        subtitle={formation === 'formation' ? '7 Semaines avec Dieu' : undefined}
      />
      <View style={styles.progressHeader}>
        <View style={styles.progressCaption}>
          <Text style={styles.body}>Progression</Text>
          <Text style={styles.progressCount}>{doneCount} / {modules.length} modules</Text>
        </View>
        <View style={styles.progressTrack}>
          <View style={[styles.progressFill, { width: `${modules.length ? (doneCount / modules.length) * 100 : 0}%` }]} />
        </View>
      </View>
      {loadError ? <Notice tone="red"><Text style={styles.body}>{loadError}</Text></Notice> : null}
      {loading ? <LoadingState /> : null}
      {!loading && modules.length === 0 ? (
        <Notice><Text style={styles.body}>Cette formation sera disponible dès que ses modules seront publiés.</Text></Notice>
      ) : null}

      {formation === 'formation' && !loading && !checkingEnrollment && !enrollment && !justRegistered ? (
        <RegistrationForm
          availability={zoomAvailability}
          onAvailabilityChange={setZoomAvailability}
          engaged={engaged}
          onEngagedChange={setEngaged}
          onSubmit={() => void register()}
          error={registrationError}
          busy={registering}
        />
      ) : null}
      {formation === 'formation' && justRegistered ? (
        <Card style={styles.confirmation}>
          <SymbolView name={{ ios: 'checkmark.circle.fill', android: 'check_circle', web: 'check_circle' }} tintColor={EDM.green} size={48} />
          <Text style={styles.doneTitle}>Tu es bien enregistré !</Text>
          <Text style={styles.body}>La Formation Spirituelle n&apos;a pas encore débuté. En attendant, nourris ta foi avec la Formation 2 — Discerner ta saison et l&apos;activer avec les clés du royaume.</Text>
          <ActionButton label="Aller à Discerne ta Saison" onPress={() => router.replace({ pathname: '/formation/[formation]', params: { formation: 'saison' } } as unknown as Href)} />
        </Card>
      ) : null}

      {formation === 'formation' && enrollment && !justRegistered && !loading ? (
        <>
          <Card style={styles.weekProgress}>
            <View style={styles.progressCaption}>
              <Text style={styles.weekProgressTitle}>Votre Progression</Text>
              <Text style={styles.weekProgressTitle}>{weeksProgress.filter((item) => item.validated).length}/7 semaines</Text>
            </View>
            <Text style={styles.weekProgressHint}>{doneCount}/{modules.length} modules validés</Text>
          </Card>
          {selectedWeek === null ? FORMATION_WEEKS.map((title, index) => {
            const week = index + 1;
            const status = weekStatus(week);
            const enabled = status !== 'Verrouillé';
            return (
              <Pressable
                key={week}
                disabled={!enabled}
                onPress={() => setSelectedWeek(week)}
                style={({ pressed }) => [styles.listPressable, !enabled && styles.locked, pressed && styles.pressed]}>
                <Card style={styles.moduleRow}>
                  <View style={[styles.weekNumber, status === 'Validé' && styles.weekNumberDone]}>
                    {status === 'Validé'
                      ? <SymbolView name={{ ios: 'checkmark', android: 'check', web: 'check' }} tintColor={EDM.white} size={18} />
                      : <Text style={styles.weekNumberText}>{week}</Text>}
                  </View>
                  <View style={styles.rowCopy}>
                    <Text style={styles.moduleTitle}>{title}</Text>
                    <Text style={styles.body}>Semaine {week}</Text>
                  </View>
                  <Text style={[styles.statusBadge, status === 'Validé' && styles.statusDone]}>{status}</Text>
                </Card>
              </Pressable>
            );
          }) : (
            <>
              <Pressable onPress={() => setSelectedWeek(null)} style={styles.backButton}>
                <SymbolView name={{ ios: 'chevron.left', android: 'chevron_left', web: 'chevron_left' }} tintColor={EDM.textMuted} size={16} />
                <Text style={styles.backText}>Semaines</Text>
              </Pressable>
              <Heading eyebrow={`Semaine ${selectedWeek}`} title={FORMATION_WEEKS[selectedWeek - 1]} />
              <Notice>
                <Text style={styles.body}>Consulte chaque module et réponds à son questionnaire. La validation de la semaine et l&apos;ouverture de la suivante restent gérées par l&apos;équipe sur le site.</Text>
              </Notice>
              {currentWeekModules.map((module, index) => {
                const previousModule = currentWeekModules[index - 1];
                const unlocked = index === 0 || Boolean(previousModule && isDone(previousModule));
                return <ModuleListItem key={module.id} module={module} done={isDone(module)} unlocked={unlocked} onPress={() => void openModule(module)} />;
              })}
              {currentWeekModules.length === 0 ? <Notice><Text style={styles.body}>Les modules de cette semaine seront bientôt disponibles.</Text></Notice> : null}
              {currentWeekComplete ? <Notice tone="gold"><Text style={styles.body}>Tous les modules sont réussis. La progression hebdomadaire reste en attente de la validation de l&apos;équipe.</Text></Notice> : null}
            </>
          )}
        </>
      ) : null}

      {formation !== 'formation' && !loading ? (
        <>
          <Notice><Text style={styles.body}>{formation === 'saison'
            ? "Notre vie en Christ est faite de saisons. Cette formation t'apprend à les connaître, à discerner celle dans laquelle Dieu t'a placé, et à l'activer par les clés qu'Il donne."
            : "Le spirituel, c'est la rencontre directe avec Dieu. Cette formation conduit de cette rencontre jusqu'à l'impact, en passant par la puissance, la pratique du secret et les obstacles à vaincre."}</Text></Notice>
          {sortedModules.length > 0 ? Object.entries(parts[formation] ?? {}).map(([part, label]) => {
            const partModules = sortedModules.filter((module) => module.partie === Number(part));
            if (partModules.length === 0) return null;
            return (
              <View key={part} style={styles.partSection}>
                <Text style={styles.partTitle}>{label}</Text>
                {partModules.map((module) => (
                  <ModuleListItem
                    key={module.id}
                    module={module}
                    done={isDone(module)}
                    unlocked={openSequentialModule(module)}
                    onPress={() => void openModule(module)}
                  />
                ))}
              </View>
            );
          }) : null}
        </>
      ) : null}
    </Screen>
  );
}

function ModuleListItem({
  module,
  done,
  unlocked,
  onPress,
}: {
  module: ModuleRow;
  done: boolean;
  unlocked: boolean;
  onPress: () => void;
}) {
  return (
    <Pressable
      accessibilityRole="button"
      disabled={!unlocked}
      onPress={onPress}
      style={({ pressed }) => [styles.listPressable, !unlocked && styles.locked, pressed && styles.pressed]}>
      <Card style={styles.moduleRow}>
        <View style={[styles.weekNumber, done && styles.weekNumberDone, !unlocked && styles.weekNumberLocked]}>
          {done
            ? <SymbolView name={{ ios: 'checkmark', android: 'check', web: 'check' }} tintColor={EDM.white} size={18} />
            : unlocked
              ? <Text style={styles.weekNumberText}>{module.numero}</Text>
              : <SymbolView name={{ ios: 'lock.fill', android: 'lock', web: 'lock' }} tintColor={EDM.textMuted} size={16} />}
        </View>
        <View style={styles.rowCopy}>
          <Text style={styles.moduleTitle}>{module.titre}</Text>
          <Text style={styles.body}>{done ? 'Validé' : !unlocked ? 'Termine le module précédent' : module.sous_titre ?? 'Questionnaire disponible'}</Text>
        </View>
        {unlocked && !done ? <SymbolView name={{ ios: 'arrow.right', android: 'arrow_forward', web: 'arrow_forward' }} tintColor={EDM.gold} size={18} /> : null}
      </Card>
    </Pressable>
  );
}

function RegistrationForm({
  availability,
  onAvailabilityChange,
  engaged,
  onEngagedChange,
  onSubmit,
  error,
  busy,
}: {
  availability: string;
  onAvailabilityChange: (value: string) => void;
  engaged: boolean;
  onEngagedChange: (value: boolean) => void;
  onSubmit: () => void;
  error: string;
  busy: boolean;
}) {
  return (
    <Card>
      <Heading title="Inscription à la Formation" subtitle="Avant de commencer ton parcours des 7 semaines, réponds à ces quelques questions pour t'enregistrer." />
      <Text style={styles.formLabel}>Es-tu disponible pour les rencontres Zoom de fin de semaine ?</Text>
      {zoomChoices.map((choice) => {
        const selected = availability === choice;
        return (
          <Pressable key={choice} onPress={() => { void Haptics.selectionAsync(); onAvailabilityChange(choice); }} style={styles.choiceRow}>
            <View style={[styles.radio, selected && styles.radioSelected]} />
            <Text style={styles.choiceText}>{choice}</Text>
          </Pressable>
        );
      })}
      <Pressable accessibilityRole="checkbox" accessibilityState={{ checked: engaged }} onPress={() => onEngagedChange(!engaged)} style={styles.engagement}>
        <View style={[styles.checkbox, engaged && styles.checkboxSelected]}>
          {engaged ? <SymbolView name={{ ios: 'checkmark', android: 'check', web: 'check' }} tintColor={EDM.white} size={14} /> : null}
        </View>
          <Text style={styles.engagementText}>« Je désire comprendre le bénéfice de cette formation afin d&apos;avoir une vie spirituelle plus posée et affermie en Christ. »</Text>
      </Pressable>
      {error ? <Notice tone="red"><Text style={styles.body}>{error}</Text></Notice> : null}
      <ActionButton label={busy ? 'Enregistrement...' : 'Valider mon inscription'} onPress={onSubmit} disabled={!availability || !engaged || busy} />
    </Card>
  );
}

const styles = StyleSheet.create({
  backButton: { flexDirection: 'row', alignItems: 'center', gap: 5, minHeight: 32 },
  backText: { color: EDM.textMuted, fontSize: 12, fontWeight: '700' },
  progressHeader: { gap: 8, padding: 14, borderRadius: 13, backgroundColor: EDM.white },
  progressCaption: { flexDirection: 'row', alignItems: 'center', justifyContent: 'space-between', gap: 8 },
  progressCount: { color: EDM.gold, fontSize: 11, fontWeight: '800' },
  progressTrack: { height: 7, overflow: 'hidden', borderRadius: 5, backgroundColor: EDM.creamDark },
  progressFill: { height: '100%', borderRadius: 5, backgroundColor: EDM.red },
  questionProgressBlock: { gap: 7, padding: 14, borderRadius: 13, backgroundColor: EDM.white },
  body: { color: EDM.textSecondary, fontSize: 12, lineHeight: 19 },
  contentLabel: { color: EDM.red, fontSize: 10, fontWeight: '800', letterSpacing: 1, textTransform: 'uppercase' },
  moduleText: { color: EDM.textSecondary, fontSize: 13, lineHeight: 22 },
  questionCard: { padding: 18, gap: 12 },
  questionTitle: { color: EDM.text, fontSize: 18, fontWeight: '800', lineHeight: 26, marginBottom: 4 },
  answer: { minHeight: 58, flexDirection: 'row', alignItems: 'center', gap: 11, padding: 12, borderRadius: 12, backgroundColor: EDM.cream, borderColor: EDM.border, borderWidth: 1 },
  answerSelected: { backgroundColor: '#FBF5E8', borderColor: EDM.gold },
  answerCorrect: { backgroundColor: '#EEF6EF', borderColor: EDM.green },
  answerIncorrect: { backgroundColor: '#FDF0F1', borderColor: EDM.red },
  answerLetter: { width: 30, height: 30, alignItems: 'center', justifyContent: 'center', borderRadius: 15, backgroundColor: EDM.creamDark },
  answerLetterSelected: { backgroundColor: EDM.gold },
  answerLetterText: { color: EDM.textMuted, fontSize: 11, fontWeight: '900' },
  answerLetterTextSelected: { color: EDM.white },
  answerText: { flex: 1, color: EDM.textSecondary, fontSize: 12, lineHeight: 18 },
  answerFeedback: { gap: 4, padding: 12, borderRadius: 11, borderWidth: 1 },
  feedbackCorrect: { backgroundColor: '#EEF6EF', borderColor: '#C8E0CA' },
  feedbackIncorrect: { backgroundColor: '#FDF0F1', borderColor: '#EBC4CC' },
  feedbackTitle: { fontSize: 13, fontWeight: '900' },
  resultScore: { color: EDM.red, fontSize: 24, fontWeight: '900' },
  doneCard: { alignItems: 'center', paddingVertical: 24 },
  doneTitle: { color: EDM.text, fontSize: 18, fontWeight: '800', textAlign: 'center' },
  savedScore: { color: EDM.gold, fontSize: 12, fontWeight: '800' },
  confirmation: { alignItems: 'center', paddingVertical: 24 },
  weekProgress: { backgroundColor: EDM.red, borderColor: EDM.red },
  weekProgressTitle: { color: EDM.white, fontSize: 14, fontWeight: '800' },
  weekProgressHint: { color: '#FFFFFFC7', fontSize: 11 },
  listPressable: { borderRadius: 14 },
  moduleRow: { flexDirection: 'row', alignItems: 'center', padding: 13 },
  weekNumber: { width: 38, height: 38, alignItems: 'center', justifyContent: 'center', borderRadius: 12, backgroundColor: EDM.creamDark },
  weekNumberDone: { backgroundColor: EDM.gold },
  weekNumberLocked: { backgroundColor: EDM.white, borderColor: EDM.borderStrong, borderWidth: 1 },
  weekNumberText: { color: EDM.text, fontSize: 14, fontWeight: '800' },
  rowCopy: { flex: 1, gap: 3 },
  moduleTitle: { color: EDM.text, fontSize: 13, fontWeight: '800', lineHeight: 19 },
  locked: { opacity: 0.55 },
  pressed: { opacity: 0.75 },
  statusBadge: { color: EDM.gold, fontSize: 10, fontWeight: '800' },
  statusDone: { color: EDM.green },
  partSection: { gap: 9 },
  partTitle: { color: EDM.red, fontSize: 11, fontWeight: '900', letterSpacing: 1, textTransform: 'uppercase' },
  formLabel: { color: EDM.text, fontSize: 12, fontWeight: '800', lineHeight: 18 },
  choiceRow: { minHeight: 46, flexDirection: 'row', alignItems: 'center', gap: 12, paddingHorizontal: 12, borderRadius: 11, backgroundColor: EDM.creamDark },
  radio: { width: 20, height: 20, borderColor: EDM.borderStrong, borderRadius: 10, borderWidth: 2 },
  radioSelected: { borderColor: EDM.gold, borderWidth: 6 },
  choiceText: { color: EDM.text, fontSize: 12, fontWeight: '600' },
  engagement: { flexDirection: 'row', alignItems: 'flex-start', gap: 10, padding: 12, borderRadius: 11, backgroundColor: EDM.creamDark },
  checkbox: { width: 22, height: 22, alignItems: 'center', justifyContent: 'center', borderColor: EDM.borderStrong, borderRadius: 6, borderWidth: 2 },
  checkboxSelected: { borderColor: EDM.green, backgroundColor: EDM.green },
  engagementText: { flex: 1, color: EDM.textSecondary, fontSize: 12, fontStyle: 'italic', lineHeight: 18 },
});
