import { Image } from 'expo-image';
import { LinearGradient } from 'expo-linear-gradient';
import * as Linking from 'expo-linking';
import { StyleSheet, Text, View } from 'react-native';

import { Card3D, GlossyIcon, HeroScreen, HeroTitle, PrimaryButton } from '@/components/edm-3d';
import { EDM } from '@/constants/edm';

const pillars = [
  { label: 'Formations et Équipes', icon: { ios: 'graduationcap.fill', android: 'school', web: 'school' }, colors: ['#C8102E', '#8B0A1F'] },
  { label: 'Accompagnement des Cadres', icon: { ios: 'person.3.fill', android: 'groups', web: 'groups' }, colors: ['#E2A92B', '#B97E0C'] },
  { label: 'Évangélisation et Impact', icon: { ios: 'megaphone.fill', android: 'campaign', web: 'campaign' }, colors: ['#C8102E', '#8B0A1F'] },
] as const;

export default function SupportScreen() {
  return (
    <HeroScreen
      illustration={require('@/assets/images/illus/hero-soutenir.png')}
      hero={<HeroTitle eyebrow="SOUTENIR LA VISION EDM" title="Devenir" highlight="Donateur" />}>
      <Card3D style={styles.quoteCard}>
        <Image source={require('@/assets/images/illus/quote-bible.png')} style={styles.quoteImage} contentFit="cover" />
        <LinearGradient colors={['#FFFFFF', 'rgba(255,255,255,0.92)', 'rgba(255,255,255,0)']} start={{ x: 0, y: 0.5 }} end={{ x: 1, y: 0.5 }} style={StyleSheet.absoluteFill} />
        <Text style={styles.quote}><Text style={styles.quoteMark}>❝ </Text>« Que chacun donne comme il l&apos;a résolu en son cœur, sans tristesse ni contrainte ; car Dieu aime celui qui donne avec joie. »</Text>
        <LinearGradient colors={[EDM.red, EDM.redDark]} style={styles.reference}><Text style={styles.referenceText}>2 Cor. 9:7</Text></LinearGradient>
      </Card3D>

      <View style={styles.impact}>
        <View style={styles.logoCard}><Image source={require('@/assets/images/edm-logo.png')} style={styles.logo} contentFit="contain" /></View>
        <Text style={styles.impactTitle}>Soutenir la vision EDM</Text>
        <View style={styles.underline} />
        <Text style={styles.impactBody}>Votre don soutient nos programmes d&apos;Impact, de Guérison et d&apos;Évangélisation.</Text>
      </View>

      <View style={styles.pillars}>
        {pillars.map((pillar) => (
          <LinearGradient key={pillar.label} colors={pillar.colors} style={styles.pillar}>
            <GlossyIcon icon={pillar.icon} colors={['rgba(255,255,255,0.25)', 'rgba(255,255,255,0.08)']} size={46} />
            <Text style={styles.pillarText}>{pillar.label}</Text>
          </LinearGradient>
        ))}
      </View>

      <Card3D style={styles.thanks}>
        <Text style={styles.thanksIcon}>🤝</Text>
        <View style={styles.thanksDivider} />
        <View style={{ flex: 1, gap: 3 }}>
          <Text style={styles.thanksTitle}>Merci pour ton soutien</Text>
          <Text style={styles.thanksBody}>Les modalités de soutien sont communiquées par l&apos;équipe Élite Doniel Ministries.</Text>
        </View>
      </Card3D>

      <PrimaryButton
        label="Soutenir maintenant"
        icon={{ ios: 'heart.fill', android: 'volunteer_activism', web: 'volunteer_activism' }}
        onPress={() => void Linking.openURL('https://wa.me/2250713224804?text=' + encodeURIComponent('Bonjour EDM, je souhaite soutenir la vision.'))}
      />
    </HeroScreen>
  );
}

const styles = StyleSheet.create({
  quoteCard: { gap: 12, overflow: 'hidden', borderWidth: 1.5, borderColor: '#E9C46A', minHeight: 150 },
  quoteImage: { position: 'absolute', right: 0, top: 0, bottom: 0, width: '50%' },
  quote: { color: EDM.text, fontSize: 16.5, lineHeight: 24, fontStyle: 'italic', fontWeight: '600', maxWidth: '88%' },
  quoteMark: { color: EDM.red, fontStyle: 'normal', fontWeight: '900' },
  reference: { alignSelf: 'flex-start', borderRadius: 10, paddingHorizontal: 12, paddingVertical: 5 },
  referenceText: { color: EDM.white, fontWeight: '900', fontSize: 15 },
  impact: { alignItems: 'center', gap: 8 },
  logoCard: { backgroundColor: EDM.white, borderRadius: 20, padding: 10, shadowColor: '#7A2E1A', shadowOpacity: 0.15, shadowRadius: 10, shadowOffset: { width: 0, height: 5 }, elevation: 4 },
  logo: { width: 170, height: 92 },
  impactTitle: { color: EDM.redDark, fontSize: 26, fontWeight: '900', textAlign: 'center' },
  underline: { width: 70, height: 4, borderRadius: 2, backgroundColor: EDM.gold },
  impactBody: { color: EDM.textSecondary, fontSize: 15, lineHeight: 22, textAlign: 'center', paddingHorizontal: 8 },
  pillars: { flexDirection: 'row', gap: 8 },
  pillar: { flex: 1, borderRadius: 18, paddingVertical: 14, paddingHorizontal: 6, alignItems: 'center', gap: 8, shadowColor: '#000', shadowOpacity: 0.2, shadowRadius: 8, shadowOffset: { width: 0, height: 5 }, elevation: 5 },
  pillarText: { color: EDM.white, fontSize: 13, fontWeight: '900', textAlign: 'center' },
  thanks: { flexDirection: 'row', alignItems: 'center', gap: 12 },
  thanksIcon: { fontSize: 36 },
  thanksDivider: { width: 2, alignSelf: 'stretch', backgroundColor: EDM.gold, borderRadius: 1 },
  thanksTitle: { color: EDM.red, fontSize: 18, fontWeight: '900' },
  thanksBody: { color: EDM.textSecondary, fontSize: 13.5, lineHeight: 19 },
});
