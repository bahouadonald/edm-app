import { Image } from 'expo-image';
import type { PropsWithChildren, ReactNode } from 'react';
import {
  ActivityIndicator,
  Pressable,
  ScrollView,
  StyleSheet,
  Text,
  View,
  type StyleProp,
  type TextStyle,
  type ViewStyle,
} from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';

import { EDM } from '@/constants/edm';

export function Screen({
  children,
  contentStyle,
}: PropsWithChildren<{ contentStyle?: StyleProp<ViewStyle> }>) {
  return (
    <SafeAreaView edges={['top']} style={styles.safeArea}>
      <ScrollView contentContainerStyle={[styles.content, contentStyle]} keyboardShouldPersistTaps="handled">
        {children}
      </ScrollView>
    </SafeAreaView>
  );
}

export function BrandHeader({
  action,
}: {
  action?: { label: string; onPress: () => void };
}) {
  return (
    <View style={styles.brandHeader}>
      <Image source={require('@/assets/images/edm-logo.png')} style={styles.logo} contentFit="contain" />
      <View style={styles.brandCopy}>
        <Text style={styles.brandName}>EDM</Text>
        <Text style={styles.brandSubtitle}>Élite Doniel Ministries</Text>
      </View>
      {action ? <Pressable onPress={action.onPress} hitSlop={8}><Text style={styles.headerAction}>{action.label}</Text></Pressable> : null}
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
      onPress={onPress}
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
    <View style={styles.loading}>
      <ActivityIndicator color={EDM.red} />
      <Text style={styles.loadingText}>{label}</Text>
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
  content: { paddingHorizontal: 16, paddingTop: 10, paddingBottom: 28, gap: 18 },
  brandHeader: { minHeight: 52, flexDirection: 'row', alignItems: 'center', gap: 10 },
  logo: { width: 42, height: 42 },
  brandCopy: { flex: 1 },
  brandName: { color: EDM.red, fontSize: 15, fontWeight: '900' },
  brandSubtitle: { color: EDM.textMuted, fontSize: 9, letterSpacing: 1.1, textTransform: 'uppercase' },
  headerAction: { color: EDM.red, fontSize: 12, fontWeight: '700' },
  heading: { gap: 5 },
  eyebrow: { color: EDM.red, fontSize: 10, fontWeight: '800', letterSpacing: 1.6, textTransform: 'uppercase' },
  title: { color: EDM.text, fontSize: 22, fontWeight: '800' },
  subtitle: { color: EDM.textMuted, fontSize: 12, lineHeight: 18 },
  card: {
    backgroundColor: EDM.white,
    borderColor: EDM.border,
    borderRadius: 16,
    borderWidth: 1,
    padding: 16,
    gap: 10,
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
  loading: { minHeight: 120, alignItems: 'center', justifyContent: 'center', gap: 10 },
  loadingText: { color: EDM.textMuted, fontSize: 12 },
  notice: { borderWidth: 1, borderRadius: 12, padding: 13 },
  bodyText: { color: EDM.textSecondary, fontSize: 13, lineHeight: 20 },
});
