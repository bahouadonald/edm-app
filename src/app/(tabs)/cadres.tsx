import { useEffect, useState } from 'react';
import { Pressable, StyleSheet, Text, View } from 'react-native';
import * as Haptics from 'expo-haptics';

import { Image } from 'expo-image';

import { Card3D, GlossyIcon, HeroScreen, HeroTitle, PrimaryButton, SectionTitle } from '@/components/edm-3d';
import { Notice } from '@/components/edm-ui';
import { RequireAuth } from '@/components/require-auth';
import { DEPARTMENTS, departmentName, EDM } from '@/constants/edm';
import { useAuth } from '@/contexts/auth-context';
import { supabase } from '@/lib/supabase';

const REQUIRED_FORMATIONS = ['formation', 'saison', 'spirituel', 'discipulat'];

type ModuleRow = { id: string; formation: string };
type ProgressRow = { module_id: string };

export default function CadresScreen() {
  return <RequireAuth><CadresContent /></RequireAuth>;
}

function CadresContent() {
  const { user, profile, refreshProfile } = useAuth();
  const [ready, setReady] = useState(false);
  const [loading, setLoading] = useState(true);
  const [selectedDepartment, setSelectedDepartment] = useState('');
  const [saving, setSaving] = useState(false);
  const [error, setError] = useState('');
  const [refreshing, setRefreshing] = useState(false);
  const [refreshKey, setRefreshKey] = useState(0);

  useEffect(() => {
    if (!user) return;
    let mounted = true;
    void Promise.all([
      supabase.from('formation_modules').select('id,formation').eq('actif', true),
      supabase.from('formation_module_progression').select('module_id').eq('user_id', user.id).eq('quiz_reussi', true),
    ]).then(([modulesResult, progressResult]) => {
      if (!mounted) return;
      const modules = (modulesResult.data ?? []) as ModuleRow[];
      const completed = new Set(((progressResult.data ?? []) as ProgressRow[]).map((row) => row.module_id));
      const allRequiredDone = REQUIRED_FORMATIONS.every((formation) => {
        const courseModules = modules.filter((module) => module.formation === formation);
        return courseModules.length > 0 && courseModules.every((module) => completed.has(module.id));
      });
      setReady(allRequiredDone);
      setLoading(false);
      setRefreshing(false);
    });
    return () => { mounted = false; };
  }, [refreshKey, user]);

  const submitDepartment = async () => {
    if (!user || !selectedDepartment) return;
    setSaving(true);
    setError('');
    const { error: updateError } = await supabase
      .from('profiles')
      .update({ dept_choisi: selectedDepartment })
      .eq('id', user.id);
    if (updateError) setError(updateError.message);
    else await refreshProfile();
    setSaving(false);
  };

  const deptImages: Record<string, number> = {
    hallel: require('@/assets/images/illus/hallel.png'),
    hatafa: require('@/assets/images/illus/hatafa.png'),
    hafaka: require('@/assets/images/illus/hafaka.png'),
    mimsad: require('@/assets/images/illus/mimsad.png'),
  };
  const deptColors: Record<string, readonly [string, string, string]> = {
    hallel: ['#F7C948', '#E2A92B', '#B97E0C'],
    hatafa: ['#E8344B', '#C8102E', '#8B0A1F'],
    hafaka: ['#9B5CF6', '#7C3AED', '#5B21B6'],
    mimsad: ['#2BB3A3', '#14917F', '#0B6B5E'],
  };

  return (
    <HeroScreen
      refreshing={refreshing}
      onRefresh={() => { setRefreshing(true); setRefreshKey((key) => key + 1); }}
      illustration={require('@/assets/images/illus/hero-cadres.png')}
      hero={<HeroTitle title="Formations des" highlight="Cadres" subtitle="Développe tes compétences et sers efficacement dans le Royaume." />}>
      <Card3D style={styles.requirement}>
        <GlossyIcon
          icon={ready ? { ios: 'checkmark.seal.fill', android: 'verified', web: 'verified' } : { ios: 'list.clipboard.fill', android: 'assignment_turned_in', web: 'assignment_turned_in' }}
          colors={ready ? ['#4CAF50', '#2E7D32', '#1B5E20'] : ['#E8344B', '#C8102E', '#8B0A1F']}
          size={54}
        />
        <View style={{ flex: 1, gap: 3 }}>
          <Text style={styles.requirementTitle}>{loading ? 'Vérification...' : ready ? 'Prérequis validés' : 'Prérequis obligatoires'}</Text>
          <Text style={styles.requirementText}>Les Formations EDM et la Formation en Discipulat doivent être complétées.</Text>
        </View>
      </Card3D>

      <SectionTitle icon={{ ios: 'square.grid.2x2.fill', android: 'grid_view', web: 'grid_view' }} title="Nos départements" />
      <View style={styles.departments}>
        {DEPARTMENTS.map((department) => {
          const selected = selectedDepartment === department.id;
          return (
            <Pressable
              key={department.id}
              accessibilityRole="radio"
              accessibilityState={{ selected }}
              disabled={!ready || Boolean(profile?.dept_choisi)}
              onPress={() => {
                void Haptics.selectionAsync();
                setSelectedDepartment(department.id);
              }}
              style={({ pressed }) => [styles.departmentSlot, pressed && styles.pressed]}>
              <View style={[styles.departmentCard, selected && styles.departmentSelected]}>
                <Image source={deptImages[department.id]} style={styles.departmentImage} contentFit="cover" />
                <View style={styles.departmentBadge}>
                  <GlossyIcon icon={{ ios: 'star.fill', android: department.icon, web: department.icon }} colors={deptColors[department.id]} size={36} />
                </View>
                <View style={styles.departmentBody}>
                  <Text style={styles.departmentTitle}><Text style={{ color: EDM.red }}>É</Text>{department.title.slice(1)}</Text>
                  <Text style={styles.departmentDescription}>{department.description}</Text>
                </View>
              </View>
            </Pressable>
          );
        })}
      </View>

      {profile?.dept_confirme ? (
        <Notice tone="green">
          <Text style={styles.noticeText}>Cadre confirmé · {departmentName(profile.dept_confirme)}</Text>
        </Notice>
      ) : profile?.dept_choisi ? (
        <Notice>
          <Text style={styles.noticeText}>Ta demande d&apos;intégration à {departmentName(profile.dept_choisi)} a été transmise. Elle sera examinée et confirmée prochainement.</Text>
        </Notice>
      ) : ready ? (
        <>
          {error ? <Notice tone="red"><Text style={styles.noticeText}>{error}</Text></Notice> : null}
          <PrimaryButton
            label={saving ? 'Envoi...' : 'Confirmer mon département'}
            icon={{ ios: 'checkmark.circle.fill', android: 'check_circle', web: 'check_circle' }}
            onPress={() => void submitDepartment()}
            disabled={!selectedDepartment || saving}
          />
        </>
      ) : (
        <Card3D style={styles.requirement}>
          <GlossyIcon icon={{ ios: 'scope', android: 'track_changes', web: 'track_changes' }} colors={['#E8344B', '#C8102E', '#8B0A1F']} size={48} />
          <Text style={[styles.requirementText, { flex: 1 }]}>Complète les formations et les questionnaires pour demander à rejoindre un département et devenir Cadre.</Text>
        </Card3D>
      )}
    </HeroScreen>
  );
}

const styles = StyleSheet.create({
  requirement: { flexDirection: 'row', alignItems: 'center', gap: 14 },
  requirementTitle: { color: EDM.text, fontSize: 17, fontWeight: '900' },
  requirementText: { color: EDM.textSecondary, fontSize: 13.5, lineHeight: 19 },
  departments: { flexDirection: 'row', flexWrap: 'wrap', justifyContent: 'space-between', rowGap: 14 },
  departmentSlot: { width: '48%' },
  departmentCard: {
    backgroundColor: EDM.white, borderRadius: 20, overflow: 'hidden', borderWidth: 2, borderColor: 'transparent',
    shadowColor: '#7A2E1A', shadowOpacity: 0.16, shadowRadius: 12, shadowOffset: { width: 0, height: 6 }, elevation: 5,
  },
  departmentSelected: { borderColor: EDM.red },
  departmentImage: { width: '100%', height: 92 },
  departmentBadge: { position: 'absolute', top: 70, left: 10 },
  departmentBody: { padding: 12, paddingTop: 18, gap: 3 },
  departmentTitle: { color: EDM.text, fontSize: 15.5, fontWeight: '900' },
  departmentDescription: { color: EDM.textSecondary, fontSize: 12.5, lineHeight: 17 },
  pressed: { opacity: 0.85, transform: [{ scale: 0.985 }] },
  noticeText: { color: EDM.textSecondary, fontSize: 13, lineHeight: 19 },
});
