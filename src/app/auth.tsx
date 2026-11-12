import { router, useLocalSearchParams } from 'expo-router';
import type { Href } from 'expo-router';
import { useEffect, useState } from 'react';
import {
  KeyboardAvoidingView,
  Platform,
  Pressable,
  StyleSheet,
  Text,
  TextInput,
  View,
} from 'react-native';
import { Image } from 'expo-image';
import * as Haptics from 'expo-haptics';

import { ActionButton, Screen } from '@/components/edm-ui';
import { EDM } from '@/constants/edm';
import { useAuth } from '@/contexts/auth-context';

export default function AuthScreen() {
  const { returnTo } = useLocalSearchParams<{ returnTo?: string }>();
  const { user, loading, signIn, signUp } = useAuth();
  const [mode, setMode] = useState<'login' | 'register'>('login');
  const [fullName, setFullName] = useState('');
  const [phone, setPhone] = useState('');
  const [password, setPassword] = useState('');
  const [confirmation, setConfirmation] = useState('');
  const [error, setError] = useState('');
  const [busy, setBusy] = useState(false);

  const destination = [
    '/',
    '/formations',
    '/cadres',
    '/formation/formation',
    '/formation/saison',
    '/formation/spirituel',
  ].includes(returnTo ?? '')
    ? (returnTo as string)
    : '/';

  useEffect(() => {
    if (!loading && user) router.replace(destination as unknown as Href);
  }, [destination, loading, user]);

  const submit = async () => {
    setError('');
    if (!phone || !password) {
      setError('Remplissez tous les champs.');
      return;
    }
    if (mode === 'register' && password !== confirmation) {
      setError('Mots de passe différents.');
      return;
    }
    if (mode === 'register' && !fullName.trim()) {
      setError('Entrez votre nom.');
      return;
    }

    setBusy(true);
    try {
      if (mode === 'login') await signIn({ phone, password });
      else await signUp({ phone, password, fullName: fullName.trim() });
      router.replace(destination as unknown as Href);
    } catch (submitError) {
      setError(submitError instanceof Error ? submitError.message : 'Erreur. Vérifiez vos informations.');
    } finally {
      setBusy(false);
    }
  };

  return (
    <Screen contentStyle={styles.screenContent}>
      <KeyboardAvoidingView behavior={Platform.OS === 'ios' ? 'padding' : undefined}>
        <View style={styles.panel}>
          <Image source={require('@/assets/images/edm-logo.png')} style={styles.logo} contentFit="contain" />
          <Text style={styles.title}>Bienvenue sur EDM</Text>
          <Text style={styles.subtitle}>Élite Doniel Ministries</Text>

          <View style={styles.segment}>
            <Pressable onPress={() => { void Haptics.selectionAsync(); setMode('login'); }} style={[styles.segmentItem, mode === 'login' && styles.segmentSelected]}>
              <Text style={[styles.segmentText, mode === 'login' && styles.segmentTextSelected]}>Connexion</Text>
            </Pressable>
            <Pressable onPress={() => { void Haptics.selectionAsync(); setMode('register'); }} style={[styles.segmentItem, mode === 'register' && styles.segmentSelected]}>
              <Text style={[styles.segmentText, mode === 'register' && styles.segmentTextSelected]}>S&apos;inscrire</Text>
            </Pressable>
          </View>

          {mode === 'register' ? (
            <Field label="Nom complet" value={fullName} onChangeText={setFullName} placeholder="Jean-Baptiste Koné" />
          ) : null}
          <Field
            label="Numéro de téléphone"
            value={phone}
            onChangeText={setPhone}
            placeholder="+225 07 00 00 00 00"
            keyboardType="phone-pad"
          />
          <Field
            label="Mot de passe"
            value={password}
            onChangeText={setPassword}
            placeholder="••••••••"
            secureTextEntry
          />
          {mode === 'register' ? (
            <Field
              label="Confirmer"
              value={confirmation}
              onChangeText={setConfirmation}
              placeholder="••••••••"
              secureTextEntry
            />
          ) : null}

          {error ? <Text accessibilityRole="alert" style={styles.error}>{error}</Text> : null}
          <ActionButton
            label={busy ? 'Chargement...' : mode === 'login' ? 'Se connecter' : 'Créer mon compte'}
            onPress={() => void submit()}
            disabled={busy}
          />
        </View>
      </KeyboardAvoidingView>
    </Screen>
  );
}

function Field({
  label,
  ...inputProps
}: React.ComponentProps<typeof TextInput> & { label: string }) {
  return (
    <View style={styles.field}>
      <Text style={styles.label}>{label}</Text>
      <TextInput
        {...inputProps}
        style={styles.input}
        placeholderTextColor={EDM.textMuted}
        autoCapitalize="none"
        autoCorrect={false}
      />
    </View>
  );
}

const styles = StyleSheet.create({
  screenContent: { flexGrow: 1, justifyContent: 'center', paddingVertical: 28 },
  panel: {
    backgroundColor: EDM.white,
    borderColor: EDM.border,
    borderRadius: 22,
    borderWidth: 1,
    padding: 22,
    gap: 14,
  },
  logo: { width: 82, height: 82, alignSelf: 'center', marginBottom: 2 },
  title: { color: EDM.text, fontSize: 22, fontWeight: '800', textAlign: 'center' },
  subtitle: { color: EDM.textMuted, fontSize: 12, fontStyle: 'italic', textAlign: 'center', marginTop: -10 },
  segment: {
    flexDirection: 'row',
    backgroundColor: EDM.creamDark,
    borderColor: EDM.border,
    borderRadius: 12,
    borderWidth: 1,
    padding: 3,
    marginTop: 6,
    marginBottom: 4,
  },
  segmentItem: { flex: 1, minHeight: 40, alignItems: 'center', justifyContent: 'center', borderRadius: 9 },
  segmentSelected: { backgroundColor: EDM.red },
  segmentText: { color: EDM.textMuted, fontSize: 13, fontWeight: '700' },
  segmentTextSelected: { color: EDM.white },
  field: { gap: 6 },
  label: { color: EDM.textMuted, fontSize: 10, fontWeight: '700', letterSpacing: 1, textTransform: 'uppercase' },
  input: {
    minHeight: 48,
    backgroundColor: EDM.creamDark,
    borderColor: EDM.border,
    borderRadius: 12,
    borderWidth: 1,
    color: EDM.text,
    fontSize: 14,
    paddingHorizontal: 14,
  },
  error: {
    backgroundColor: '#FDF0F1',
    borderColor: '#EBC4CC',
    borderRadius: 10,
    borderWidth: 1,
    color: EDM.red,
    fontSize: 12,
    padding: 11,
  },
});
