-- =====================================================================
-- EDM · ÉTAPE 1b (SANS RISQUE) — PHOTO DE PROFIL
-- Ajoute la colonne avatar_url et l'espace de stockage « avatars ».
-- Chaque membre ne peut déposer ou remplacer QUE sa propre photo.
-- À exécuter dans Supabase > SQL Editor (projet EDM-ECDV)
-- =====================================================================
ALTER TABLE public.profiles ADD COLUMN IF NOT EXISTS avatar_url TEXT;

INSERT INTO storage.buckets (id, name, public)
VALUES ('avatars', 'avatars', true)
ON CONFLICT (id) DO NOTHING;

DROP POLICY IF EXISTS "avatars_lire" ON storage.objects;
CREATE POLICY "avatars_lire" ON storage.objects
  FOR SELECT USING (bucket_id = 'avatars');

DROP POLICY IF EXISTS "avatars_deposer_la_sienne" ON storage.objects;
CREATE POLICY "avatars_deposer_la_sienne" ON storage.objects
  FOR INSERT TO authenticated
  WITH CHECK (bucket_id = 'avatars' AND (storage.foldername(name))[1] = auth.uid()::text);

DROP POLICY IF EXISTS "avatars_remplacer_la_sienne" ON storage.objects;
CREATE POLICY "avatars_remplacer_la_sienne" ON storage.objects
  FOR UPDATE TO authenticated
  USING (bucket_id = 'avatars' AND (storage.foldername(name))[1] = auth.uid()::text)
  WITH CHECK (bucket_id = 'avatars' AND (storage.foldername(name))[1] = auth.uid()::text);

DROP POLICY IF EXISTS "avatars_supprimer_la_sienne" ON storage.objects;
CREATE POLICY "avatars_supprimer_la_sienne" ON storage.objects
  FOR DELETE TO authenticated
  USING (bucket_id = 'avatars' AND (storage.foldername(name))[1] = auth.uid()::text);
