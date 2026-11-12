import { Image } from 'expo-image';
import { SymbolView } from 'expo-symbols';
import type { PropsWithChildren, ReactNode } from 'react';
import { router } from 'expo-router';
import type { Href } from 'expo-router';
import * as Haptics from 'expo-haptics';
import {
  Pressable,
  RefreshControl,
  ScrollView,
  StyleSheet,
  Text,
  View,
  type StyleProp,
  type TextStyle,
  type ViewStyle,
} from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import Animated, { FadeIn, FadeInDown } from 'react-native-reanimated';

import { EDM } from '@/constants/edm';
import { useAuth } from '@/contexts/auth-context';

export function Screen({
  children,
  contentStyle,
  refreshing = false,
  onRefresh,
}: PropsWithChildren<{
  contentStyle?: StyleProp<ViewStyle>;
  refreshing?: boolean;
  onRefresh?: () => void;
}>) {
  return (
    <SafeAreaView edges={['top']} style={styles.safeArea}>
      <ScrollView
        contentContainerStyle={[styles.content, contentStyle]}
        keyboardShouldPersistTaps="handled"
        refreshControl={onRefresh ? (
          <RefreshControl
            refreshing={refreshing}
            onRefresh={onRefresh}
            tintColor={EDM.red}
            colors={[EDM.red, EDM.gold]}
          />
        ) : undefined}>
        <Animated.View entering={FadeInDown.duration(280)} style={styles.contentBody}>
          {children}
        </Animated.View>
      </ScrollView>
    </SafeAreaView>
  );
}

export function BrandHeader() {
  const { user } = useAuth();

  const openProfile = () => {
    void Haptics.selectionAsync();
    router.push((user ? '/profil' : '/auth') as unknown as Href);
  };

  return (
    <View style={styles.brandHeader}>
      <Image source={require('@/assets/images/edm-logo.png')} style={styles.logo} contentFit="contain" />
      <View style={styles.brandCopy}>
        <Text style={styles.brandName}>EDM</Text>
        <Text style={styles.brandSubtitle}>Élite Doniel Ministries</Text>
      </View>
      <Pressable
        accessibilityRole="button"
        accessibilityLabel={user ? 'Ouvrir mon profil' : 'Connexion'}
        onPress={openProfile}
        hitSlop={10}
        style={styles.profileButton}>
        <SymbolView
          name={{ ios: 'person.crop.circle.fill', android: 'account_circle', web: 'account_circle' }}
          tintColor={EDM.red}
          size={26}
        />
      </Pressable>
    </View>
  );
}

export function Heading({
  eyebrow,
  title,
  subtitle,
}: {
  eyebrow?: string;
  title: string;
  subtitle?: string;
}) {
  return (
    <View style={styles.heading}>
      {eyebrow ? <Text style={styles.eyebrow}>{eyebrow}</Text> : null}
      <Text style={styles.title}>{title}</Text>
      {subtitle ? <Text style={styles.subtitle}>{subtitle}</Text> : null}
    </View>
  );
}

export function Card({
  children,
  style,
}: PropsWithChildren<{ style?: StyleProp<ViewStyle> }>) {
  return <View style={[styles.card, style]}>{children}</View>;
}

export function ActionButton({
  label,
  onPress,
  disabled = false,
  secondary = false,
  icon,
}: {
  label: string;
  onPress: () => void;
  disabled?: boolean;
  secondary?: boolean;
  icon?: ReactNode;
}) {
  return (
    <Pressable
      accessibilityRole="button"
      disabled={disabled}
      onPress={() => {
        void Haptics.selectionAsync();
        onPress();
      }}
      style={({ pressed }) => [
        styles.button,
        secondary ? styles.secondaryButton : styles.primaryButton,
        disabled && styles.disabledButton,
        pressed && !disabled && styles.pressed,
      ]}>
      {icon}
      <Text style={[styles.buttonText, secondary && styles.secondaryButtonText]}>{label}</Text>
    </Pressable>
  );
}

export function LoadingState({ label = 'Chargement...' }: { label?: string }) {
  return (
    <View accessibilityLabel={label} style={styles.loading}>
      {[0, 1, 2].map((item) => (
        <Animated.View key={item} entering={FadeIn.delay(item * 70).duration(260)} style={styles.skeletonCard}>
          <View style={styles.skeletonIcon} />
          <View style={styles.skeletonCopy}>
            <View style={styles.skeletonTitle} />
            <View style={styles.skeletonLine} />
          </View>
        </Animated.View>
      ))}
    </View>
  );
}

export function Notice({ children, tone = 'gold' }: PropsWithChildren<{ tone?: 'gold' | 'red' | 'green' }>) {
  return <View style={[styles.notice, noticeTones[tone]]}>{children}</View>;
}

export function BodyText({
  children,
  style,
}: PropsWithChildren<{ style?: StyleProp<TextStyle> }>) {
  return <Text style={[styles.bodyText, style]}>{children}</Text>;
}

const noticeTones = StyleSheet.create({
  gold: { backgroundColor: '#FBF5E8', borderColor: '#E9D7A7' },
  red: { backgroundColor: '#FDF0F1', borderColor: '#EBC4CC' },
  green: { backgroundColor: '#EEF6EF', borderColor: '#C8E0CA' },
});

const styles = StyleSheet.create({
  safeArea: { flex: 1, backgroundColor: EDM.cream },
  content: { paddingHorizontal: 18, paddingTop: 10, paddingBottom: 34 },
  contentBody: { gap: 22 },
  brandHeader: { minHeight: 52, flexDirection: 'row', alignItems: 'center', gap: 10 },
  logo: { width: 40, height: 40 },
  brandCopy: { flex: 1 },
  brandName: { color: EDM.red, fontSize: 15, fontWeight: '900' },
  brandSubtitle: { color: EDM.textMuted, fontSize: 9, letterSpacing: 1.1, textTransform: 'uppercase' },
  profileButton: { width: 42, height: 42, alignItems: 'center', justifyContent: 'center', borderRadius: 21, backgroundColor: EDM.creamDark },
  profileIcon: { color: EDM.red, fontSize: 26, lineHeight: 30, fontWeight: '700' },
  heading: { gap: 5 },
  eyebrow: { color: EDM.red, fontSize: 10, fontWeight: '800', letterSpacing: 1.6, textTransform: 'uppercase' },
  title: { color: EDM.text, fontSize: 24, fontWeight: '800', lineHeight: 30 },
  subtitle: { color: EDM.textMuted, fontSize: 12, lineHeight: 18 },
  card: {
    backgroundColor: EDM.white,
    borderColor: EDM.border,
    borderRadius: 16,
    borderWidth: 1,
    padding: 16,
    gap: 10,
    shadowColor: EDM.text,
    shadowOpacity: 0.06,
    shadowRadius: 12,
    shadowOffset: { width: 0, height: 4 },
    elevation: 2,
  },
  button: {
    minHeight: 48,
    borderRadius: 12,
    paddingHorizontal: 16,
    paddingVertical: 12,
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'center',
    gap: 8,
  },
  primaryButton: { backgroundColor: EDM.red },
  secondaryButton: { backgroundColor: EDM.creamDark, borderColor: EDM.border, borderWidth: 1 },
  disabledButton: { opacity: 0.45 },
  buttonText: { color: EDM.white, fontSize: 14, fontWeight: '800', textAlign: 'center' },
  secondaryButtonText: { color: EDM.textSecondary },
  pressed: { opacity: 0.8 },
  loading: { gap: 12 },
  skeletonCard: { minHeight: 74, flexDirection: 'row', alignItems: 'center', gap: 14, padding: 14, borderRadius: 16, backgroundColor: EDM.white },
  skeletonIcon: { width: 44, height: 44, borderRadius: 13, backgroundColor: EDM.creamDark },
  skeletonCopy: { flex: 1, gap: 9 },
  skeletonTitle: { width: '66%', height: 13, borderRadius: 7, backgroundColor: EDM.creamDark },
  skeletonLine: { width: '43%', height: 9, borderRadius: 5, backgroundColor: EDM.creamDark },
  loadingText: { color: EDM.textMuted, fontSize: 12 },
  notice: { borderWidth: 1, borderRadius: 12, padding: 13 },
  bodyText: { color: EDM.textSecondary, fontSize: 13, lineHeight: 20 },
});
