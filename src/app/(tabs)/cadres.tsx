import { useEffect, useState } from 'react';
import { Pressable, StyleSheet, Text, View } from 'react-native';
import { SymbolView } from 'expo-symbols';
import * as Haptics from 'expo-haptics';

import { ActionButton, BrandHeader, Card, Heading, LoadingState, Notice, Screen } from '@/components/edm-ui';
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

  return (
    <Screen refreshing={refreshing} onRefresh={() => { setRefreshing(true); setRefreshKey((key) => key + 1); }}>
      <BrandHeader />
      <Heading eyebrow="Parcours Disciples EDM" title="Formation des Cadres" />
      <View style={styles.requirementHeading}>
        <Text style={styles.eyebrow}>Prérequis obligatoires</Text>
        <Text style={styles.requirementText}>Les 3 Formations EDM et la Formation en Discipulat</Text>
      </View>
      {loading ? <LoadingState /> : (
        <View style={styles.statusRow}>
          <SymbolView
            name={{ ios: ready ? 'checkmark.circle.fill' : 'lock.fill', android: ready ? 'check_circle' : 'lock', web: ready ? 'check_circle' : 'lock' }}
            tintColor={ready ? EDM.green : EDM.red}
            size={24}
          />
          <Text style={styles.statusText}>{ready ? 'Prérequis validés' : 'Complète les formations pour continuer'}</Text>
        </View>
      )}

      <Text style={styles.eyebrow}>Nos Départements</Text>
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
              style={({ pressed }) => [
                styles.departmentPressable,
                selected && styles.departmentSelected,
                pressed && styles.pressed,
              ]}>
              <Card style={styles.departmentCard}>
                <View style={[styles.departmentIcon, { backgroundColor: selected ? EDM.red : EDM.creamDark }]}>
                  <SymbolView name={{ ios: 'star.fill', android: department.icon, web: department.icon }} tintColor={selected ? EDM.white : EDM.gold} size={20} />
                </View>
                <Text style={styles.departmentTitle}>{department.title}</Text>
                <Text style={styles.departmentDescription}>{department.description}</Text>
              </Card>
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
          <ActionButton
            label={saving ? 'Envoi...' : 'Confirmer mon choix de département'}
            onPress={() => void submitDepartment()}
            disabled={!selectedDepartment || saving}
          />
        </>
      ) : (
        <Card>
          <Text style={styles.cardText}>Complète les formations et les questionnaires pour demander à rejoindre un département et devenir Cadre.</Text>
        </Card>
      )}
    </Screen>
  );
}

const styles = StyleSheet.create({
  requirementHeading: { gap: 6 },
  eyebrow: { color: EDM.red, fontSize: 10, fontWeight: '800', letterSpacing: 1.5, textTransform: 'uppercase' },
  requirementText: { color: EDM.textSecondary, fontSize: 13, lineHeight: 20 },
  statusRow: { minHeight: 52, flexDirection: 'row', alignItems: 'center', gap: 10, paddingHorizontal: 14, borderRadius: 12, backgroundColor: EDM.white },
  statusText: { flex: 1, color: EDM.text, fontSize: 13, fontWeight: '700' },
  departments: { flexDirection: 'row', flexWrap: 'wrap', gap: 10 },
  departmentPressable: { width: '48%', borderRadius: 14 },
  departmentSelected: { borderColor: EDM.red, borderRadius: 14, borderWidth: 2 },
  departmentCard: { flex: 1, padding: 12 },
  departmentIcon: { width: 38, height: 38, alignItems: 'center', justifyContent: 'center', borderRadius: 11 },
  departmentTitle: { color: EDM.text, fontSize: 12, fontWeight: '800' },
  departmentDescription: { color: EDM.textMuted, fontSize: 10, lineHeight: 15 },
  pressed: { opacity: 0.75 },
  noticeText: { color: EDM.textSecondary, fontSize: 12, lineHeight: 19 },
  cardText: { color: EDM.textSecondary, fontSize: 12, lineHeight: 19 },
});
