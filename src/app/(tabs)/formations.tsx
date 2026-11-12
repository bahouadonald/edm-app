import { router } from 'expo-router';
import type { Href } from 'expo-router';
import { useEffect, useState } from 'react';
import { Pressable, StyleSheet, Text, View } from 'react-native';
import { SymbolView } from 'expo-symbols';

import { BrandHeader, Card, Heading, LoadingState, Notice, Screen } from '@/components/edm-ui';
import { RequireAuth } from '@/components/require-auth';
import { EDM, FORMATION_CARDS } from '@/constants/edm';
import { useAuth } from '@/contexts/auth-context';
import { supabase } from '@/lib/supabase';

type FormationKey = (typeof FORMATION_CARDS)[number]['key'];
type CourseStats = { formation: number; saison: number; spirituel: number; modulesDone: number; weeksDone: number };

export default function FormationsScreen() {
  return <RequireAuth><FormationsContent /></RequireAuth>;
}

function FormationsContent() {
  const { user } = useAuth();
  const [stats, setStats] = useState<CourseStats>({ formation: 0, saison: 0, spirituel: 0, modulesDone: 0, weeksDone: 0 });
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    if (!user) return;
    let mounted = true;
    void Promise.all([
      supabase.from('formation_modules').select('formation').eq('actif', true),
      supabase.from('formation_module_progression').select('module_id').eq('user_id', user.id).eq('quiz_reussi', true),
      supabase.from('formation_progression').select('semaine').eq('user_id', user.id).eq('validated', true),
    ]).then(([modules, completedModules, completedWeeks]) => {
      if (!mounted) return;
      const counts: CourseStats = { formation: 0, saison: 0, spirituel: 0, modulesDone: completedModules.data?.length ?? 0, weeksDone: completedWeeks.data?.length ?? 0 };
      modules.data?.forEach(({ formation }) => {
        if (formation === 'formation') counts.formation += 1;
        else if (formation === 'saison') counts.saison += 1;
        else if (formation === 'spirituel') counts.spirituel += 1;
      });
      setStats(counts);
      setLoading(false);
    });
    return () => { mounted = false; };
  }, [user]);

  const openCourse = (key: FormationKey) => {
    router.push({ pathname: '/formation/[formation]', params: { formation: key } } as unknown as Href);
  };

  return (
    <Screen>
      <BrandHeader />
      <Heading eyebrow="Parcours EDM" title="Les Formations EDM" subtitle="Les Élites Charismatiques du Dieu Vivant" />
      <Text style={styles.intro}>
        Une formation pratique qui transforme. Suis les trois parcours dans l&apos;ordre et deviens une élite charismatique engagée pour la cause du Seigneur, manifestant l&apos;autorité de Dieu sur la terre.
      </Text>
      {loading ? <LoadingState /> : FORMATION_CARDS.map((course) => (
        <Pressable
          key={course.key}
          accessibilityRole="button"
          onPress={() => openCourse(course.key)}
          style={({ pressed }) => [styles.coursePressable, pressed && styles.pressed]}>
          <Card style={styles.courseCard}>
            <View style={[styles.number, { backgroundColor: course.color }]}>
              <Text style={styles.numberText}>{FORMATION_CARDS.findIndex((item) => item.key === course.key) + 1}</Text>
            </View>
            <View style={styles.courseCopy}>
              <Text style={styles.courseTitle}>{course.title}</Text>
              <Text style={[styles.courseStatus, { color: course.color }]}>
                {course.key === 'formation'
                  ? `${stats.weeksDone} / 7 semaines validées`
                  : stats[course.key] > 0
                    ? `${stats.modulesDone} module${stats.modulesDone > 1 ? 's' : ''} validé${stats.modulesDone > 1 ? 's' : ''} · ${stats[course.key]} modules`
                    : 'Bientôt disponible'}
              </Text>
            </View>
            <SymbolView
              name={{ ios: 'arrow.right', android: 'arrow_forward', web: 'arrow_forward' }}
              tintColor={course.color}
              size={20}
            />
          </Card>
        </Pressable>
      ))}
      <Notice>
        <Text style={styles.noticeText}>
          À l&apos;issue des trois formations, tu accèdes à la Formation en Discipulat réservée aux Cadres, et tu reçois ton certificat et ton badge d&apos;Élite Charismatique du Dieu Vivant.
        </Text>
      </Notice>
      <Text style={styles.progressNote}>Progression enregistrée sur ton compte et partagée avec le site EDM.</Text>
    </Screen>
  );
}

const styles = StyleSheet.create({
  intro: { color: EDM.textSecondary, fontSize: 13, lineHeight: 21, textAlign: 'center' },
  coursePressable: { borderLeftColor: EDM.red, borderLeftWidth: 4, borderRadius: 16 },
  courseCard: { flexDirection: 'row', alignItems: 'center', paddingVertical: 18 },
  number: { width: 44, height: 44, borderRadius: 13, alignItems: 'center', justifyContent: 'center' },
  numberText: { color: EDM.white, fontSize: 18, fontWeight: '900' },
  courseCopy: { flex: 1, gap: 5 },
  courseTitle: { color: EDM.text, fontSize: 14, fontWeight: '800', lineHeight: 20 },
  courseStatus: { fontSize: 11, fontWeight: '700' },
  noticeText: { color: EDM.textSecondary, fontSize: 12, lineHeight: 18 },
  progressNote: { color: EDM.textMuted, fontSize: 11, textAlign: 'center' },
  pressed: { opacity: 0.75 },
});
