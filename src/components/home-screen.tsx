import { router } from 'expo-router';
import type { Href } from 'expo-router';
import type { ComponentRef } from 'react';
import { useEffect, useRef, useState } from 'react';
import {
  Pressable,
  ScrollView,
  StyleSheet,
  Text,
  useWindowDimensions,
  View,
} from 'react-native';
import { Image } from 'expo-image';
import { SymbolView } from 'expo-symbols';
import * as Haptics from 'expo-haptics';
import Animated, { FadeInDown } from 'react-native-reanimated';

import { BrandHeader, Card, LoadingState, Screen } from '@/components/edm-ui';
import { EDM } from '@/constants/edm';
import { useAuth } from '@/contexts/auth-context';
import { supabase } from '@/lib/supabase';

const slides = [
  require('@/assets/images/slide-1.png'),
  require('@/assets/images/slide-2.png'),
  require('@/assets/images/slide-3.png'),
  require('@/assets/images/slide-4.png'),
  require('@/assets/images/slide-5.png'),
  require('@/assets/images/slide-6.png'),
  require('@/assets/images/slide-7.png'),
];

const quickLinks = [
  { title: 'Formations', subtitle: '3 parcours', icon: 'menu_book', path: '/formations', color: EDM.red },
  { title: 'Cadres', subtitle: 'Élites', icon: 'groups', path: '/cadres', color: EDM.gold },
  { title: 'Soutenir', subtitle: 'EDM', icon: 'favorite', path: '/soutenir', color: EDM.redDark },
] as const;

type Announcement = { id: string; type: string; title: string; lieu: string | null; date_event: string };
type ContinueStats = { done: number; total: number; enrolled: boolean };

export default function HomeScreen() {
  const { width } = useWindowDimensions();
  const { user, profile } = useAuth();
  const listRef = useRef<ComponentRef<typeof ScrollView> | null>(null);
  const [activeSlide, setActiveSlide] = useState(0);
  const [announcements, setAnnouncements] = useState<Announcement[]>([]);
  const [continuation, setContinuation] = useState<ContinueStats>({ done: 0, total: 0, enrolled: false });
  const [initialLoading, setInitialLoading] = useState(true);
  const [refreshing, setRefreshing] = useState(false);
  const [refreshKey, setRefreshKey] = useState(0);

  useEffect(() => {
    let mounted = true;
    void Promise.all([
      supabase
        .from('annonces')
        .select('id,type,title,lieu,date_event')
        .eq('published', true)
        .order('date_event', { ascending: true }),
      user
        ? Promise.all([
            supabase.from('formation_modules').select('id').eq('formation', 'formation').eq('actif', true),
            supabase.from('formation_module_progression').select('module_id').eq('user_id', user.id).eq('quiz_reussi', true),
            supabase.from('formation_inscriptions').select('user_id').eq('user_id', user.id).maybeSingle(),
          ])
        : Promise.resolve(null),
    ]).then(([announcementResult, courseResult]) => {
      if (!mounted) return;
      setAnnouncements((announcementResult.data ?? []) as Announcement[]);
      if (courseResult) {
      const [modulesResult, progressResult, enrollmentResult] = courseResult;
      const moduleIds = new Set((modulesResult.data ?? []).map((module) => module.id));
      const completed = (progressResult.data ?? []).filter((item) => moduleIds.has(item.module_id)).length;
      setContinuation({
        done: completed,
        total: modulesResult.data?.length ?? 0,
        enrolled: Boolean(enrollmentResult.data),
      });
      } else {
        setContinuation({ done: 0, total: 0, enrolled: false });
      }
      setInitialLoading(false);
      setRefreshing(false);
    });
    return () => { mounted = false; };
  }, [refreshKey, user]);

  useEffect(() => {
    const timer = setInterval(() => {
      const next = (activeSlide + 1) % slides.length;
      listRef.current?.scrollTo({ x: next * width, animated: true });
      setActiveSlide(next);
    }, 8500);
    return () => clearInterval(timer);
  }, [activeSlide, width]);

  const goTo = (path: string) => {
    void Haptics.selectionAsync();
    router.push(path as unknown as Href);
  };

  const firstName = profile?.full_name?.trim().split(/\s+/)[0]
    || user?.user_metadata?.full_name?.trim().split(/\s+/)[0]
    || 'Membre';
  const progress = continuation.total ? continuation.done / continuation.total : 0;

  return (
    <Screen
      refreshing={refreshing}
      onRefresh={() => { setRefreshing(true); setRefreshKey((key) => key + 1); }}
      contentStyle={styles.screenContent}>
      <BrandHeader />

      <ScrollView
        ref={listRef}
        horizontal
        pagingEnabled
        snapToInterval={width}
        decelerationRate="fast"
        showsHorizontalScrollIndicator={false}
        onMomentumScrollEnd={(event) => {
          const next = Math.round(event.nativeEvent.contentOffset.x / width);
          if (next !== activeSlide) setActiveSlide(next);
        }}
        style={[styles.carousel, { width, height: width * 16 / 9, marginLeft: -18 }]}
        contentContainerStyle={{ width: width * slides.length }}>
        {slides.map((source, index) => (
          <View key={index} style={{ width, height: width * 16 / 9 }}>
            <Image source={source} style={styles.slide} contentFit="contain" transition={220} />
          </View>
        ))}
      </ScrollView>
      <View style={styles.pagination}>
        {slides.map((_, index) => (
          <Pressable
            key={index}
            accessibilityRole="button"
            accessibilityLabel={`Afficher le visuel ${index + 1}`}
            onPress={() => {
              void Haptics.selectionAsync();
              listRef.current?.scrollTo({ x: index * width, animated: true });
              setActiveSlide(index);
            }}
            style={[styles.dot, index === activeSlide && styles.dotActive]}
          />
        ))}
      </View>

      <Animated.View entering={FadeInDown.delay(80).duration(360)} style={styles.welcome}>
        <Text style={styles.welcomeEyebrow}>Élite Doniel Ministries</Text>
        <Text style={styles.greeting}>Bonjour, {firstName}</Text>
        <Text style={styles.quote}>
          « Ils n&apos;ont pas la réalité de Ma Présence ; enseigne-les à me trouver, qu&apos;ils soient en Moi et que Moi, Dieu, j&apos;agisse par eux. »
        </Text>
      </Animated.View>

      <View style={styles.sectionHeading}>
        <Text style={styles.sectionEyebrow}>TON PARCOURS</Text>
        <Text style={styles.sectionTitle}>Continuer ma formation</Text>
      </View>
      <Pressable onPress={() => goTo('/formation/formation')} style={({ pressed }) => pressed && styles.pressed}>
        {initialLoading ? (
          <LoadingState label="Progression" />
        ) : (
          <Card style={styles.continueCard}>
            <View style={styles.continueTop}>
              <View style={styles.continueIcon}>
                <SymbolView name={{ ios: 'book.closed.fill', android: 'menu_book', web: 'menu_book' }} tintColor={EDM.white} size={23} />
              </View>
              <View style={styles.continueCopy}>
                <Text style={styles.continueTitle}>Une semaine pour savoir avec Dieu</Text>
                <Text style={styles.continueSubtitle}>
                  {continuation.enrolled ? `${continuation.done} / ${continuation.total} modules validés` : 'Commencer les 7 semaines'}
                </Text>
              </View>
              <SymbolView name={{ ios: 'arrow.right', android: 'arrow_forward', web: 'arrow_forward' }} tintColor={EDM.red} size={20} />
            </View>
            <View style={styles.progressTrack}>
              <View style={[styles.progressFill, { width: `${Math.round(progress * 100)}%` }]} />
            </View>
            <Text style={styles.progressCaption}>
              {continuation.enrolled ? `${Math.round(progress * 100)} % de progression des modules` : 'Inscription et progression sur ton compte EDM'}
            </Text>
          </Card>
        )}
      </Pressable>

      <View style={styles.sectionHeading}>
        <Text style={styles.sectionEyebrow}>ACCÈS RAPIDE</Text>
        <Text style={styles.sectionTitle}>Explorer EDM</Text>
      </View>
      <View style={styles.quickLinks}>
        {quickLinks.map((item, index) => (
          <Animated.View key={item.title} entering={FadeInDown.delay(100 + index * 75).duration(320)} style={styles.quickLinkSlot}>
            <Pressable onPress={() => goTo(item.path)} style={({ pressed }) => [styles.quickLink, pressed && styles.pressed]}>
              <View style={[styles.quickIcon, { backgroundColor: `${item.color}15` }]}>
                <SymbolView name={{ ios: 'book.closed.fill', android: item.icon, web: item.icon }} tintColor={item.color} size={23} />
              </View>
              <Text style={styles.quickTitle}>{item.title}</Text>
              <Text style={styles.quickSubtitle}>{item.subtitle}</Text>
            </Pressable>
          </Animated.View>
        ))}
      </View>

      <View style={styles.sectionHeading}>
        <Text style={styles.sectionEyebrow}>À VENIR</Text>
        <Text style={styles.sectionTitle}>Annonces</Text>
      </View>
      {initialLoading ? <LoadingState label="Annonces" /> : announcements.length === 0 ? (
        <Card><Text style={styles.empty}>Aucune annonce pour le moment.</Text></Card>
      ) : announcements.map((announcement) => (
        <Card key={announcement.id} style={styles.announcement}>
          <View style={styles.dateBadge}>
            <Text style={styles.dateDay}>{new Date(announcement.date_event).getDate()}</Text>
            <Text style={styles.dateMonth}>{new Date(announcement.date_event).toLocaleString('fr', { month: 'short' }).toUpperCase()}</Text>
          </View>
          <View style={styles.announcementCopy}>
            <Text style={styles.announcementType}>{announcement.type}</Text>
            <Text style={styles.announcementTitle}>{announcement.title}</Text>
            {announcement.lieu ? <Text style={styles.announcementPlace}>📍 {announcement.lieu}</Text> : null}
          </View>
        </Card>
      ))}

      <View style={styles.footer}>
        <Image source={require('@/assets/images/edm-logo.png')} style={styles.footerLogo} contentFit="contain" />
        <Text style={styles.footerPhone}>+225 07 13 22 48 04</Text>
        <Text style={styles.footerName}>ÉLITE DONIEL MINISTRIES</Text>
      </View>
    </Screen>
  );
}

const styles = StyleSheet.create({
  screenContent: { paddingHorizontal: 18 },
  carousel: { overflow: 'hidden', backgroundColor: EDM.creamDark },
  slide: { width: '100%', height: '100%' },
  pagination: { alignSelf: 'center', flexDirection: 'row', gap: 7, marginTop: -8 },
  dot: { width: 7, height: 7, borderRadius: 5, backgroundColor: EDM.borderStrong },
  dotActive: { width: 22, backgroundColor: EDM.red },
  welcome: { gap: 5, paddingTop: 2 },
  welcomeEyebrow: { color: EDM.gold, fontSize: 10, fontWeight: '800', letterSpacing: 1.5, textTransform: 'uppercase' },
  greeting: { color: EDM.text, fontSize: 28, fontWeight: '900' },
  quote: { color: EDM.textSecondary, fontSize: 13, fontStyle: 'italic', lineHeight: 21, marginTop: 7 },
  sectionHeading: { gap: 3, marginTop: 1 },
  sectionEyebrow: { color: EDM.red, fontSize: 9, fontWeight: '900', letterSpacing: 1.5 },
  sectionTitle: { color: EDM.text, fontSize: 20, fontWeight: '800' },
  continueCard: { gap: 14, padding: 16, borderColor: '#E8D8B8', shadowOpacity: 0.1 },
  continueTop: { flexDirection: 'row', alignItems: 'center', gap: 12 },
  continueIcon: { width: 46, height: 46, alignItems: 'center', justifyContent: 'center', borderRadius: 14, backgroundColor: EDM.red },
  continueCopy: { flex: 1, gap: 4 },
  continueTitle: { color: EDM.text, fontSize: 14, fontWeight: '800', lineHeight: 19 },
  continueSubtitle: { color: EDM.textMuted, fontSize: 11 },
  progressTrack: { height: 6, overflow: 'hidden', borderRadius: 4, backgroundColor: EDM.creamDark },
  progressFill: { height: '100%', borderRadius: 4, backgroundColor: EDM.gold },
  progressCaption: { color: EDM.textMuted, fontSize: 10 },
  quickLinks: { flexDirection: 'row', gap: 9 },
  quickLinkSlot: { flex: 1 },
  quickLink: { minHeight: 118, alignItems: 'flex-start', justifyContent: 'center', padding: 12, gap: 6, borderRadius: 14, borderWidth: 1, borderColor: EDM.border, backgroundColor: EDM.white },
  quickIcon: { width: 38, height: 38, alignItems: 'center', justifyContent: 'center', borderRadius: 12 },
  quickTitle: { color: EDM.text, fontSize: 13, fontWeight: '800' },
  quickSubtitle: { color: EDM.textMuted, fontSize: 10 },
  pressed: { opacity: 0.78 },
  empty: { color: EDM.textMuted, fontSize: 13, fontStyle: 'italic', textAlign: 'center' },
  announcement: { flexDirection: 'row', alignItems: 'center', gap: 12, paddingVertical: 13 },
  dateBadge: { width: 52, height: 54, alignItems: 'center', justifyContent: 'center', borderRadius: 11, backgroundColor: '#FDF0F1' },
  dateDay: { color: EDM.red, fontSize: 21, fontWeight: '900' },
  dateMonth: { color: EDM.red, fontSize: 9, fontWeight: '800' },
  announcementCopy: { flex: 1, gap: 3 },
  announcementType: { color: EDM.gold, fontSize: 9, fontWeight: '800', textTransform: 'uppercase' },
  announcementTitle: { color: EDM.text, fontSize: 13, fontWeight: '700' },
  announcementPlace: { color: EDM.textMuted, fontSize: 11 },
  footer: { alignItems: 'center', gap: 5, paddingVertical: 8 },
  footerLogo: { width: 48, height: 48 },
  footerPhone: { color: EDM.textMuted, fontSize: 12 },
  footerName: { color: EDM.red, fontSize: 9, fontWeight: '800', letterSpacing: 2.3 },
});
