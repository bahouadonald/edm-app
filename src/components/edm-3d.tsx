import { Image, type ImageSource } from 'expo-image';
import { LinearGradient } from 'expo-linear-gradient';
import { router } from 'expo-router';
import type { Href } from 'expo-router';
import * as Haptics from 'expo-haptics';
import { SymbolView, type SymbolViewProps } from 'expo-symbols';
import type { PropsWithChildren, ReactNode } from 'react';
import {
  Pressable,
  RefreshControl,
  ScrollView,
  StyleSheet,
  Text,
  View,
  type StyleProp,
  type ViewStyle,
} from 'react-native';
import Animated, { FadeInDown } from 'react-native-reanimated';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import Svg, { Defs, LinearGradient as SvgGradient, Path, Stop } from 'react-native-svg';

import { EDM } from '@/constants/edm';
import { useAuth } from '@/contexts/auth-context';

export type SymbolName = SymbolViewProps['name'];

export const GRADIENT_RED = ['#5E0012', '#8B0A1F', '#B3122E'] as const;
export const GRADIENT_GOLD = ['#F7D774', '#E2A92B', '#B97E0C'] as const;

/** Vague dorée qui sépare l'en-tête du contenu (signature visuelle des maquettes). */
export function GoldWave({ height = 46 }: { height?: number }) {
  return (
    <Svg width="100%" height={height} viewBox="0 0 400 46" preserveAspectRatio="none" style={styles.wave}>
      <Defs>
        <SvgGradient id="gold" x1="0" y1="0" x2="1" y2="0">
          <Stop offset="0" stopColor="#B97E0C" />
          <Stop offset="0.45" stopColor="#F7D774" />
          <Stop offset="1" stopColor="#C9920A" />
        </SvgGradient>
      </Defs>
      <Path d="M0 30 C 90 8, 190 46, 290 20 C 340 7, 375 10, 400 4 L400 46 L0 46 Z" fill={EDM.cream} />
      <Path d="M0 30 C 90 8, 190 46, 290 20 C 340 7, 375 10, 400 4" stroke="url(#gold)" strokeWidth={4} fill="none" />
    </Svg>
  );
}

/** Écran avec en-tête rouge plein écran, illustration à droite et vague dorée. */
export function HeroScreen({
  hero,
  illustration,
  children,
  refreshing = false,
  onRefresh,
  contentStyle,
}: PropsWithChildren<{
  hero: ReactNode;
  illustration?: ImageSource | number;
  refreshing?: boolean;
  onRefresh?: () => void;
  contentStyle?: StyleProp<ViewStyle>;
}>) {
  const insets = useSafeAreaInsets();
  return (
    <View style={styles.root}>
    <ScrollView
      style={styles.root}
      contentContainerStyle={styles.scroll}
      keyboardShouldPersistTaps="handled"
      refreshControl={onRefresh ? (
        <RefreshControl refreshing={refreshing} onRefresh={onRefresh} tintColor={EDM.gold} colors={[EDM.red, EDM.gold]} progressViewOffset={insets.top} />
      ) : undefined}>
      <LinearGradient colors={GRADIENT_RED} start={{ x: 0, y: 0 }} end={{ x: 1, y: 1 }} style={[styles.hero, { paddingTop: insets.top + 10 }]}>
        {illustration ? (
          <View style={styles.illustrationWrap} pointerEvents="none">
            <Image source={illustration} style={styles.illustration} contentFit="cover" transition={250} />
            <LinearGradient colors={['#6A0016', 'rgba(106,0,22,0.55)', 'rgba(106,0,22,0)']} start={{ x: 0, y: 0.5 }} end={{ x: 0.75, y: 0.5 }} style={StyleSheet.absoluteFill} />
          </View>
        ) : null}
        <TopBar />
        <View style={styles.heroBody}>{hero}</View>
        <GoldWave />
      </LinearGradient>
      <Animated.View entering={FadeInDown.duration(320)} style={[styles.content, contentStyle]}>
        {children}
      </Animated.View>
    </ScrollView>
    {/* Bandeau fixe sous la barre d'état : le contenu ne passe plus sous l'heure et la batterie */}
    <View pointerEvents="none" style={[styles.statusBackdrop, { height: insets.top }]} />
    </View>
  );
}

function TopBar() {
  const { user } = useAuth();
  return (
    <View style={styles.topBar}>
      <View style={styles.logoCard}>
        <Image source={require('@/assets/images/edm-logo.png')} style={styles.logo} contentFit="contain" />
      </View>
      <View style={styles.brandDivider} />
      <View style={{ flex: 1 }}>
        <Text style={styles.brandName}>EDM</Text>
        <Text style={styles.brandSubtitle}>ÉLITE DONIEL MINISTRIES</Text>
      </View>
      <Pressable
        accessibilityRole="button"
        accessibilityLabel={user ? 'Ouvrir mon profil' : 'Connexion'}
        hitSlop={10}
        onPress={() => {
          void Haptics.selectionAsync();
          router.push((user ? '/profil' : '/auth') as unknown as Href);
        }}
        style={({ pressed }) => [styles.profileButton, pressed && styles.pressed]}>
        <SymbolView name={{ ios: 'person.fill', android: 'person', web: 'person' }} tintColor={EDM.red} size={24} />
      </Pressable>
    </View>
  );
}

export function HeroTitle({ eyebrow, title, highlight, subtitle }: { eyebrow?: string; title: string; highlight?: string; subtitle?: string }) {
  return (
    <View style={styles.heroTitleBlock}>
      {eyebrow ? <Text style={styles.heroEyebrow}>{eyebrow}</Text> : null}
      <Text style={styles.heroTitle}>
        {title}
        {highlight ? <Text style={styles.heroHighlight}> {highlight}</Text> : null}
      </Text>
      {subtitle ? <Text style={styles.heroSubtitle}>{subtitle}</Text> : null}
    </View>
  );
}

export function SectionTitle({ icon, title, action, onAction }: { icon: SymbolName; title: string; action?: string; onAction?: () => void }) {
  return (
    <View style={styles.sectionTitleRow}>
      <SymbolView name={icon} tintColor={EDM.red} size={24} />
      <Text style={styles.sectionTitle}>{title}</Text>
      {action ? (
        <Pressable onPress={onAction} hitSlop={8}>
          <Text style={styles.sectionAction}>{action} ›</Text>
        </Pressable>
      ) : null}
    </View>
  );
}

/** Carte blanche en relief (ombre douce + liseré). */
export function Card3D({ children, style, onPress }: PropsWithChildren<{ style?: StyleProp<ViewStyle>; onPress?: () => void }>) {
  if (!onPress) return <View style={[styles.card3d, style]}>{children}</View>;
  return (
    <Pressable
      onPress={() => { void Haptics.selectionAsync(); onPress(); }}
      style={({ pressed }) => [styles.card3d, style, pressed && styles.pressed]}>
      {children}
    </Pressable>
  );
}

/** Pastille d'icône brillante, dégradé + reflet. */
export function GlossyIcon({ icon, colors, size = 56 }: { icon: SymbolName; colors: readonly [string, string, ...string[]]; size?: number }) {
  return (
    <View style={[styles.glossyShadow, { width: size, height: size, borderRadius: size * 0.3, shadowColor: colors[colors.length - 1] }]}>
      <LinearGradient colors={colors} start={{ x: 0, y: 0 }} end={{ x: 0, y: 1 }} style={[styles.glossy, { borderRadius: size * 0.3 }]}>
        <View style={[styles.gloss, { borderTopLeftRadius: size * 0.3, borderTopRightRadius: size * 0.3 }]} />
        <SymbolView name={icon} tintColor={EDM.white} size={size * 0.5} />
      </LinearGradient>
    </View>
  );
}

export function ProgressBar({ ratio, color = EDM.red }: { ratio: number; color?: string }) {
  return (
    <View style={styles.track}>
      <LinearGradient colors={[color, color === EDM.red ? '#E2384F' : color]} start={{ x: 0, y: 0 }} end={{ x: 1, y: 0 }} style={[styles.fill, { width: `${Math.max(4, Math.min(ratio, 1) * 100)}%` }]} />
    </View>
  );
}

export function Badge({ label, colors = [EDM.red, EDM.redDark] }: { label: string; colors?: readonly [string, string, ...string[]] }) {
  return (
    <LinearGradient colors={colors} start={{ x: 0, y: 0 }} end={{ x: 1, y: 1 }} style={styles.badge}>
      <Text style={styles.badgeText}>{label}</Text>
    </LinearGradient>
  );
}

export function PrimaryButton({ label, icon, onPress, disabled }: { label: string; icon?: SymbolName; onPress: () => void; disabled?: boolean }) {
  return (
    <Pressable
      disabled={disabled}
      onPress={() => { void Haptics.impactAsync(Haptics.ImpactFeedbackStyle.Medium); onPress(); }}
      style={({ pressed }) => [styles.primaryShadow, pressed && styles.pressed, disabled && { opacity: 0.5 }]}>
      <LinearGradient colors={['#D3182F', '#9E0B20', '#7A0018']} start={{ x: 0, y: 0 }} end={{ x: 0, y: 1 }} style={styles.primary}>
        <View style={styles.primaryGloss} />
        {icon ? <SymbolView name={icon} tintColor={EDM.white} size={24} /> : null}
        <Text style={styles.primaryText}>{label}</Text>
      </LinearGradient>
    </Pressable>
  );
}

const styles = StyleSheet.create({
  root: { flex: 1, backgroundColor: EDM.cream },
  statusBackdrop: { position: 'absolute', top: 0, left: 0, right: 0, backgroundColor: '#5E0012' },
  scroll: { paddingBottom: 110 },
  hero: { overflow: 'hidden' },
  illustrationWrap: { position: 'absolute', right: 0, top: 0, bottom: 0, width: '58%' },
  illustration: { flex: 1 },
  heroBody: { paddingHorizontal: 20, paddingTop: 14, paddingBottom: 4, minHeight: 120 },
  wave: { marginTop: 6, marginBottom: -1 },
  topBar: { flexDirection: 'row', alignItems: 'center', gap: 12, paddingHorizontal: 16 },
  logoCard: {
    width: 74, height: 46, borderRadius: 10, backgroundColor: EDM.white, alignItems: 'center', justifyContent: 'center',
    shadowColor: '#000', shadowOpacity: 0.25, shadowRadius: 6, shadowOffset: { width: 0, height: 3 }, elevation: 5,
  },
  logo: { width: 66, height: 40 },
  brandDivider: { width: 2, height: 36, backgroundColor: 'rgba(255,255,255,0.7)', borderRadius: 1 },
  brandName: { color: EDM.white, fontSize: 24, fontWeight: '900', fontStyle: 'italic', letterSpacing: 0.5 },
  brandSubtitle: { color: 'rgba(255,255,255,0.9)', fontSize: 10.5, fontWeight: '600', letterSpacing: 0.6 },
  profileButton: {
    width: 44, height: 44, borderRadius: 22, backgroundColor: EDM.white, alignItems: 'center', justifyContent: 'center',
    shadowColor: '#000', shadowOpacity: 0.3, shadowRadius: 6, shadowOffset: { width: 0, height: 3 }, elevation: 6,
  },
  heroTitleBlock: { gap: 6, maxWidth: '68%' },
  heroEyebrow: { color: '#F7D774', fontSize: 13, fontWeight: '900', letterSpacing: 1 },
  heroTitle: { color: EDM.white, fontSize: 32, fontWeight: '900', lineHeight: 36, textShadowColor: 'rgba(0,0,0,0.35)', textShadowRadius: 6, textShadowOffset: { width: 0, height: 2 } },
  heroHighlight: { color: '#F7C948' },
  heroSubtitle: { color: 'rgba(255,255,255,0.92)', fontSize: 14.5, lineHeight: 20 },
  content: { paddingHorizontal: 16, gap: 18, marginTop: 6 },
  sectionTitleRow: { flexDirection: 'row', alignItems: 'center', gap: 10, marginTop: 4 },
  sectionTitle: { flex: 1, color: EDM.text, fontSize: 21, fontWeight: '900' },
  sectionAction: { color: EDM.red, fontSize: 14, fontWeight: '800' },
  card3d: {
    backgroundColor: EDM.white, borderRadius: 22, padding: 14, borderWidth: 1, borderColor: '#F1E6D2',
    shadowColor: '#7A2E1A', shadowOpacity: 0.14, shadowRadius: 14, shadowOffset: { width: 0, height: 7 }, elevation: 5,
  },
  glossyShadow: { shadowOpacity: 0.45, shadowRadius: 8, shadowOffset: { width: 0, height: 5 }, elevation: 6 },
  glossy: { flex: 1, alignItems: 'center', justifyContent: 'center', overflow: 'hidden' },
  gloss: { position: 'absolute', top: 0, left: 0, right: 0, height: '48%', backgroundColor: 'rgba(255,255,255,0.22)' },
  track: { height: 8, borderRadius: 4, backgroundColor: '#E5DDF0', overflow: 'hidden' },
  fill: { height: 8, borderRadius: 4 },
  badge: { alignSelf: 'flex-start', paddingHorizontal: 10, paddingVertical: 4, borderRadius: 10 },
  badgeText: { color: EDM.white, fontSize: 11.5, fontWeight: '900', letterSpacing: 0.6 },
  primaryShadow: { borderRadius: 30, shadowColor: EDM.redDark, shadowOpacity: 0.45, shadowRadius: 12, shadowOffset: { width: 0, height: 7 }, elevation: 8 },
  primary: { borderRadius: 30, paddingVertical: 17, paddingHorizontal: 22, flexDirection: 'row', alignItems: 'center', justifyContent: 'center', gap: 12, overflow: 'hidden' },
  primaryGloss: { position: 'absolute', top: 0, left: 0, right: 0, height: '45%', backgroundColor: 'rgba(255,255,255,0.14)' },
  primaryText: { color: EDM.white, fontSize: 18, fontWeight: '900' },
  pressed: { opacity: 0.88, transform: [{ scale: 0.985 }] },
});
