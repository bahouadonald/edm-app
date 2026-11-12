import { Stack } from 'expo-router';
import { StatusBar } from 'expo-status-bar';

import { AuthProvider } from '@/contexts/auth-context';
import { EDM } from '@/constants/edm';

export default function RootLayout() {
  return (
    <AuthProvider>
      <StatusBar style="dark" />
      <Stack
        screenOptions={{
          headerShown: false,
          animation: 'slide_from_right',
          animationDuration: 260,
          contentStyle: { backgroundColor: EDM.cream },
        }}>
        <Stack.Screen name="(tabs)" />
        <Stack.Screen name="auth" />
        <Stack.Screen name="profil" />
        <Stack.Screen name="formation/[formation]" />
      </Stack>
    </AuthProvider>
  );
}
