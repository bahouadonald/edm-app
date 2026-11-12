import { Redirect, usePathname } from 'expo-router';
import type { Href } from 'expo-router';
import type { PropsWithChildren } from 'react';

import { LoadingState } from '@/components/edm-ui';
import { useAuth } from '@/contexts/auth-context';

export function RequireAuth({ children }: PropsWithChildren) {
  const { user, loading } = useAuth();
  const pathname = usePathname();

  if (loading) return <LoadingState />;
  if (!user) {
    return <Redirect href={{ pathname: '/auth', params: { returnTo: pathname } } as unknown as Href} />;
  }

  return children;
}