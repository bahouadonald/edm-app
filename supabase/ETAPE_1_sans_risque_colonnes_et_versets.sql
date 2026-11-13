-- =====================================================================
-- EDM · ÉTAPE 1 (SANS RISQUE POUR LE SITE ACTUEL)
-- Ajoute les nouvelles colonnes et la Méditation du jour.
-- Ne modifie et ne supprime aucune donnée existante.
-- À exécuter dans Supabase > SQL Editor (projet EDM-ECDV)
-- =====================================================================
BEGIN;
-- 1. Nouvelles colonnes pour les 6 parties du module
ALTER TABLE public.formation_modules ADD COLUMN IF NOT EXISTS objectifs TEXT;
ALTER TABLE public.formation_modules ADD COLUMN IF NOT EXISTS resume TEXT;
ALTER TABLE public.formation_modules ADD COLUMN IF NOT EXISTS pratique TEXT;
ALTER TABLE public.formation_modules ADD COLUMN IF NOT EXISTS bilan_points TEXT;
ALTER TABLE public.formation_modules ADD COLUMN IF NOT EXISTS fin_de_semaine BOOLEAN NOT NULL DEFAULT false;

-- 2. Questions à 4 choix (A, B, C, D) avec explication de la correction
ALTER TABLE public.formation_questions ADD COLUMN IF NOT EXISTS option_d TEXT;
ALTER TABLE public.formation_questions ADD COLUMN IF NOT EXISTS explication TEXT;
ALTER TABLE public.formation_questions DROP CONSTRAINT IF EXISTS formation_questions_bonne_reponse_check;
ALTER TABLE public.formation_questions ADD CONSTRAINT formation_questions_bonne_reponse_check CHECK (bonne_reponse IN ('a','b','c','d'));

-- 3. Bilan personnel de l'apprenant (Acquis / En cours / À travailler)
ALTER TABLE public.formation_module_progression ADD COLUMN IF NOT EXISTS bilan TEXT CHECK (bilan IN ('acquis','en_cours','a_travailler'));

COMMIT;

-- EDM · MÉDITATION DU JOUR — à exécuter une fois dans Supabase > SQL Editor
CREATE TABLE IF NOT EXISTS public.meditations_du_jour (
  jour INT PRIMARY KEY,
  theme TEXT NOT NULL,
  reference TEXT NOT NULL,
  texte TEXT NOT NULL,
  actif BOOLEAN NOT NULL DEFAULT true,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
ALTER TABLE public.meditations_du_jour ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS "lire_meditations" ON public.meditations_du_jour;
CREATE POLICY "lire_meditations" ON public.meditations_du_jour FOR SELECT USING (actif = true);
DROP POLICY IF EXISTS "admin_meditations" ON public.meditations_du_jour;
CREATE POLICY "admin_meditations" ON public.meditations_du_jour FOR ALL TO authenticated
  USING (EXISTS (SELECT 1 FROM public.profiles p WHERE p.id = auth.uid() AND p.role IN ('admin','superadmin','prophet')))
  WITH CHECK (EXISTS (SELECT 1 FROM public.profiles p WHERE p.id = auth.uid() AND p.role IN ('admin','superadmin','prophet')));

INSERT INTO public.meditations_du_jour (jour, theme, reference, texte) VALUES
(1, $edm$Identité — qui je suis en Christ$edm$, $edm$1 Pierre 2:9$edm$, $edm$Vous, au contraire, vous êtes une race élue, un sacerdoce royal, une nation sainte, un peuple acquis, afin que vous annonciez les vertus de celui qui vous a appelés des ténèbres à son admirable lumière,$edm$),
(2, $edm$Identité — qui je suis en Christ$edm$, $edm$2 Corinthiens 5:17$edm$, $edm$Si quelqu’un est en Christ, il est une nouvelle créature. Les choses anciennes sont passées; voici, toutes choses sont devenues nouvelles.$edm$),
(3, $edm$Identité — qui je suis en Christ$edm$, $edm$Éphésiens 2:10$edm$, $edm$Car nous sommes son ouvrage, ayant été créés en Jésus-Christ pour de bonnes œuvres, que Dieu a préparées d’avance, afin que nous les pratiquions.$edm$),
(4, $edm$Identité — qui je suis en Christ$edm$, $edm$Romains 8:37$edm$, $edm$Mais dans toutes ces choses nous sommes plus que vainqueurs par celui qui nous a aimés.$edm$),
(5, $edm$Identité — qui je suis en Christ$edm$, $edm$1 Jean 4:4$edm$, $edm$Vous, petits enfants, vous êtes de Dieu, et vous les avez vaincus, parce que celui qui est en vous est plus grand que celui qui est dans le monde.$edm$),
(6, $edm$Identité — qui je suis en Christ$edm$, $edm$Galates 2:20$edm$, $edm$J’ai été crucifié avec Christ; et si je vis, ce n’est plus moi qui vis, c’est Christ qui vit en moi; si je vis maintenant dans la chair, je vis dans la foi au Fils de Dieu, qui m’a aimé et qui s’est livré lui-même pour moi.$edm$),
(7, $edm$Identité — qui je suis en Christ$edm$, $edm$Apocalypse 5:10$edm$, $edm$tu as fait d’eux un royaume et des sacrificateurs pour notre Dieu, et ils régneront sur la terre.$edm$),
(8, $edm$Force — fortifié par le Tout-Puissant$edm$, $edm$Éphésiens 6:10$edm$, $edm$Au reste, fortifiez-vous dans le Seigneur, et par sa force toute-puissante.$edm$),
(9, $edm$Force — fortifié par le Tout-Puissant$edm$, $edm$Ésaïe 40:31$edm$, $edm$Mais ceux qui se confient en l’Éternel renouvellent leur force. Ils prennent le vol comme les aigles; Ils courent, et ne se lassent point, Ils marchent, et ne se fatiguent point.$edm$),
(10, $edm$Force — fortifié par le Tout-Puissant$edm$, $edm$Ésaïe 41:10$edm$, $edm$Ne crains rien, car je suis avec toi; Ne promène pas des regards inquiets, car je suis ton Dieu; Je te fortifie, je viens à ton secours, Je te soutiens de ma droite triomphante.$edm$),
(11, $edm$Force — fortifié par le Tout-Puissant$edm$, $edm$Philippiens 4:13$edm$, $edm$Je puis tout par celui qui me fortifie.$edm$),
(12, $edm$Force — fortifié par le Tout-Puissant$edm$, $edm$2 Timothée 1:7$edm$, $edm$Car ce n’est pas un esprit de timidité que Dieu nous a donné, mais un esprit de force, d’amour et de sagesse.$edm$),
(13, $edm$Force — fortifié par le Tout-Puissant$edm$, $edm$Ésaïe 40:29$edm$, $edm$Il donne de la force à celui qui est fatigué, Et il augmente la vigueur de celui qui tombe en défaillance.$edm$),
(14, $edm$Force — fortifié par le Tout-Puissant$edm$, $edm$Psaumes 18:33$edm$, $edm$C’est Dieu qui me ceint de force, Et qui me conduit dans la voie droite.$edm$),
(15, $edm$Puissance — l'onction du Saint-Esprit$edm$, $edm$Actes 1:8$edm$, $edm$Mais vous recevrez une puissance, le Saint-Esprit survenant sur vous, et vous serez mes témoins à Jérusalem, dans toute la Judée, dans la Samarie, et jusqu’aux extrémités de la terre.$edm$),
(16, $edm$Puissance — l'onction du Saint-Esprit$edm$, $edm$Zacharie 4:6$edm$, $edm$Alors il reprit et me dit: C’est ici la parole que l’Éternel adresse à Zorobabel: Ce n’est ni par la puissance ni par la force, mais c’est par mon esprit, dit l’Éternel des armées.$edm$),
(17, $edm$Puissance — l'onction du Saint-Esprit$edm$, $edm$Luc 24:49$edm$, $edm$Et voici, j’enverrai sur vous ce que mon Père a promis; mais vous, restez dans la ville jusqu’à ce que vous soyez revêtus de la puissance d’en haut.$edm$),
(18, $edm$Puissance — l'onction du Saint-Esprit$edm$, $edm$Romains 8:11$edm$, $edm$Et si l’Esprit de celui qui a ressuscité Jésus d’entre les morts habite en vous, celui qui a ressuscité Christ d’entre les morts rendra aussi la vie à vos corps mortels par son Esprit qui habite en vous.$edm$),
(19, $edm$Puissance — l'onction du Saint-Esprit$edm$, $edm$Marc 16:17$edm$, $edm$Voici les miracles qui accompagneront ceux qui auront cru: en mon nom, ils chasseront les démons; ils parleront de nouvelles langues;$edm$),
(20, $edm$Puissance — l'onction du Saint-Esprit$edm$, $edm$1 Corinthiens 12:7$edm$, $edm$Or, à chacun la manifestation de l’Esprit est donnée pour l’utilité commune.$edm$),
(21, $edm$Puissance — l'onction du Saint-Esprit$edm$, $edm$Actes 4:33$edm$, $edm$Les apôtres rendaient avec beaucoup de force témoignage de la résurrection du Seigneur Jésus. Et une grande grâce reposait sur eux tous.$edm$),
(22, $edm$Excellence — sagesse et esprit supérieur$edm$, $edm$Proverbes 22:29$edm$, $edm$Si tu vois un homme habile dans son ouvrage, Il se tient auprès des rois; Il ne se tient pas auprès des gens obscurs.$edm$),
(23, $edm$Excellence — sagesse et esprit supérieur$edm$, $edm$Jacques 1:5$edm$, $edm$Si quelqu’un d’entre vous manque de sagesse, qu’il la demande à Dieu, qui donne à tous simplement et sans reproche, et elle lui sera donnée.$edm$),
(24, $edm$Excellence — sagesse et esprit supérieur$edm$, $edm$Colossiens 3:23$edm$, $edm$Tout ce que vous faites, faites-le de bon cœur, comme pour le Seigneur et non pour des hommes,$edm$),
(25, $edm$Excellence — sagesse et esprit supérieur$edm$, $edm$Daniel 12:3$edm$, $edm$Ceux qui auront été intelligents brilleront comme la splendeur du ciel, et ceux qui auront enseigné la justice, à la multitude brilleront comme les étoiles, à toujours et à perpétuité.$edm$),
(26, $edm$Excellence — sagesse et esprit supérieur$edm$, $edm$Proverbes 4:7$edm$, $edm$Voici le commencement de la sagesse: Acquiers la sagesse, Et avec tout ce que tu possèdes acquiers l’intelligence.$edm$),
(27, $edm$Excellence — sagesse et esprit supérieur$edm$, $edm$2 Pierre 1:3$edm$, $edm$Comme sa divine puissance nous a donné tout ce qui contribue à la vie et à la piété, au moyen de la connaissance de celui qui nous a appelés par sa propre gloire et par sa vertu,$edm$),
(28, $edm$Excellence — sagesse et esprit supérieur$edm$, $edm$Exode 31:3$edm$, $edm$Je l’ai rempli de l’Esprit de Dieu, de sagesse, d’intelligence, et de savoir pour toutes sortes d’ouvrages,$edm$),
(29, $edm$Autorité — régner dans la vie$edm$, $edm$Luc 10:19$edm$, $edm$Voici, je vous ai donné le pouvoir de marcher sur les serpents et les scorpions, et sur toute la puissance de l’ennemi; et rien ne pourra vous nuire.$edm$),
(30, $edm$Autorité — régner dans la vie$edm$, $edm$Matthieu 16:19$edm$, $edm$Je te donnerai les clefs du royaume des cieux: ce que tu lieras sur la terre sera lié dans les cieux, et ce que tu délieras sur la terre sera délié dans les cieux.$edm$),
(31, $edm$Autorité — régner dans la vie$edm$, $edm$Genèse 1:28$edm$, $edm$Dieu les bénit, et Dieu leur dit: Soyez féconds, multipliez, remplissez la terre, et l’assujettissez; et dominez sur les poissons de la mer, sur les oiseaux du ciel, et sur tout animal qui se meut sur la terre.$edm$),
(32, $edm$Autorité — régner dans la vie$edm$, $edm$Romains 5:17$edm$, $edm$Si par l’offense d’un seul la mort a régné par lui seul, à plus forte raison ceux qui reçoivent l’abondance de la grâce et du don de la justice régneront-ils dans la vie par Jésus-Christ lui seul.$edm$),
(33, $edm$Autorité — régner dans la vie$edm$, $edm$Matthieu 28:18$edm$, $edm$Jésus, s’étant approché, leur parla ainsi: Tout pouvoir m’a été donné dans le ciel et sur la terre.$edm$),
(34, $edm$Autorité — régner dans la vie$edm$, $edm$Deutéronome 28:13$edm$, $edm$L’Éternel fera de toi la tête et non la queue, tu seras toujours en haut et tu ne seras jamais en bas, lorsque tu obéiras aux commandements de l’Éternel, ton Dieu, que je te prescris aujourd’hui, lorsque tu les observeras et les mettras en pratique,$edm$),
(35, $edm$Autorité — régner dans la vie$edm$, $edm$2 Corinthiens 10:4$edm$, $edm$Car les armes avec lesquelles nous combattons ne sont pas charnelles; mais elles sont puissantes, par la vertu de Dieu, pour renverser des forteresses.$edm$),
(36, $edm$Impact — lumière du monde$edm$, $edm$Matthieu 5:14$edm$, $edm$Vous êtes la lumière du monde. Une ville située sur une montagne ne peut être cachée;$edm$),
(37, $edm$Impact — lumière du monde$edm$, $edm$Matthieu 5:16$edm$, $edm$Que votre lumière luise ainsi devant les hommes, afin qu’ils voient vos bonnes œuvres, et qu’ils glorifient votre Père qui est dans les cieux.$edm$),
(38, $edm$Impact — lumière du monde$edm$, $edm$Jean 14:12$edm$, $edm$En vérité, en vérité, je vous le dis, celui qui croit en moi fera aussi les œuvres que je fais, et il en fera de plus grandes, parce que je m’en vais au Père;$edm$),
(39, $edm$Impact — lumière du monde$edm$, $edm$Proverbes 4:18$edm$, $edm$Le sentier des justes est comme la lumière resplendissante, Dont l’éclat va croissant jusqu’au milieu du jour.$edm$),
(40, $edm$Impact — lumière du monde$edm$, $edm$Matthieu 28:19$edm$, $edm$Allez, faites de toutes les nations des disciples, les baptisant au nom du Père, du Fils et du Saint-Esprit,$edm$),
(41, $edm$Impact — lumière du monde$edm$, $edm$Ésaïe 60:1$edm$, $edm$Lève-toi, sois éclairée, car ta lumière arrive, Et la gloire de l’Éternel se lève sur toi.$edm$),
(42, $edm$Impact — lumière du monde$edm$, $edm$2 Corinthiens 2:14$edm$, $edm$Grâces soient rendues à Dieu, qui nous fait toujours triompher en Christ, et qui répand par nous en tout lieu l’odeur de sa connaissance!$edm$),
(43, $edm$Présence — demeurer en Lui$edm$, $edm$Jean 15:4$edm$, $edm$Demeurez en moi, et je demeurerai en vous. Comme le sarment ne peut de lui-même porter du fruit, s’il ne demeure attaché au cep, ainsi vous ne le pouvez non plus, si vous ne demeurez en moi.$edm$),
(44, $edm$Présence — demeurer en Lui$edm$, $edm$Jean 15:5$edm$, $edm$Je suis le cep, vous êtes les sarments. Celui qui demeure en moi et en qui je demeure porte beaucoup de fruit, car sans moi vous ne pouvez rien faire.$edm$),
(45, $edm$Présence — demeurer en Lui$edm$, $edm$Jean 15:7$edm$, $edm$Si vous demeurez en moi, et que mes paroles demeurent en vous, demandez ce que vous voudrez, et cela vous sera accordé.$edm$),
(46, $edm$Présence — demeurer en Lui$edm$, $edm$Jean 15:16$edm$, $edm$Ce n’est pas vous qui m’avez choisi; mais moi, je vous ai choisis, et je vous ai établis, afin que vous alliez, et que vous portiez du fruit, et que votre fruit demeure, afin que ce que vous demanderez au Père en mon nom, il vous le donne.$edm$),
(47, $edm$Présence — demeurer en Lui$edm$, $edm$Psaumes 91:1$edm$, $edm$Celui qui demeure sous l’abri du Très-Haut Repose à l’ombre du Tout Puissant.$edm$),
(48, $edm$Présence — demeurer en Lui$edm$, $edm$Exode 33:14$edm$, $edm$L’Éternel répondit: Je marcherai moi-même avec toi, et je te donnerai du repos.$edm$),
(49, $edm$Présence — demeurer en Lui$edm$, $edm$Psaumes 16:11$edm$, $edm$Tu me feras connaître le sentier de la vie; Il y a d’abondantes joies devant ta face, Des délices éternelles à ta droite.$edm$)
ON CONFLICT (jour) DO UPDATE SET theme = EXCLUDED.theme, reference = EXCLUDED.reference, texte = EXCLUDED.texte;
