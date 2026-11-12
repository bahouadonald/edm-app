import { Tabs } from 'expo-router';
import { SymbolView } from 'expo-symbols';

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
      screenOptions={({ route }) => ({
        headerShown: false,
        tabBarActiveTintColor: EDM.red,
        tabBarInactiveTintColor: EDM.textMuted,
        tabBarStyle: {
          backgroundColor: EDM.white,
          borderTopColor: EDM.border,
          height: 66,
          paddingTop: 7,
          paddingBottom: 8,
        },
        tabBarLabelStyle: { fontSize: 10, fontWeight: '700' },
        tabBarIcon: ({ color, size }) => (
          <SymbolView name={tabIcons[route.name as keyof typeof tabIcons]} tintColor={color} size={size} />
        ),
      })}>
      <Tabs.Screen name="index" options={{ title: 'Accueil' }} />
      <Tabs.Screen name="formations" options={{ title: 'Formations' }} />
      <Tabs.Screen name="cadres" options={{ title: 'Cadres' }} />
      <Tabs.Screen name="soutenir" options={{ title: 'Soutenir' }} />
    </Tabs>
  );
}