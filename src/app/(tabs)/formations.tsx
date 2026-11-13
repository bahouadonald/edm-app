import { Image } from 'expo-image';
import { router } from 'expo-router';
import type { Href } from 'expo-router';
import { SymbolView } from 'expo-symbols';
import { useEffect, useState } from 'react';
import { StyleSheet, Text, View } from 'react-native';
import Animated, { FadeInDown } from 'react-native-reanimated';

import { Badge, Card3D, HeroScreen, HeroTitle, ProgressBar } from '@/components/edm-3d';
import { RequireAuth } from '@/components/require-auth';
import { EDM, FORMATION_CARDS } from '@/constants/edm';
import { useAuth } from '@/contexts/auth-context';
import { supabase } from '@/lib/supabase';

type FormationKey = (typeof FORMATION_CARDS)[number]['key'];
type Stat = { total: number; done: number };

const courseImages: Record<FormationKey, number> = {
  formation: require('@/assets/images/illus/formation-1.png'),
  saison: require('@/assets/images/illus/formation-2.png'),
  spirituel: require('@/assets/images/illus/formation-3.png'),
};

export default function FormationsScreen() {
  return <RequireAuth><FormationsContent /></RequireAuth>;
}

function FormationsContent() {
  const { user } = useAuth();
  const [stats, setStats] = useState<Record<FormationKey, Stat>>({ formation: { total: 0, done: 0 }, saison: { total: 0, done: 0 }, spirituel: { total: 0, done: 0 } });
  const [weeksDone, setWeeksDone] = useState(0);
  const [refreshing, setRefreshing] = useState(false);
  const [refreshKey, setRefreshKey] = useState(0);

  useEffect(() => {
    if (!user) return;
    let mounted = true;
    void Promise.all([
      supabase.from('formation_modules').select('id,formation').eq('actif', true),
      supabase.from('formation_module_progression').select('module_id').eq('user_id', user.id).eq('quiz_reussi', true),
      supabase.from('formation_progression').select('semaine').eq('user_id', user.id).eq('validated', true),
    ]).then(([modules, completed, weeks]) => {
      if (!mounted) return;
      const done = new Set((completed.data ?? []).map((item) => item.module_id));
      const next: Record<FormationKey, Stat> = { formation: { total: 0, done: 0 }, saison: { total: 0, done: 0 }, spirituel: { total: 0, done: 0 } };
      (modules.data ?? []).forEach(({ id, formation }) => {
        const key = formation as FormationKey;
        if (!next[key]) return;
        next[key].total += 1;
        if (done.has(id)) next[key].done += 1;
      });
      setStats(next);
      setWeeksDone(weeks.data?.length ?? 0);
      setRefreshing(false);
    });
    return () => { mounted = false; };
  }, [refreshKey, user]);

  const status = (key: FormationKey) => {
    if (key === 'formation') return { text: `${weeksDone} / 7 semaines validées · ${stats.formation.done} / ${stats.formation.total || 35} modules`, ratio: stats.formation.total ? stats.formation.done / stats.formation.total : 0 };
    if (key === 'spirituel') return { text: 'Manuel pratique · bientôt disponible', ratio: 0 };
    const s = stats[key];
    return { text: s.total ? `${s.done} module${s.done > 1 ? 's' : ''} validé${s.done > 1 ? 's' : ''} · ${s.total} au total` : 'Bientôt disponible', ratio: s.total ? s.done / s.total : 0 };
  };

  return (
    <HeroScreen
      refreshing={refreshing}
      onRefresh={() => { setRefreshing(true); setRefreshKey((key) => key + 1); }}
      illustration={require('@/assets/images/illus/hero-formations.png')}
      hero={<HeroTitle title="Formations" highlight="EDM" subtitle="Développe ta connaissance et marche avec Dieu. Suis les parcours dans l'ordre." />}>
      {FORMATION_CARDS.map((course, index) => {
        const s = status(course.key);
        const locked = course.key === 'spirituel';
        return (
          <Animated.View key={course.key} entering={FadeInDown.delay(index * 80).duration(320)}>
            <Card3D
              style={styles.card}
              onPress={locked ? undefined : () => router.push({ pathname: '/formation/[formation]', params: { formation: course.key } } as unknown as Href)}>
              <Image source={courseImages[course.key]} style={styles.image} contentFit="cover" />
              <View style={styles.copy}>
                <Badge label={`FORMATION ${index + 1}`} />
                <Text style={styles.title}>{course.title}</Text>
                <Text style={styles.status}>{s.text}</Text>
                {!locked ? <ProgressBar ratio={s.ratio} /> : null}
              </View>
              {!locked ? <SymbolView name={{ ios: 'chevron.right', android: 'chevron_right', web: 'chevron_right' }} tintColor={EDM.red} size={26} /> : null}
            </Card3D>
          </Animated.View>
        );
      })}
    </HeroScreen>
  );
}

const styles = StyleSheet.create({
  card: { flexDirection: 'row', alignItems: 'center', gap: 12, padding: 10 },
  image: { width: 118, height: 108, borderRadius: 16 },
  copy: { flex: 1, gap: 5 },
  title: { color: '#13235B', fontSize: 17, fontWeight: '900', lineHeight: 21 },
  status: { color: EDM.textSecondary, fontSize: 12.5, fontWeight: '600' },
});
