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
        tabBarInactiveTintColor: '#7A4A2A',
        tabBarStyle: {
          position: 'absolute',
          left: 12,
          right: 12,
          bottom: Platform.OS === 'ios' ? 18 : 10,
          height: 68,
          borderRadius: 26,
          backgroundColor: EDM.white,
          borderTopWidth: 0,
          paddingTop: 8,
          paddingBottom: 8,
          shadowColor: '#7A2E1A',
          shadowOpacity: 0.18,
          shadowRadius: 16,
          shadowOffset: { width: 0, height: 6 },
          elevation: 12,
        },
        tabBarLabelStyle: { fontSize: 11.5, fontWeight: '800', marginTop: 2 },
        tabBarIcon: ({ color, size, focused }) => (
          <View style={{ width: 30, height: 28, alignItems: 'center', justifyContent: 'flex-end' }}>
            
            <SymbolView name={tabIcons[route.name as keyof typeof tabIcons]} tintColor={color} size={size} />
            {focused ? <View style={{ position: 'absolute', bottom: -30, width: 46, height: 4, borderRadius: 2, backgroundColor: EDM.red }} /> : null}
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