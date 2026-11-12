import { router } from 'expo-router';
import { StyleSheet, Text, View } from 'react-native';
import { Image } from 'expo-image';
import { SymbolView } from 'expo-symbols';

import { ActionButton, Card, Heading, Screen } from '@/components/edm-ui';
import { EDM } from '@/constants/edm';
import { useAuth } from '@/contexts/auth-context';

export default function ProfileScreen() {
  const { user, profile, signOut } = useAuth();
  const phone = profile?.phone || user?.email?.replace('@edm.app', '') || 'Numéro non disponible';

  const logout = async () => {
    await signOut();
    router.replace('/');
  };

  return (
    <Screen>
      <View style={styles.topBar}>
        <Image source={require('@/assets/images/edm-logo.png')} style={styles.logo} contentFit="contain" />
        <Text style={styles.brand}>EDM</Text>
        <View style={{ flex: 1 }} />
        <SymbolView name={{ ios: 'person.crop.circle.fill', android: 'account_circle', web: 'account_circle' }} tintColor={EDM.red} size={27} />
      </View>
      <Heading eyebrow="Compte" title="Mon profil" subtitle="Élite Doniel Ministries" />
      <Card style={styles.profileCard}>
        <View style={styles.avatar}>
          <Text style={styles.initial}>{profile?.full_name?.trim().charAt(0).toUpperCase() || 'E'}</Text>
        </View>
        <View style={styles.detail}>
          <Text style={styles.label}>NOM COMPLET</Text>
          <Text style={styles.value}>{profile?.full_name || user?.user_metadata?.full_name || 'Membre EDM'}</Text>
        </View>
        <View style={styles.divider} />
        <View style={styles.detail}>
          <Text style={styles.label}>NUMÉRO DE TÉLÉPHONE</Text>
          <Text style={styles.value}>{phone}</Text>
        </View>
      </Card>
      <ActionButton label="Se déconnecter" onPress={() => void logout()} secondary />
    </Screen>
  );
}

const styles = StyleSheet.create({
  topBar: { minHeight: 44, flexDirection: 'row', alignItems: 'center', gap: 8 },
  logo: { width: 36, height: 36 },
  brand: { color: EDM.red, fontSize: 15, fontWeight: '900' },
  profileCard: { alignItems: 'center', paddingVertical: 24, gap: 20 },
  avatar: { width: 76, height: 76, alignItems: 'center', justifyContent: 'center', borderRadius: 38, backgroundColor: EDM.creamDark },
  initial: { color: EDM.red, fontSize: 31, fontWeight: '900' },
  detail: { alignSelf: 'stretch', gap: 6 },
  label: { color: EDM.textMuted, fontSize: 10, fontWeight: '800', letterSpacing: 1.2 },
  value: { color: EDM.text, fontSize: 15, fontWeight: '700' },
  divider: { alignSelf: 'stretch', height: StyleSheet.hairlineWidth, backgroundColor: EDM.border },
});
