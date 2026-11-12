import { useAudioPlayer, useAudioPlayerStatus } from 'expo-audio';
import * as Haptics from 'expo-haptics';
import { SymbolView } from 'expo-symbols';
import { useEffect, useRef } from 'react';
import { Pressable, StyleSheet, Text, View } from 'react-native';

import { EDM } from '@/constants/edm';

function formatTime(seconds: number) {
  if (!Number.isFinite(seconds) || seconds < 0) return '0:00';
  const total = Math.floor(seconds);
  const h = Math.floor(total / 3600);
  const m = Math.floor((total % 3600) / 60);
  const s = String(total % 60).padStart(2, '0');
  return h > 0 ? `${h}:${String(m).padStart(2, '0')}:${s}` : `${m}:${s}`;
}

type Props = {
  uri: string;
  title: string;
  /** Appelé une seule fois, quand l'écoute atteint 90 % de la durée. */
  onListened?: () => void;
};

export function ModuleAudioPlayer({ uri, title, onListened }: Props) {
  const player = useAudioPlayer(uri);
  const status = useAudioPlayerStatus(player);
  const reported = useRef(false);

  const duration = status.duration || 0;
  const current = status.currentTime || 0;
  const ratio = duration > 0 ? Math.min(current / duration, 1) : 0;

  useEffect(() => {
    if (!reported.current && duration > 0 && ratio >= 0.9) {
      reported.current = true;
      onListened?.();
    }
  }, [duration, ratio, onListened]);

  const toggle = () => {
    void Haptics.selectionAsync();
    if (status.playing) {
      player.pause();
    } else {
      if (status.didJustFinish || (duration > 0 && current >= duration - 0.5)) void player.seekTo(0);
      player.play();
    }
  };

  const skip = (delta: number) => {
    void Haptics.selectionAsync();
    void player.seekTo(Math.max(0, Math.min(duration || 0, current + delta)));
  };

  return (
    <View style={styles.card}>
      <View style={styles.header}>
        <View style={styles.badge}>
          <SymbolView name={{ ios: 'headphones', android: 'headphones', web: 'headphones' }} tintColor={EDM.white} size={18} />
        </View>
        <View style={styles.headerText}>
          <Text style={styles.eyebrow}>Enseignement audio</Text>
          <Text style={styles.title} numberOfLines={2}>{title}</Text>
        </View>
      </View>

      <View style={styles.track}>
        <View style={[styles.fill, { width: `${ratio * 100}%` }]} />
      </View>
      <View style={styles.times}>
        <Text style={styles.time}>{formatTime(current)}</Text>
        <Text style={styles.time}>{status.isLoaded ? formatTime(duration) : 'Chargement...'}</Text>
      </View>

      <View style={styles.controls}>
        <Pressable onPress={() => skip(-15)} style={styles.skip} accessibilityLabel="Reculer de 15 secondes">
          <SymbolView name={{ ios: 'gobackward.15', android: 'replay', web: 'replay' }} tintColor={EDM.textSecondary} size={24} />
          <Text style={styles.skipText}>15 s</Text>
        </Pressable>
        <Pressable onPress={toggle} style={styles.play} accessibilityLabel={status.playing ? 'Pause' : 'Lecture'}>
          <SymbolView
            name={status.playing
              ? { ios: 'pause.fill', android: 'pause', web: 'pause' }
              : { ios: 'play.fill', android: 'play_arrow', web: 'play_arrow' }}
            tintColor={EDM.white}
            size={30}
          />
        </Pressable>
        <Pressable onPress={() => skip(15)} style={styles.skip} accessibilityLabel="Avancer de 15 secondes">
          <SymbolView name={{ ios: 'goforward.15', android: 'forward_media', web: 'forward_media' }} tintColor={EDM.textSecondary} size={24} />
          <Text style={styles.skipText}>15 s</Text>
        </Pressable>
      </View>
    </View>
  );
}

const styles = StyleSheet.create({
  card: {
    backgroundColor: EDM.white,
    borderRadius: 22,
    padding: 18,
    gap: 12,
    borderWidth: 1,
    borderColor: EDM.goldLight,
    shadowColor: EDM.redDark,
    shadowOpacity: 0.16,
    shadowRadius: 18,
    shadowOffset: { width: 0, height: 8 },
    elevation: 6,
  },
  header: { flexDirection: 'row', alignItems: 'center', gap: 12 },
  badge: {
    width: 42,
    height: 42,
    borderRadius: 14,
    backgroundColor: EDM.red,
    alignItems: 'center',
    justifyContent: 'center',
    shadowColor: EDM.red,
    shadowOpacity: 0.35,
    shadowRadius: 8,
    shadowOffset: { width: 0, height: 4 },
    elevation: 4,
  },
  headerText: { flex: 1, gap: 2 },
  eyebrow: { color: EDM.gold, fontSize: 11, fontWeight: '800', letterSpacing: 1, textTransform: 'uppercase' },
  title: { color: EDM.text, fontSize: 15, fontWeight: '800' },
  track: { height: 6, borderRadius: 3, backgroundColor: EDM.creamDeep, overflow: 'hidden' },
  fill: { height: 6, borderRadius: 3, backgroundColor: EDM.red },
  times: { flexDirection: 'row', justifyContent: 'space-between' },
  time: { color: EDM.textMuted, fontSize: 12, fontVariant: ['tabular-nums'] },
  controls: { flexDirection: 'row', alignItems: 'center', justifyContent: 'center', gap: 28 },
  skip: { alignItems: 'center', gap: 2, padding: 6 },
  skipText: { color: EDM.textMuted, fontSize: 10, fontWeight: '700' },
  play: {
    width: 66,
    height: 66,
    borderRadius: 33,
    backgroundColor: EDM.red,
    alignItems: 'center',
    justifyContent: 'center',
    borderWidth: 3,
    borderColor: EDM.goldLight,
    shadowColor: EDM.red,
    shadowOpacity: 0.45,
    shadowRadius: 14,
    shadowOffset: { width: 0, height: 6 },
    elevation: 8,
  },
});
