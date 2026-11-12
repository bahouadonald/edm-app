import { router } from 'expo-router';
import type { Href } from 'expo-router';
import { useEffect, useState } from 'react';
import { Pressable, StyleSheet, Text, View } from 'react-native';
import { Image } from 'expo-image';
import { SymbolView } from 'expo-symbols';
import * as Haptics from 'expo-haptics';
import Animated, { FadeInDown } from 'react-native-reanimated';

import { BrandHeader, Card, Heading, LoadingState, Notice, Screen } from '@/components/edm-ui';
import { RequireAuth } from '@/components/require-auth';
import { EDM, FORMATION_CARDS } from '@/constants/edm';
import { useAuth } from '@/contexts/auth-context';
import { supabase } from '@/lib/supabase';

type FormationKey = (typeof FORMATION_CARDS)[number]['key'];
type CourseStats = { formation: number; saison: number; spirituel: number; modulesDone: number; weeksDone: number };

const courseImages = {
  formation: require('@/assets/images/slide-1.png'),
  saison: require('@/assets/images/slide-4.png'),
  spirituel: require('@/assets/images/slide-7.png'),
} as const;

export default function FormationsScreen() {
  return <RequireAuth><FormationsContent /></RequireAuth>;
}

function FormationsContent() {
  const { user } = useAuth();
  const [stats, setStats] = useState<CourseStats>({ formation: 0, saison: 0, spirituel: 0, modulesDone: 0, weeksDone: 0 });
  const [loading, setLoading] = useState(true);
  const [refreshing, setRefreshing] = useState(false);
  const [refreshKey, setRefreshKey] = useState(0);

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
      setRefreshing(false);
    });
    return () => { mounted = false; };
  }, [refreshKey, user]);

  const openCourse = (key: FormationKey) => {
    router.push({ pathname: '/formation/[formation]', params: { formation: key } } as unknown as Href);
  };

  return (
    <Screen refreshing={refreshing} onRefresh={() => { setRefreshing(true); setRefreshKey((key) => key + 1); }}>
      <BrandHeader />
      <Heading eyebrow="Parcours EDM" title="Les Formations EDM" subtitle="Suis les trois parcours dans l'ordre." />
      <Text style={styles.intro}>
        Une formation pratique qui transforme. Suis les trois parcours dans l&apos;ordre et deviens une élite charismatique engagée pour la cause du Seigneur, manifestant l&apos;autorité de Dieu sur la terre.
      </Text>
      {loading ? <LoadingState /> : FORMATION_CARDS.map((course, index) => {
        const total = course.key === 'formation' ? 7 : stats[course.key];
        const done = course.key === 'formation' ? stats.weeksDone : stats.modulesDone;
        const ratio = total ? Math.min(done / total, 1) : 0;
        return (
          <Animated.View key={course.key} entering={FadeInDown.delay(index * 70).duration(300)}>
            <Pressable
              accessibilityRole="button"
              onPress={() => {
                void Haptics.selectionAsync();
                openCourse(course.key);
              }}
              style={({ pressed }) => [styles.coursePressable, pressed && styles.pressed]}>
              <Card style={styles.courseCard}>
                <Image source={courseImages[course.key]} style={styles.courseImage} contentFit="contain" />
                <View style={styles.courseCopy}>
                  <Text style={styles.courseEyebrow}>FORMATION {index + 1}</Text>
                  <Text style={styles.courseTitle}>{course.title}</Text>
                  <Text style={[styles.courseStatus, { color: course.color }]}>
                    {course.key === 'formation'
                      ? `${stats.weeksDone} / 7 semaines validées`
                      : stats[course.key] > 0
                        ? `${stats.modulesDone} modules validés · ${stats[course.key]} au total`
                        : 'Bientôt disponible'}
                  </Text>
                  <View style={styles.progressTrack}>
                    <View style={[styles.progressFill, { width: `${ratio * 100}%`, backgroundColor: course.color }]} />
                  </View>
                </View>
                <SymbolView name={{ ios: 'arrow.right', android: 'arrow_forward', web: 'arrow_forward' }} tintColor={course.color} size={19} />
              </Card>
            </Pressable>
          </Animated.View>
        );
      })}
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
  intro: { color: EDM.textSecondary, fontSize: 13, lineHeight: 21 },
  coursePressable: { borderRadius: 16 },
  courseCard: { flexDirection: 'row', alignItems: 'center', padding: 11, gap: 12 },
  courseImage: { width: 78, height: 138, borderRadius: 9, backgroundColor: EDM.creamDark },
  courseCopy: { flex: 1, gap: 6 },
  courseEyebrow: { color: EDM.gold, fontSize: 9, fontWeight: '900', letterSpacing: 1 },
  courseTitle: { color: EDM.text, fontSize: 14, fontWeight: '800', lineHeight: 19 },
  courseStatus: { fontSize: 10, fontWeight: '700' },
  progressTrack: { height: 5, overflow: 'hidden', borderRadius: 4, backgroundColor: EDM.creamDark, marginTop: 2 },
  progressFill: { height: '100%', borderRadius: 4 },
  noticeText: { color: EDM.textSecondary, fontSize: 12, lineHeight: 18 },
  progressNote: { color: EDM.textMuted, fontSize: 11, textAlign: 'center' },
  pressed: { opacity: 0.75 },
});
