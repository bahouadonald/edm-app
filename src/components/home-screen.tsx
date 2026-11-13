import { Image } from 'expo-image';
import { LinearGradient } from 'expo-linear-gradient';
import { router } from 'expo-router';
import type { Href } from 'expo-router';
import * as Haptics from 'expo-haptics';
import { SymbolView } from 'expo-symbols';
import { useEffect, useState } from 'react';
import { Pressable, Share, StyleSheet, Text, View } from 'react-native';
import Animated, { FadeInDown } from 'react-native-reanimated';

import { Card3D, GlossyIcon, HeroScreen, ProgressBar, SectionTitle } from '@/components/edm-3d';
import { EDM } from '@/constants/edm';
import { MEDITATIONS, meditationOfTheDay, type Meditation } from '@/constants/meditations';
import { useAuth } from '@/contexts/auth-context';
import { supabase } from '@/lib/supabase';

const quickLinks = [
  { title: 'Formations', subtitle: '3 parcours', icon: { ios: 'book.fill', android: 'menu_book', web: 'menu_book' }, path: '/formations', colors: ['#E8344B', '#C8102E', '#8B0A1F'] },
  { title: 'Cadres', subtitle: 'Élites', icon: { ios: 'person.3.fill', android: 'groups', web: 'groups' }, path: '/cadres', colors: ['#F7C948', '#E2A92B', '#B97E0C'] },
  { title: 'Soutenir', subtitle: 'EDM', icon: { ios: 'heart.fill', android: 'favorite', web: 'favorite' }, path: '/soutenir', colors: ['#C04BE0', '#9B22C2', '#6E0F92'] },
] as const;

type Announcement = { id: string; type: string; title: string; lieu: string | null; date_event: string };
type Parcours = { done: number; total: number; next: 'formation' | 'saison' };

export default function HomeScreen() {
  const { user, profile } = useAuth();
  const [announcements, setAnnouncements] = useState<Announcement[]>([]);
  const [parcours, setParcours] = useState<Parcours>({ done: 0, total: 0, next: 'formation' });
  const [meditation, setMeditation] = useState<Meditation>(meditationOfTheDay(MEDITATIONS));
  const [refreshing, setRefreshing] = useState(false);
  const [refreshKey, setRefreshKey] = useState(0);

  useEffect(() => {
    let mounted = true;
    void Promise.all([
      supabase.from('annonces').select('id,type,title,lieu,date_event').eq('published', true).order('date_event', { ascending: true }).limit(5),
      supabase.from('meditations_du_jour').select('jour,theme,reference,texte').eq('actif', true).order('jour', { ascending: true }),
      user
        ? Promise.all([
            supabase.from('formation_modules').select('id,formation').in('formation', ['formation', 'saison']).eq('actif', true),
            supabase.from('formation_module_progression').select('module_id').eq('user_id', user.id).eq('quiz_reussi', true),
          ])
        : Promise.resolve(null),
    ]).then(([announcementResult, meditationResult, courseResult]) => {
      if (!mounted) return;
      setAnnouncements((announcementResult.data ?? []) as Announcement[]);
      if (!meditationResult.error && meditationResult.data?.length) setMeditation(meditationOfTheDay(meditationResult.data as Meditation[]));
      if (courseResult) {
        const [modulesResult, progressResult] = courseResult;
        const modules = (modulesResult.data ?? []) as { id: string; formation: string }[];
        const done = new Set((progressResult.data ?? []).map((item) => item.module_id));
        const firstFinished = modules.filter((m) => m.formation === 'formation').every((m) => done.has(m.id));
        setParcours({ done: modules.filter((m) => done.has(m.id)).length, total: modules.length, next: firstFinished ? 'saison' : 'formation' });
      }
      setRefreshing(false);
    });
    return () => { mounted = false; };
  }, [refreshKey, user]);

  const goTo = (path: string) => {
    void Haptics.selectionAsync();
    router.push(path as unknown as Href);
  };

  const firstName = profile?.full_name?.trim().split(/\s+/)[0]
    || user?.user_metadata?.full_name?.trim().split(/\s+/)[0]
    || 'Élite';
  const ratio = parcours.total ? parcours.done / parcours.total : 0;

  return (
    <HeroScreen
      refreshing={refreshing}
      onRefresh={() => { setRefreshing(true); setRefreshKey((key) => key + 1); }}
      illustration={require('@/assets/images/illus/hero-accueil.png')}
      hero={(
        <View style={styles.heroBlock}>
          <Text style={styles.greeting}>Bonjour, <Text style={styles.greetingName}>{firstName}</Text></Text>
          <Text style={styles.welcome}>Bienvenue sur ton espace EDM</Text>
          <Animated.View entering={FadeInDown.delay(120).duration(420)} style={styles.meditation}>
            <View style={styles.meditationHeader}>
              <SymbolView name={{ ios: 'sun.max.fill', android: 'wb_sunny', web: 'wb_sunny' }} tintColor="#F7C948" size={18} />
              <Text style={styles.meditationEyebrow}>MÉDITATION DU JOUR</Text>
              <Pressable
                hitSlop={10}
                accessibilityLabel="Partager le verset du jour"
                onPress={() => { void Haptics.selectionAsync(); void Share.share({ message: `« ${meditation.texte} » — ${meditation.reference}\n\nMéditation du jour · EDM — Élite Doniel Ministries` }); }}>
                <SymbolView name={{ ios: 'square.and.arrow.up', android: 'share', web: 'share' }} tintColor={EDM.white} size={18} />
              </Pressable>
            </View>
            <Text style={styles.meditationText}>« {meditation.texte} »</Text>
            <Text style={styles.meditationRef}>{meditation.reference}</Text>
          </Animated.View>
        </View>
      )}>
      <SectionTitle icon={{ ios: 'graduationcap.fill', android: 'school', web: 'school' }} title="Mon parcours d'Élite" />
      <Card3D onPress={() => goTo(`/formation/${parcours.next}`)} style={styles.parcours}>
        <Image source={require('@/assets/images/illus/formation-1.png')} style={styles.parcoursImage} contentFit="cover" />
        <View style={styles.parcoursCopy}>
          <Text style={styles.parcoursTitle}>Continuer ma formation</Text>
          <Text style={styles.parcoursSubtitle}>Élites Charismatiques du Dieu Vivant</Text>
          <Text style={styles.parcoursCount}><Text style={{ color: EDM.red }}>{parcours.done} / {parcours.total || 47}</Text> modules validés</Text>
          <ProgressBar ratio={ratio} />
        </View>
        <SymbolView name={{ ios: 'chevron.right', android: 'chevron_right', web: 'chevron_right' }} tintColor={EDM.red} size={24} />
      </Card3D>

      <SectionTitle icon={{ ios: 'square.grid.2x2.fill', android: 'grid_view', web: 'grid_view' }} title="Explorer EDM" />
      <View style={styles.tiles}>
        {quickLinks.map((item, index) => (
          <Animated.View key={item.title} entering={FadeInDown.delay(80 + index * 70).duration(320)} style={{ flex: 1 }}>
            <Card3D onPress={() => goTo(item.path)} style={styles.tile}>
              <GlossyIcon icon={item.icon} colors={item.colors} />
              <Text style={styles.tileTitle}>{item.title}</Text>
              <Text style={styles.tileSubtitle}>{item.subtitle}</Text>
            </Card3D>
          </Animated.View>
        ))}
      </View>

      <SectionTitle icon={{ ios: 'megaphone.fill', android: 'campaign', web: 'campaign' }} title="Annonces" />
      {announcements.length === 0 ? (
        <Card3D style={styles.announcement}>
          <GlossyIcon icon={{ ios: 'megaphone.fill', android: 'campaign', web: 'campaign' }} colors={['#E8344B', '#C8102E', '#8B0A1F']} size={52} />
          <View style={styles.announcementDivider} />
          <Text style={styles.announcementEmpty}>Aucune annonce pour le moment.</Text>
        </Card3D>
      ) : announcements.map((announcement) => {
        const date = new Date(announcement.date_event);
        return (
          <Card3D key={announcement.id} style={styles.announcement}>
            <LinearGradient colors={['#E8344B', '#C8102E', '#8B0A1F']} style={styles.dateBadge}>
              <Text style={styles.dateDay}>{date.getDate()}</Text>
              <Text style={styles.dateMonth}>{date.toLocaleString('fr', { month: 'short' }).toUpperCase()}</Text>
            </LinearGradient>
            <View style={styles.announcementDivider} />
            <View style={{ flex: 1, gap: 2 }}>
              <Text style={styles.announcementType}>{announcement.type}</Text>
              <Text style={styles.announcementTitle}>{announcement.title}</Text>
              {announcement.lieu ? <Text style={styles.announcementPlace}>📍 {announcement.lieu}</Text> : null}
            </View>
          </Card3D>
        );
      })}

      <SectionTitle icon={{ ios: 'flame.fill', android: 'local_fire_department', web: 'local_fire_department' }} title="Notre vision" />
      <LinearGradient colors={['#FFF8E6', '#FDEFD0']} style={styles.vision}>
        <Text style={styles.visionQuoteMark}>❝</Text>
        <Text style={styles.visionText}>Ils n&apos;ont pas la réalité de Ma Présence ; enseigne-les à me trouver, qu&apos;ils soient en Moi et que Moi, Dieu, j&apos;agisse par eux.</Text>
        <LinearGradient colors={[EDM.red, EDM.redDark]} style={styles.visionRef}><Text style={styles.visionRefText}>Jean 15</Text></LinearGradient>
        <Text style={styles.visionMovement}>Mouvement des Élites Charismatiques du Dieu Vivant — ECDV</Text>
      </LinearGradient>

      <View style={styles.footer}>
        <Image source={require('@/assets/images/edm-logo.png')} style={styles.footerLogo} contentFit="contain" />
        <Text style={styles.footerPhone}>+225 07 13 22 48 04</Text>
        <Text style={styles.footerName}>ÉLITE DONIEL MINISTRIES</Text>
      </View>
    </HeroScreen>
  );
}

const styles = StyleSheet.create({
  heroBlock: { gap: 4 },
  greeting: { color: EDM.white, fontSize: 34, fontWeight: '900', textShadowColor: 'rgba(0,0,0,0.35)', textShadowRadius: 6, textShadowOffset: { width: 0, height: 2 } },
  greetingName: { color: '#F7C948' },
  welcome: { color: 'rgba(255,255,255,0.92)', fontSize: 15, marginBottom: 10 },
  meditation: {
    backgroundColor: 'rgba(255,255,255,0.13)', borderRadius: 20, padding: 15, gap: 8,
    borderWidth: 1, borderColor: 'rgba(247,215,116,0.55)',
  },
  meditationHeader: { flexDirection: 'row', alignItems: 'center', gap: 8 },
  meditationEyebrow: { flex: 1, color: '#F7D774', fontSize: 12, fontWeight: '900', letterSpacing: 1.2 },
  meditationText: { color: EDM.white, fontSize: 16, lineHeight: 23, fontStyle: 'italic', fontWeight: '600' },
  meditationRef: { alignSelf: 'flex-end', color: '#F7C948', fontSize: 14, fontWeight: '900' },
  parcours: { flexDirection: 'row', alignItems: 'center', gap: 14 },
  parcoursImage: { width: 96, height: 96, borderRadius: 16 },
  parcoursCopy: { flex: 1, gap: 4 },
  parcoursTitle: { color: '#13235B', fontSize: 18, fontWeight: '900' },
  parcoursSubtitle: { color: EDM.textSecondary, fontSize: 12.5 },
  parcoursCount: { color: '#13235B', fontSize: 14, fontWeight: '700', marginBottom: 4 },
  tiles: { flexDirection: 'row', gap: 10 },
  tile: { alignItems: 'center', gap: 6, paddingVertical: 16, paddingHorizontal: 6 },
  tileTitle: { color: EDM.text, fontSize: 15.5, fontWeight: '900', marginTop: 4 },
  tileSubtitle: { color: EDM.textSecondary, fontSize: 13 },
  announcement: { flexDirection: 'row', alignItems: 'center', gap: 12 },
  announcementDivider: { width: 2, alignSelf: 'stretch', backgroundColor: EDM.red, borderRadius: 1, opacity: 0.7 },
  announcementEmpty: { flex: 1, color: EDM.textSecondary, fontSize: 15, fontStyle: 'italic' },
  dateBadge: { width: 56, height: 60, borderRadius: 14, alignItems: 'center', justifyContent: 'center' },
  dateDay: { color: EDM.white, fontSize: 22, fontWeight: '900' },
  dateMonth: { color: EDM.white, fontSize: 11, fontWeight: '800' },
  announcementType: { color: EDM.red, fontSize: 11, fontWeight: '900', textTransform: 'uppercase', letterSpacing: 0.8 },
  announcementTitle: { color: '#13235B', fontSize: 16, fontWeight: '900' },
  announcementPlace: { color: EDM.textSecondary, fontSize: 13 },
  vision: { borderRadius: 22, padding: 18, gap: 10, borderWidth: 1.5, borderColor: '#E9C46A' },
  visionQuoteMark: { color: EDM.red, fontSize: 34, lineHeight: 34, fontWeight: '900' },
  visionText: { color: EDM.text, fontSize: 17, lineHeight: 25, fontStyle: 'italic', fontWeight: '600' },
  visionRef: { alignSelf: 'flex-start', borderRadius: 10, paddingHorizontal: 12, paddingVertical: 5 },
  visionRefText: { color: EDM.white, fontSize: 15, fontWeight: '900' },
  visionMovement: { color: EDM.textSecondary, fontSize: 12.5, fontWeight: '700' },
  footer: { alignItems: 'center', gap: 4, marginTop: 12 },
  footerLogo: { width: 120, height: 64 },
  footerPhone: { color: EDM.red, fontSize: 15, fontWeight: '900' },
  footerName: { color: EDM.textMuted, fontSize: 11, fontWeight: '800', letterSpacing: 1.2 },
});
