import type { Session, User } from '@supabase/supabase-js';
import { createContext, useContext, useEffect, useState } from 'react';

import { supabase } from '@/lib/supabase';

export type Profile = {
  id: string;
  full_name: string;
  phone: string | null;
  role: string;
  podcast_validated?: boolean;
  spirituel_validated?: boolean;
  dept_choisi?: string | null;
  dept_confirme?: string | null;
};

type AuthContextValue = {
  user: User | null;
  profile: Profile | null;
  loading: boolean;
  signIn: (credentials: { phone: string; password: string }) => Promise<void>;
  signUp: (credentials: {
    phone: string;
    password: string;
    fullName: string;
  }) => Promise<void>;
  signOut: () => Promise<void>;
  refreshProfile: () => Promise<void>;
};

const AuthContext = createContext<AuthContextValue | null>(null);

function phoneToEmail(phone: string) {
  return `${phone.replace(/\\s/g, '')}@edm.app`;
}

export function AuthProvider({ children }: { children: React.ReactNode }) {
  const [user, setUser] = useState<User | null>(null);
  const [profile, setProfile] = useState<Profile | null>(null);
  const [loading, setLoading] = useState(true);

  const loadProfile = async (authUser: User) => {
    const { data } = await supabase
      .from('profiles')
      .select('*')
      .eq('id', authUser.id)
      .maybeSingle();

    if (data) {
      setProfile(data as Profile);
      return;
    }

    const email = authUser.email ?? '';
    const phone = email.replace('@edm.app', '');
    const fullName = authUser.user_metadata?.full_name || phone || 'Membre';
    const { data: created } = await supabase
      .from('profiles')
      .insert({ id: authUser.id, full_name: fullName, phone, role: 'member' })
      .select('*')
      .single();

    if (created) setProfile(created as Profile);
  };

  useEffect(() => {
    let mounted = true;
    let activeRequest = 0;
    const applySession = async (session: Session | null) => {
      if (!mounted) return;
      const requestId = ++activeRequest;
      const nextUser = session?.user ?? null;
      if (!nextUser) {
        setUser(null);
        setProfile(null);
        setLoading(false);
        return;
      }

      setLoading(true);
      try {
        await loadProfile(nextUser);
        if (mounted && requestId === activeRequest) setUser(nextUser);
      } finally {
        if (mounted && requestId === activeRequest) setLoading(false);
      }
    };

    void supabase.auth.getSession().then(({ data }) => applySession(data.session));
    const {
      data: { subscription },
    } = supabase.auth.onAuthStateChange((_event, session) => {
      setTimeout(() => void applySession(session), 0);
    });

    return () => {
      mounted = false;
      subscription.unsubscribe();
    };
  }, []);

  const signIn = async ({ phone, password }: { phone: string; password: string }) => {
    const { error } = await supabase.auth.signInWithPassword({
      email: phoneToEmail(phone),
      password,
    });
    if (error) throw error;
  };

  const signUp = async ({
    phone,
    password,
    fullName,
  }: {
    phone: string;
    password: string;
    fullName: string;
  }) => {
    const { data, error } = await supabase.auth.signUp({
      email: phoneToEmail(phone),
      password,
      options: { data: { full_name: fullName } },
    });
    if (error) throw error;

    if (data.user) {
      await supabase.from('profiles').insert({
        id: data.user.id,
        full_name: fullName,
        phone,
        role: 'member',
      });
    }
  };

  const signOut = async () => {
    const { error } = await supabase.auth.signOut();
    if (error) throw error;
    setUser(null);
    setProfile(null);
  };

  const refreshProfile = async () => {
    if (user) await loadProfile(user);
  };

  return (
    <AuthContext.Provider
      value={{ user, profile, loading, signIn, signUp, signOut, refreshProfile }}>
      {children}
    </AuthContext.Provider>
  );
}

export function useAuth() {
  const context = useContext(AuthContext);
  if (!context) throw new Error('useAuth must be used inside AuthProvider.');
  return context;
}
