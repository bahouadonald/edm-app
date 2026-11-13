import Constants from 'expo-constants';
import { Image } from 'expo-image';
import * as ImagePicker from 'expo-image-picker';
import { LinearGradient } from 'expo-linear-gradient';
import * as Linking from 'expo-linking';
import { router } from 'expo-router';
import type { Href } from 'expo-router';
import * as Haptics from 'expo-haptics';
import { SymbolView } from 'expo-symbols';
import { useEffect, useState } from 'react';
import { ActivityIndicator, Pressable, StyleSheet, Text, TextInput, View } from 'react-native';
import Animated, { FadeInDown } from 'react-native-reanimated';

import { Card3D, HeroScreen, HeroTitle, PrimaryButton, type SymbolName } from '@/components/edm-3d';
import { RequireAuth } from '@/components/require-auth';
import { departmentName, EDM, FORMATION_CARDS } from '@/constants/edm';
import { useAuth } from '@/contexts/auth-context';
import { supabase } from '@/lib/supabase';

type Panel = 'infos' | 'attestations' | 'parametres' | null;

export default function ProfileRoute() {
  return <RequireAuth><ProfileScreen /></RequireAuth>;
}

function ProfileScreen() {
  const { user, profile, signOut, refreshProfile } = useAuth();
  const [panel, setPanel] = useState<Panel>(null);
  const [editing, setEditing] = useState(false);
  const [name, setName] = useState(profile?.full_name ?? '');
  const [busy, setBusy] = useState(false);
  const [uploading, setUploading] = useState(false);
  const [message, setMessage] = useState('');
  const [completed, setCompleted] = useState<string[]>([]);
  const [inProgress, setInProgress] = useState(0);

  const fullName = profile?.full_name || user?.user_metadata?.full_name || 'Élite EDM';
  const phone = profile?.phone || user?.email?.replace('@edm.app', '') || '—';
  const department = profile?.dept_confirme
    ? departmentName(profile.dept_confirme)
    : profile?.dept_choisi
      ? `${departmentName(profile.dept_choisi)} (demande en cours)`
      : 'Aucun département pour le moment';

  useEffect(() => {
    if (!user) return;
    let mounted = true;
    void Promise.all([
      supabase.from('formation_modules').select('id,formation').eq('actif', true),
      supabase.from('formation_module_progression').select('module_id,quiz_reussi').eq('user_id', user.id),
    ]).then(([modules, progress]) => {
      if (!mounted) return;
      const rows = (modules.data ?? []) as { id: string; formation: string }[];
      const passed = new Set((progress.data ?? []).filter((p) => p.quiz_reussi).map((p) => p.module_id));
      const started = new Set((progress.data ?? []).map((p) => p.module_id));
      const keys = Array.from(new Set(rows.map((r) => r.formation)));
      const done = keys.filter((key) => rows.filter((r) => r.formation === key).every((r) => passed.has(r.id)));
      setCompleted(done);
      setInProgress(keys.filter((key) => !done.includes(key) && rows.some((r) => r.formation === key && started.has(r.id))).length);
    });
    return () => { mounted = false; };
  }, [user]);

  const toggle = (next: Panel) => {
    void Haptics.selectionAsync();
    setPanel((current) => (current === next ? null : next));
  };

  const pickPhoto = async () => {
    if (!user) return;
    setMessage('');
    const result = await ImagePicker.launchImageLibraryAsync({ mediaTypes: ['images'], allowsEditing: true, aspect: [1, 1], quality: 0.6 });
    if (result.canceled || !result.assets?.[0]) return;
    setUploading(true);
    try {
      const asset = result.assets[0];
      const extension = (asset.mimeType?.split('/')[1] ?? 'jpg').replace('jpeg', 'jpg');
      const path = `${user.id}/avatar-${Date.now()}.${extension}`;
      const body = await (await fetch(asset.uri)).arrayBuffer();
      const { error: uploadError } = await supabase.storage.from('avatars').upload(path, body, { contentType: asset.mimeType ?? 'image/jpeg', upsert: true });
      if (uploadError) throw uploadError;
      const url = supabase.storage.from('avatars').getPublicUrl(path).data.publicUrl;
      const { error: updateError } = await supabase.from('profiles').update({ avatar_url: url }).eq('id', user.id);
      if (updateError) throw updateError;
      await refreshProfile();
      void Haptics.notificationAsync(Haptics.NotificationFeedbackType.Success);
    } catch (error) {
      setMessage(`La photo n'a pas pu être enregistrée. ${error instanceof Error ? error.message : ''}`);
    }
    setUploading(false);
  };

  const saveName = async () => {
    if (!user || !name.trim()) return;
    setBusy(true);
    setMessage('');
    const { error } = await supabase.from('profiles').update({ full_name: name.trim() }).eq('id', user.id);
    if (error) setMessage(error.message);
    else {
      await refreshProfile();
      setEditing(false);
      void Haptics.notificationAsync(Haptics.NotificationFeedbackType.Success);
    }
    setBusy(false);
  };

  const logout = async () => {
    await signOut();
    router.replace('/');
  };

  const menu: { key: string; icon: SymbolName; title: string; subtitle: string; onPress: () => void; open?: boolean }[] = [
    { key: 'infos', icon: { ios: 'person.fill', android: 'person', web: 'person' }, title: 'Mes informations', subtitle: 'Profil, contact', onPress: () => toggle('infos'), open: panel === 'infos' },
    { key: 'parcours', icon: { ios: 'graduationcap.fill', android: 'school', web: 'school' }, title: 'Mon parcours de formation', subtitle: `${completed.length} terminée${completed.length > 1 ? 's' : ''} · ${inProgress} en cours`, onPress: () => router.push('/formations' as unknown as Href) },
    { key: 'departement', icon: { ios: 'person.3.fill', android: 'groups', web: 'groups' }, title: 'Mon département', subtitle: department, onPress: () => router.push('/cadres' as unknown as Href) },
    { key: 'attestations', icon: { ios: 'rosette', android: 'workspace_premium', web: 'workspace_premium' }, title: 'Mes attestations', subtitle: 'Certificats d\'Élite Charismatique', onPress: () => toggle('attestations'), open: panel === 'attestations' },
    { key: 'parametres', icon: { ios: 'gearshape.fill', android: 'settings', web: 'settings' }, title: 'Paramètres', subtitle: 'Aide, contact, version', onPress: () => toggle('parametres'), open: panel === 'parametres' },
  ];

  return (
    <HeroScreen
      illustration={require('@/assets/images/illus/hero-profil.png')}
      hero={(
        <View style={{ gap: 10 }}>
          <Pressable onPress={() => router.back()} hitSlop={10} style={styles.back}>
            <SymbolView name={{ ios: 'chevron.left', android: 'chevron_left', web: 'chevron_left' }} tintColor={EDM.white} size={18} />
            <Text style={styles.backText}>Retour</Text>
          </Pressable>
          <HeroTitle title="Mon" highlight="Profil" subtitle="Gère tes informations et ton parcours EDM" />
        </View>
      )}>
      <Animated.View entering={FadeInDown.duration(320)} style={styles.identity}>
        <Pressable onPress={() => void pickPhoto()} disabled={uploading} accessibilityLabel="Changer ma photo de profil">
          <LinearGradient colors={['#F7D774', '#E2A92B', '#B97E0C']} style={styles.avatarRing}>
            {profile?.avatar_url ? (
              <Image source={{ uri: profile.avatar_url }} style={styles.avatar} contentFit="cover" transition={200} />
            ) : (
              <View style={[styles.avatar, styles.avatarEmpty]}>
                <Text style={styles.initial}>{fullName.trim().charAt(0).toUpperCase()}</Text>
              </View>
            )}
          </LinearGradient>
          <LinearGradient colors={[EDM.red, EDM.redDark]} style={styles.editBadge}>
            {uploading ? <ActivityIndicator color={EDM.white} size="small" /> : <SymbolView name={{ ios: 'camera.fill', android: 'photo_camera', web: 'photo_camera' }} tintColor={EDM.white} size={18} />}
          </LinearGradient>
        </Pressable>
        <Text style={styles.name}>{fullName}</Text>
        <Text style={styles.ministry}>Élite Doniel Ministries</Text>
      </Animated.View>

      {message ? <Text style={styles.error}>{message}</Text> : null}

      {menu.map((item, index) => (
        <Animated.View key={item.key} entering={FadeInDown.delay(60 + index * 50).duration(300)}>
          <Card3D onPress={item.onPress} style={styles.row}>
            <View style={styles.rowIcon}><SymbolView name={item.icon} tintColor={EDM.red} size={28} /></View>
            <View style={{ flex: 1, gap: 2 }}>
              <Text style={styles.rowTitle}>{item.title}</Text>
              <Text style={styles.rowSubtitle} numberOfLines={2}>{item.subtitle}</Text>
            </View>
            <SymbolView name={item.open ? { ios: 'chevron.down', android: 'expand_more', web: 'expand_more' } : { ios: 'chevron.right', android: 'chevron_right', web: 'chevron_right' }} tintColor={EDM.red} size={24} />
          </Card3D>
          {item.key === 'infos' && panel === 'infos' ? (
            <View style={styles.panel}>
              <Info label="Nom complet" value={fullName} />
              <Info label="Numéro de téléphone" value={phone} />
              <Info label="Statut" value={profile?.role === 'cadre' ? 'Cadre' : profile?.role === 'member' || !profile?.role ? 'Élite' : profile.role} />
            </View>
          ) : null}
          {item.key === 'attestations' && panel === 'attestations' ? (
            <View style={styles.panel}>
              {completed.length === 0 ? (
                <Text style={styles.panelText}>Aucune attestation pour le moment. Termine une formation pour recevoir ton certificat d&apos;Élite Charismatique du Dieu Vivant.</Text>
              ) : completed.map((key) => (
                <View key={key} style={styles.certificate}>
                  <Text style={styles.certificateIcon}>🏅</Text>
                  <Text style={styles.panelText}>{FORMATION_CARDS.find((c) => c.key === key)?.title ?? key} — formation terminée</Text>
                </View>
              ))}
            </View>
          ) : null}
          {item.key === 'parametres' && panel === 'parametres' ? (
            <View style={styles.panel}>
              <Pressable onPress={() => void Linking.openURL('https://wa.me/2250713224804')}><Text style={styles.link}>💬 Contacter EDM sur WhatsApp</Text></Pressable>
              <Pressable onPress={() => void Linking.openURL('https://edm-ecdv.site')}><Text style={styles.link}>🌐 Visiter le site edm-ecdv.site</Text></Pressable>
              <Text style={styles.panelText}>Version de l&apos;application : {Constants.expoConfig?.version ?? '1.0.0'}</Text>
            </View>
          ) : null}
        </Animated.View>
      ))}

      {editing ? (
        <Card3D style={{ gap: 10 }}>
          <Text style={styles.rowTitle}>Modifier mon nom</Text>
          <TextInput value={name} onChangeText={setName} placeholder="Nom complet" placeholderTextColor={EDM.textMuted} style={styles.input} autoFocus />
          <PrimaryButton label={busy ? 'Enregistrement...' : 'Enregistrer'} onPress={() => void saveName()} disabled={busy || !name.trim()} />
          <Pressable onPress={() => setEditing(false)}><Text style={[styles.link, { textAlign: 'center' }]}>Annuler</Text></Pressable>
        </Card3D>
      ) : (
        <Pressable onPress={() => { void Haptics.selectionAsync(); setName(profile?.full_name ?? ''); setEditing(true); }} style={({ pressed }) => [styles.outline, pressed && { opacity: 0.8 }]}>
          <SymbolView name={{ ios: 'square.and.pencil', android: 'edit_square', web: 'edit_square' }} tintColor={EDM.red} size={24} />
          <Text style={styles.outlineText}>Modifier mon profil</Text>
        </Pressable>
      )}

      <PrimaryButton label="Se déconnecter" icon={{ ios: 'rectangle.portrait.and.arrow.right', android: 'logout', web: 'logout' }} onPress={() => void logout()} />
    </HeroScreen>
  );
}

function Info({ label, value }: { label: string; value: string }) {
  return (
    <View style={{ gap: 3 }}>
      <Text style={styles.infoLabel}>{label.toUpperCase()}</Text>
      <Text style={styles.infoValue}>{value}</Text>
    </View>
  );
}

const styles = StyleSheet.create({
  back: { flexDirection: 'row', alignItems: 'center', gap: 4, alignSelf: 'flex-start' },
  backText: { color: EDM.white, fontSize: 14, fontWeight: '700' },
  identity: { alignItems: 'center', gap: 4, marginTop: -6 },
  avatarRing: { width: 138, height: 138, borderRadius: 69, padding: 5, shadowColor: '#7A2E1A', shadowOpacity: 0.3, shadowRadius: 14, shadowOffset: { width: 0, height: 8 }, elevation: 8 },
  avatar: { width: '100%', height: '100%', borderRadius: 64, borderWidth: 3, borderColor: EDM.white },
  avatarEmpty: { backgroundColor: EDM.creamDark, alignItems: 'center', justifyContent: 'center' },
  initial: { color: EDM.red, fontSize: 54, fontWeight: '900' },
  editBadge: { position: 'absolute', right: 2, bottom: 6, width: 42, height: 42, borderRadius: 21, alignItems: 'center', justifyContent: 'center', borderWidth: 3, borderColor: EDM.white },
  name: { color: '#13235B', fontSize: 26, fontWeight: '900', marginTop: 8, textAlign: 'center' },
  ministry: { color: '#8A5A2B', fontSize: 18, fontWeight: '800' },
  error: { color: EDM.red, fontSize: 13, textAlign: 'center' },
  row: { flexDirection: 'row', alignItems: 'center', gap: 14, paddingVertical: 12 },
  rowIcon: { width: 56, height: 56, borderRadius: 18, backgroundColor: '#FBEDEA', alignItems: 'center', justifyContent: 'center' },
  rowTitle: { color: '#13235B', fontSize: 17, fontWeight: '900' },
  rowSubtitle: { color: EDM.textSecondary, fontSize: 13.5 },
  panel: { marginTop: -8, marginHorizontal: 8, padding: 16, paddingTop: 20, gap: 12, backgroundColor: '#FFF8EE', borderBottomLeftRadius: 18, borderBottomRightRadius: 18, borderWidth: 1, borderTopWidth: 0, borderColor: '#F1E6D2' },
  panelText: { color: EDM.textSecondary, fontSize: 14, lineHeight: 20, flex: 1 },
  infoLabel: { color: EDM.textMuted, fontSize: 10.5, fontWeight: '800', letterSpacing: 1 },
  infoValue: { color: EDM.text, fontSize: 16, fontWeight: '700' },
  certificate: { flexDirection: 'row', alignItems: 'center', gap: 10 },
  certificateIcon: { fontSize: 26 },
  link: { color: EDM.red, fontSize: 15, fontWeight: '800' },
  input: { borderWidth: 1.5, borderColor: EDM.borderStrong, borderRadius: 14, paddingHorizontal: 14, paddingVertical: 12, fontSize: 16, color: EDM.text, backgroundColor: EDM.cream },
  outline: { flexDirection: 'row', alignItems: 'center', justifyContent: 'center', gap: 12, borderWidth: 2, borderColor: EDM.red, borderRadius: 30, paddingVertical: 15, backgroundColor: EDM.white },
  outlineText: { color: EDM.red, fontSize: 18, fontWeight: '900' },
});
