import { StyleSheet, Text, View } from 'react-native';
import { Image } from 'expo-image';

import { BrandHeader, Card, Heading, Screen } from '@/components/edm-ui';
import { EDM } from '@/constants/edm';

export default function SupportScreen() {
  return (
    <Screen>
      <BrandHeader />
      <Heading eyebrow="Soutenir la vision EDM" title="Devenir Donateur" />
      <Card style={styles.quoteCard}>
        <Text style={styles.quote}>
          « Que chacun donne comme il l&apos;a résolu en son cœur... car Dieu aime celui qui donne avec joie. »
        </Text>
        <Text style={styles.reference}>2 Cor. 9:7</Text>
      </Card>
      <View style={styles.impact}>
        <Image source={require('@/assets/images/edm-logo.png')} style={styles.logo} contentFit="contain" />
        <Text style={styles.impactTitle}>Soutenir la vision EDM</Text>
        <Text style={styles.impactBody}>
          Votre don soutient nos programmes d&apos;Impact, de Guérison et d&apos;Évangélisation.
        </Text>
      </View>
      <Card>
        <Text style={styles.contactTitle}>Merci pour ton soutien</Text>
        <Text style={styles.contactBody}>
          Les modalités de soutien sont communiquées par l&apos;équipe Élite Doniel Ministries.
        </Text>
      </Card>
    </Screen>
  );
}

const styles = StyleSheet.create({
  quoteCard: { borderLeftColor: EDM.gold, borderLeftWidth: 4 },
  quote: { color: EDM.textSecondary, fontSize: 14, fontStyle: 'italic', lineHeight: 22 },
  reference: { color: EDM.gold, fontSize: 11, fontWeight: '800' },
  impact: { alignItems: 'center', gap: 10, paddingVertical: 20, paddingHorizontal: 10 },
  logo: { width: 92, height: 92 },
  impactTitle: { color: EDM.text, fontSize: 18, fontWeight: '800', textAlign: 'center' },
  impactBody: { color: EDM.textSecondary, fontSize: 13, lineHeight: 20, textAlign: 'center' },
  contactTitle: { color: EDM.red, fontSize: 14, fontWeight: '800' },
  contactBody: { color: EDM.textSecondary, fontSize: 12, lineHeight: 19 },
});
