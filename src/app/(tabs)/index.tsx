import { router } from 'expo-router';
import type { Href } from 'expo-router';
import { useEffect, useState } from 'react';
import { Pressable, StyleSheet, Text, View } from 'react-native';
import { Image } from 'expo-image';
import { SymbolView } from 'expo-symbols';

import { BrandHeader, Card, Screen } from '@/components/edm-ui';
import { EDM } from '@/constants/edm';
import { useAuth } from '@/contexts/auth-context';
import { supabase } from '@/lib/supabase';

type Announcement = {
  id: string;
  type: string;
  title: string;
  lieu: string | null;
  date_event: string;
};

const slides = [
  require('@/assets/images/slide-1.png'),
  require('@/assets/images/slide-2.png'),
  require('@/assets/images/slide-3.png'),
  require('@/assets/images/slide-4.png'),
  require('@/assets/images/slide-5.png'),
  require('@/assets/images/slide-6.png'),
  require('@/assets/images/slide-7.png'),
];

const activities = [
  { title: 'Formations', subtitle: '3 parcours', icon: 'menu_book', path: '/formations', color: EDM.red },
  { title: 'Devenir', subtitle: 'Élite Charismatique', icon: 'workspace_premium', path: '/formations', color: EDM.gold },
  { title: 'Cadres', subtitle: 'Élites', icon: 'groups', path: '/cadres', color: EDM.redDark },
  { title: 'Soutenir', subtitle: 'EDM', icon: 'favorite', path: '/soutenir', color: EDM.gold },
] as const;

export default function HomeScreen() {
  const { user, signOut } = useAuth();
  const [announcements, setAnnouncements] = useState<Announcement[]>([]);
  const [slide, setSlide] = useState(0);

  useEffect(() => {
    let mounted = true;
    void supabase
      .from('annonces')
      .select('id,type,title,lieu,date_event')
      .eq('published', true)
      .order('date_event', { ascending: true })
      .then(({ data }) => {
        if (mounted && data) setAnnouncements(data as Announcement[]);
      });
    return () => { mounted = false; };
  }, []);

  useEffect(() => {
    const timer = setInterval(() => setSlide((current) => (current + 1) % slides.length), 6000);
    return () => clearInterval(timer);
  }, []);

  return (
    <Screen>
      <BrandHeader
        action={user ? { label: 'Quitter', onPress: () => void signOut() } : { label: 'Connexion', onPress: () => router.push('/auth') }}
      />

      <View style={styles.carousel}>
        <Image source={slides[slide]} style={styles.slide} contentFit="contain" />
        <Pressable
          accessibilityLabel="Visuel précédent"
          onPress={() => setSlide((current) => (current - 1 + slides.length) % slides.length)}
          style={[styles.arrow, styles.arrowLeft]}>
          <SymbolView name={{ ios: 'chevron.left', android: 'chevron_left', web: 'chevron_left' }} tintColor={EDM.red} size={20} />
        </Pressable>
        <Pressable
          accessibilityLabel="Visuel suivant"
          onPress={() => setSlide((current) => (current + 1) % slides.length)}
          style={[styles.arrow, styles.arrowRight]}>
          <SymbolView name={{ ios: 'chevron.right', android: 'chevron_right', web: 'chevron_right' }} tintColor={EDM.red} size={20} />
        </Pressable>
        <View style={styles.dots}>
          {slides.map((_, index) => (
            <Pressable
              key={index}
              accessibilityLabel={`Afficher le visuel ${index + 1}`}
              onPress={() => setSlide(index)}
              style={[styles.dot, index === slide && styles.dotActive]}
            />
          ))}
        </View>
      </View>

      <View style={styles.intro}>
        <Text style={styles.motto}>Les Élites Charismatiques du Dieu Vivant</Text>
        <Text style={styles.quote}>
          « Ils n&apos;ont pas la réalité de Ma Présence ; enseigne-les à me trouver, qu&apos;ils soient en Moi et que Moi, Dieu, j&apos;agisse par eux. »
        </Text>
      </View>

      <View style={styles.sectionHeading}>
        <Text style={styles.eyebrow}>Nos Activités</Text>
        <Text style={styles.sectionTitle}>Ce que nous offrons</Text>
      </View>
      <View style={styles.activityGrid}>
        {activities.map((activity) => (
          <Pressable
            key={activity.title}
            accessibilityRole="button"
            onPress={() => router.push(activity.path as unknown as Href)}
            style={({ pressed }) => [styles.activity, pressed && styles.pressed]}>
            <View style={[styles.activityIcon, { backgroundColor: `${activity.color}14` }]}>
              <SymbolView name={{ ios: 'book.closed.fill', android: activity.icon, web: activity.icon }} tintColor={activity.color} size={23} />
            </View>
            <Text style={styles.activityTitle}>{activity.title}</Text>
            <Text style={styles.activitySubtitle}>{activity.subtitle}</Text>
            <Text style={styles.activityLink}>Accéder  ›</Text>
          </Pressable>
        ))}
      </View>

      <View style={styles.sectionHeading}>
        <Text style={styles.eyebrow}>À venir</Text>
        <Text style={styles.sectionTitle}>Annonces</Text>
      </View>
      {announcements.length === 0 ? (
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
  carousel: {
    position: 'relative',
    width: '100%',
    aspectRatio: 9 / 16,
    maxHeight: 520,
    overflow: 'hidden',
    borderColor: EDM.borderStrong,
    borderRadius: 18,
    borderWidth: 1,
    backgroundColor: '#1A1206',
  },
  slide: { width: '100%', height: '100%' },
  arrow: {
    position: 'absolute',
    top: '48%',
    width: 38,
    height: 38,
    alignItems: 'center',
    justifyContent: 'center',
    borderRadius: 19,
    backgroundColor: EDM.white,
  },
  arrowLeft: { left: 10 },
  arrowRight: { right: 10 },
  dots: { position: 'absolute', bottom: 12, alignSelf: 'center', flexDirection: 'row', gap: 7 },
  dot: { width: 7, height: 7, borderRadius: 5, backgroundColor: '#FFFFFFB0' },
  dotActive: { width: 22, backgroundColor: EDM.red },
  intro: { alignItems: 'center', gap: 12, paddingHorizontal: 4 },
  motto: { color: EDM.text, fontSize: 14, fontWeight: '700', textAlign: 'center' },
  quote: {
    alignSelf: 'stretch',
    backgroundColor: EDM.white,
    borderLeftColor: EDM.gold,
    borderLeftWidth: 3,
    borderRadius: 0,
    color: EDM.textSecondary,
    fontSize: 13,
    fontStyle: 'italic',
    lineHeight: 21,
    padding: 14,
  },
  sectionHeading: { gap: 3, marginTop: 2 },
  eyebrow: { color: EDM.red, fontSize: 10, fontWeight: '800', letterSpacing: 1.8, textTransform: 'uppercase' },
  sectionTitle: { color: EDM.text, fontSize: 20, fontWeight: '800' },
  activityGrid: { flexDirection: 'row', flexWrap: 'wrap', gap: 10 },
  activity: {
    width: '48%',
    minHeight: 154,
    padding: 13,
    gap: 7,
    borderColor: EDM.border,
    borderRadius: 14,
    borderWidth: 1,
    backgroundColor: EDM.white,
  },
  activityIcon: { width: 42, height: 42, alignItems: 'center', justifyContent: 'center', borderRadius: 12 },
  activityTitle: { color: EDM.text, fontSize: 14, fontWeight: '800' },
  activitySubtitle: { color: EDM.textMuted, fontSize: 11 },
  activityLink: { color: EDM.red, fontSize: 11, fontWeight: '700', marginTop: 'auto' },
  pressed: { opacity: 0.78 },
  empty: { color: EDM.textMuted, fontSize: 13, fontStyle: 'italic', textAlign: 'center' },
  announcement: { flexDirection: 'row', alignItems: 'center', gap: 12 },
  dateBadge: { width: 54, minHeight: 54, alignItems: 'center', justifyContent: 'center', borderRadius: 10, backgroundColor: '#FDF0F1' },
  dateDay: { color: EDM.red, fontSize: 21, fontWeight: '900' },
  dateMonth: { color: EDM.red, fontSize: 9, fontWeight: '800' },
  announcementCopy: { flex: 1, gap: 2 },
  announcementType: { color: EDM.gold, fontSize: 9, fontWeight: '800', textTransform: 'uppercase' },
  announcementTitle: { color: EDM.text, fontSize: 13, fontWeight: '700' },
  announcementPlace: { color: EDM.textMuted, fontSize: 11 },
  footer: { alignItems: 'center', gap: 5, paddingVertical: 14 },
  footerLogo: { width: 58, height: 58 },
  footerPhone: { color: EDM.textMuted, fontSize: 12 },
  footerName: { color: EDM.red, fontSize: 9, fontWeight: '800', letterSpacing: 2.5 },
});
