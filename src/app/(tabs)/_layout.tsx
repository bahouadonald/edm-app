import { Tabs } from 'expo-router';
import { SymbolView } from 'expo-symbols';
import { Platform, View } from 'react-native';
import * as Haptics from 'expo-haptics';

import { EDM } from '@/constants/edm';

const tabIcons = {
  index: { ios: 'house.fill', android: 'home', web: 'home' },
  formations: { ios: 'book.closed.fill', android: 'menu_book', web: 'menu_book' },
  cadres: { ios: 'person.3.fill', android: 'groups', web: 'groups' },
  soutenir: { ios: 'heart.fill', android: 'favorite', web: 'favorite' },
} as const;

export default function TabLayout() {
  return (
    <Tabs
      screenListeners={{ tabPress: () => { void Haptics.selectionAsync(); } }}
      screenOptions={({ route }) => ({
        headerShown: false,
        tabBarActiveTintColor: EDM.red,
        tabBarInactiveTintColor: EDM.textMuted,
        tabBarStyle: {
          backgroundColor: EDM.white,
          borderTopColor: EDM.border,
          paddingTop: 6,
          paddingBottom: Platform.OS === 'ios' ? 4 : 7,
        },
        tabBarLabelStyle: { fontSize: 10, fontWeight: '700', marginTop: 1 },
        tabBarIcon: ({ color, size, focused }) => (
          <View style={{ width: 30, height: 28, alignItems: 'center', justifyContent: 'flex-end' }}>
            {focused ? <View style={{ position: 'absolute', top: -7, width: 20, height: 3, borderRadius: 2, backgroundColor: EDM.red }} /> : null}
            <SymbolView name={tabIcons[route.name as keyof typeof tabIcons]} tintColor={color} size={size} />
          </View>
        ),
      })}>
      <Tabs.Screen name="index" options={{ title: 'Accueil' }} />
      <Tabs.Screen name="formations" options={{ title: 'Formations' }} />
      <Tabs.Screen name="cadres" options={{ title: 'Cadres' }} />
      <Tabs.Screen name="soutenir" options={{ title: 'Soutenir' }} />
    </Tabs>
  );
}