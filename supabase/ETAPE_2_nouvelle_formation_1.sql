-- =====================================================================
-- EDM · FORMATION 1 « UNE SEMAINE POUR SAVOIR AVEC DIEU » — NOUVELLE STRUCTURE
-- 7 semaines · 35 modules · 210 questions · structure officielle en 6 parties
-- À exécuter UNE SEULE FOIS dans Supabase > SQL Editor (projet EDM-ECDV)
-- Les anciens modules ne sont pas supprimés : ils sont archivés (formation_v1).
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

-- 4. Archiver l'ancienne Formation 1 (47 modules) sans rien effacer
UPDATE public.formation_modules SET formation = 'formation_v1', actif = false WHERE formation = 'formation';

-- 5. Les 35 nouveaux modules
INSERT INTO public.formation_modules (formation, numero, partie, semaine, semaine_titre, titre, objectifs, texte, resume, pratique, bilan_points, fin_de_semaine, actif) VALUES
('formation', 1, 1, 1, $edm$Savoir méditer la Parole de Dieu$edm$, $edm$Comprendre la Bible$edm$, $edm$À la fin de ce module, tu sauras :
- dire ce qu'est la Bible, et ce qu'elle n'est pas ;
- expliquer ce que signifie « Parole de Dieu » ;
- décrire sa composition : les 66 livres, l'Ancien et le Nouveau Testament ;
- citer à quoi sert la Bible dans la vie du chrétien.$edm$, $edm$I. COMPRENDRE CE QU'EST VRAIMENT LA BIBLE

QU'EST-CE QUE LA BIBLE ?

Avant de méditer la Bible, il faut sortir du fanatisme et comprendre ce qu'elle est réellement.

Ce qu'elle n'est PAS :
- Un livre écrit directement par Dieu
- Un texte dicté mot à mot par un ange
- Un ouvrage tombé du ciel tout fait

Ce qu'elle EST :

La Bible est l'histoire du peuple d'Israël, un peuple réel qui a vraiment existé. Ce peuple avait des traditions écrites, des scribes, des archives, des lois, des chants, des récits de sagesse. Comme tout peuple ancien civilisé, il documentait son histoire.

Ce qui rend ce peuple particulier, ce n'est pas qu'il a reçu un livre magique du ciel, mais que Dieu l'a choisi pour transmettre ses préceptes, ses principes, ses promesses, et son plan pour sauver l'humanité.

COMMENT DIEU S'EST RÉVÉLÉ À TRAVERS L'HISTOIRE

Dieu ne s'est pas révélé de manière abstraite. Il a agi dans l'histoire concrète :
- Il a libéré un peuple esclave en Égypte : événement historique
- Il a donné les lois à Moïse au Sinaï : transmission humaine
- Il a parlé par les prophètes : personnes identifiables
- Il est devenu homme en Jésus : personnage historique attesté

Dans cette histoire, certains hommes ont eu un rôle particulier : les prophètes recevaient des messages de Dieu et les transmettaient avec leurs propres mots, dans leur style personnel. Ésaïe écrivait en poésie, Jérémie avec émotion, David composait des chants, Paul rédigeait des lettres théologiques.

La Bible elle-même montre qu'elle n'est pas dictée : Luc dit « J'ai fait des recherches » (Luc 1:3), Paul distingue parfois son avis de la révélation directe (1 Corinthiens 7). Ce sont des hommes qui écrivent, avec leur style et leur personnalité.

CE QUE SIGNIFIE « PAROLE DE DIEU »

« Parole de Dieu » signifie : dans cette histoire réelle d'un peuple réel, Dieu a parlé. À travers ces événements concrets, Il s'est révélé. Par ces témoins humains, Il a transmis son message.

Ce n'est pas « écrit par Dieu » mais « révélation de Dieu à travers une histoire humaine documentée ».

« Ne croyez pas n'importe quel esprit » (1 Jean 4:1)

Il ne faut pas se fier aveuglément à toute affirmation sur l'origine d'un texte, mais examiner les faits.


II. LA COMPOSITION DE LA BIBLE

LES 66 LIVRES

L'Ancien Testament (39 livres), écrit entre 1400 et 400 avant Jésus-Christ :
- Le Pentateuque (5 livres) : Genèse à Deutéronome, les origines et les lois fondamentales
- Les livres historiques (12 livres) : Josué à Esther, l'histoire du peuple
- Les livres poétiques (5 livres) : Job à Cantique des Cantiques, poésie et sagesse
- Les livres prophétiques (17 livres) : Ésaïe à Malachie, les messages des prophètes

Le Nouveau Testament (27 livres), écrit entre 50 et 100 après Jésus-Christ :
- Les Évangiles (4 livres) : Matthieu, Marc, Luc, Jean, la vie de Jésus
- Les Actes des Apôtres : l'histoire de l'Église primitive
- Les lettres de Paul (13 livres)
- Les lettres générales (8 livres)
- L'Apocalypse

COMMENT ELLE A ÉTÉ ÉCRITE

La Bible a été rédigée sur environ 1500 ans, par plus de 40 auteurs différents : prophètes, rois, pêcheurs, un collecteur d'impôts, un médecin, un religieux instruit. Elle a été écrite en hébreu, araméen, et grec koinè.

Les textes ont d'abord circulé séparément avant d'être rassemblés et reconnus officiellement (canonisés). Le processus s'est achevé pour le Nouveau Testament avec les conciles d'Hippone (393) et de Carthage (397).

Malgré cette diversité d'auteurs et d'époques, la Bible présente une unité remarquable : le plan de Dieu pour sauver l'humanité, accompli en Jésus-Christ.

POURQUOI ASSEMBLER LES DEUX TESTAMENTS

Le mot « Bible » vient du grec « biblia », qui signifie simplement « les livres ».

Les premiers chrétiens, qui étaient juifs, avaient déjà l'Ancien Testament. Après la résurrection de Jésus, de nouveaux écrits ont circulé (lettres de Paul, Évangiles, etc.). Les communautés chrétiennes ont décidé de garder l'Ancien Testament (qui annonce et prépare le Messie) et d'y ajouter le Nouveau Testament (qui révèle son accomplissement en Jésus).

- Ancien Testament = la promesse
- Nouveau Testament = l'accomplissement

« Testament » vient du mot « alliance ». L'Ancien Testament est l'alliance conclue avec Israël par Moïse ; le Nouveau Testament est la nouvelle alliance établie par Jésus-Christ. La seconde n'annule pas la première, elle l'accomplit.


III. À QUOI SERT LA BIBLE

CE QU'ELLE REPRÉSENTE

La Bible symbolise plusieurs réalités : une lumière qui éclaire le chemin, une nourriture pour l'âme, une arme contre les mensonges et les tentations, un miroir qui révèle qui nous sommes, une semence qui produit du fruit, un trésor de sagesse, une boussole qui oriente la vie, un fondement solide sur lequel bâtir.

SON UTILITÉ CONCRÈTE

Pour connaître Dieu et Jésus-Christ : c'est le principal moyen par lequel Dieu se fait connaître à nous, révélant qui Il est, son caractère, sa volonté.

Pour guider notre vie quotidienne : elle donne des principes pour nos relations, notre travail, nos finances, notre famille, nos décisions.

Pour résister aux tentations : comme Jésus dans le désert, nous pouvons répondre « Il est écrit... »

Pour nous encourager et nous consoler : dans les épreuves, ses promesses nous soutiennent.

Pour prier : elle nous apprend comment prier et nous donne les mots.

Pour grandir spirituellement : elle nous transforme progressivement à l'image de Christ.

Pour corriger nos erreurs : elle agit comme un miroir qui nous montre nos fautes.

Pour discerner le vrai du faux : tout enseignement doit être testé à sa lumière.

Pour vivre en communauté : elle montre comment s'aimer, se pardonner, se servir mutuellement.$edm$, $edm$- La Bible n'est pas un livre dicté mot à mot ni tombé du ciel : c'est l'histoire d'un peuple réel, Israël, à qui Dieu s'est révélé.
- Dieu a agi dans l'histoire concrète : la libération d'Égypte, les lois données à Moïse, les prophètes, Jésus.
- Des hommes ont écrit, chacun avec son style et sa personnalité.
- « Parole de Dieu » veut dire : révélation de Dieu à travers une histoire humaine documentée.
- La Bible compte 66 livres : 39 pour l'Ancien Testament, 27 pour le Nouveau.
- Ancien Testament = la promesse. Nouveau Testament = l'accomplissement. « Testament » veut dire « alliance ».
- La Bible sert à connaître Dieu, à guider la vie, à résister aux tentations, à consoler, à prier, à grandir, à corriger, à discerner et à vivre en communauté.$edm$, $edm$Cette semaine, tu apprends à te repérer dans ta Bible.

1. Repère les livres. Ouvre ta Bible à la table des matières. Trouve et situe : Genèse, Psaumes, Ésaïe, Matthieu, Actes, Romains, Apocalypse. Pour chacun, dis s'il est dans l'Ancien ou le Nouveau Testament, et dans quelle catégorie il se trouve (Pentateuque, historique, poétique, prophétique, Évangile, lettre...).

2. Lis un livre court en entier. Choisis-en un et demande-toi : qui écrit ? À qui ? Quand ? Pourquoi ?

3. Écris ta propre phrase. En une phrase, avec tes mots : « Pour moi, Parole de Dieu veut dire... »

4. Choisis une utilité. Parmi les utilités de la Bible (section III), choisis celle dont tu as le plus besoin en ce moment et note pourquoi.$edm$, $edm$✅ Acquis, je maîtrise bien : ...

⏳ En cours, je comprends mais je dois approfondir : ...

🔄 À travailler, je dois revenir dessus plus tard : ...

(Exemples de points à évaluer : ce qu'est la Bible · ce que signifie « Parole de Dieu » · les 66 livres et les deux Testaments · à quoi sert la Bible · me repérer dans ma Bible.)$edm$, false, true),
('formation', 2, 1, 1, $edm$Savoir méditer la Parole de Dieu$edm$, $edm$Les fondements et l'intention de méditer$edm$, $edm$À la fin de ce module, tu sauras :
- citer les quatre fondements nécessaires pour méditer efficacement ;
- expliquer pourquoi l'intention vient du cœur et non de la technique ;
- distinguer les mauvaises intentions, les intentions secondaires et l'intention ultime ;
- faire la différence entre méditer par religion et méditer par amour pour Jésus-Christ.$edm$, $edm$IV. LES FONDEMENTS DE LA MÉDITATION

Pour méditer efficacement, quatre fondements sont nécessaires :

1. Croire en Dieu : avoir la conviction que Dieu existe réellement, qu'il est vivant et désire communiquer avec nous. Sans cette foi, la Bible reste un livre ordinaire.

2. Croire en Christ : reconnaître que Jésus est le Fils de Dieu, le Sauveur, le centre de toute la Bible. Sans lui, elle n'est qu'une collection d'histoires anciennes.

3. Aimer Jésus et son prochain : la méditation ne doit pas être un exercice froid, mais motivée par l'amour.

« La connaissance enfle, mais l'amour édifie » (1 Corinthiens 8:1)

4. Désirer connaître Jésus : le but n'est pas d'accumuler des informations sur lui, mais de le connaître personnellement, intimement, de manière toujours plus profonde.


V. L'INTENTION DE MÉDITER LA PAROLE DE DIEU

L'INTENTION VIENT DU CŒUR

Le pourquoi de la méditation ne provient pas d'abord d'une technique ou d'une discipline extérieure. Il provient d'une réalité et d'une vérité dans le cœur.

Je médite la Parole de Dieu parce que je veux connaître celui que j'aime. L'intention de méditer est directement liée à l'amour qu'on porte pour Dieu.

« Tu aimeras le Seigneur, ton Dieu, de tout ton cœur, de toute ton âme, et de toute ta pensée » (Matthieu 22:37)

L'intention de base qui doit pousser une personne à méditer la Parole de Dieu, c'est l'amour qu'elle porte pour Dieu.

LES MAUVAISES INTENTIONS À REJETER

N'importe qui peut lire la Bible, mais pas avec la même intention. On peut la lire avec l'intention :
- D'attaquer ou de contredire Dieu
- De débattre ou de combattre la chrétienté
- De rejeter Dieu
- De chercher des lacunes ou des contradictions

Ces intentions sont à l'opposé de la vraie méditation.

LES INTENTIONS SECONDAIRES : BONNES MAIS PAS ULTIMES

Certaines personnes méditent la Bible dans un bon sens, sans que ce soit encore le but ultime :
- Pour la moralité et le bon sens
- Pour la sagesse pratique : savoir se comporter en société
- Pour une connaissance spirituelle générale, sans nécessairement connaître Jésus personnellement
- Pour l'inspiration ou des stratégies de vie

Ces raisons ne sont pas mauvaises. La Bible contient effectivement moralité, sagesse et inspiration. On peut accepter que quelqu'un l'aborde ainsi. Mais ce n'est pas encore l'intention parfaite.

L'INTENTION ULTIME : CONNAÎTRE JÉSUS

Ce qui est parfait, c'est de méditer dans le but de connaître Jésus. Il est la pierre angulaire. Tout le reste peut être bon, mais le point central, c'est Lui.

« Le salut consiste à Te connaître, Toi le seul vrai Dieu, et Ton fils unique que Tu as envoyé » (Jean 17:3)

Quand on médite avec cette intention juste, cela ouvre à tout le reste : connaître la personnalité de Dieu, sa création, ce qu'il a fait, son amour ; se rapprocher de lui, le voir agir, grandir spirituellement, rechercher sa présence, entrer en communion avec lui ; développer sa foi, car « la foi vient de ce qu'on entend, et ce qu'on entend vient de la parole de Christ » (Romains 10:17) ; préserver son salut et nourrir sa croissance spirituelle.

On médite la Parole de Dieu dans l'intention de plaire à Dieu, et cette intention découle de l'amour qu'on porte pour Jésus-Christ.

RELIGION VERSUS AMOUR POUR JÉSUS-CHRIST

Il y a une distinction essentielle à faire entre méditer la Bible en tant que religieux et méditer la Bible par amour pour Jésus-Christ.

Comment fonctionne la religion

La religion fonctionne sur des principes et des doctrines. Elle n'a pas d'universalité : chaque congrégation, chaque communauté a ses propres règles et doctrines. On peut appartenir à une famille religieuse, pratiquer une foi liée à une communauté, suivre des principes « canoniques ». La Bible elle-même est un recueil qui permet de marcher selon des règles.

On peut être religieux sans aimer Jésus-Christ

Voici le point crucial : on peut être religieux, pratiquer, appartenir à une communauté, sans pour autant développer un amour profond pour Jésus-Christ. La religion peut être liée à un sentiment d'appartenance collective fonctionnant sur des règles communes. C'est une chose.

L'amour pour Jésus est différent

L'amour qu'on développe pour Jésus-Christ n'est lié à aucune appartenance communautaire. Il ne provient pas du fait d'appartenir à un groupe, mais directement du cœur. On n'aime pas Jésus parce qu'on appartient à telle congrégation ; on l'aime parce que notre cœur l'aime, personnellement.

Le plus grand commandement dépasse la religion

C'est pourquoi le plus grand commandement n'est pas d'ordre institutionnel. Toute la Loi et les Prophètes dépendent de ce commandement : aimer le Seigneur de tout son cœur, toute son âme, toute sa pensée et toute sa force. C'est une réalité qui va bien au-delà des principes religieux, une forme de vie réelle, véridique, qui dépasse toutes les frontières religieuses et canoniques.

Conclusion

On peut méditer la Bible en tant que religieux, appartenant à une communauté. Ce n'est pas mauvais en soi. Mais l'intention ultime doit toujours rester de connaître celui qu'on aime de tout son cœur : Jésus-Christ.

On ne médite pas la Parole de Dieu dans le but de développer sa religion, mais plutôt de développer sa foi en Jésus-Christ.$edm$, $edm$- Quatre fondements pour méditer : croire en Dieu, croire en Christ, aimer Jésus et son prochain, désirer connaître Jésus.
- Sans la foi en Dieu et en Christ, la Bible reste un livre ordinaire, une collection d'histoires anciennes.
- La méditation ne doit pas être un exercice froid : elle est motivée par l'amour.
- L'intention vient du cœur, pas d'une technique : je médite parce que je veux connaître celui que j'aime.
- Les mauvaises intentions sont à rejeter : attaquer Dieu, débattre contre la chrétienté, rejeter Dieu, chercher des contradictions.
- Les intentions secondaires sont bonnes mais pas ultimes : la moralité, la sagesse pratique, la connaissance générale, l'inspiration.
- L'intention ultime est de connaître Jésus, dans le but de plaire à Dieu.
- On peut être religieux sans aimer Jésus-Christ. L'amour pour Jésus ne dépend d'aucune appartenance communautaire.
- On ne médite pas pour développer sa religion, mais pour développer sa foi en Jésus-Christ.$edm$, $edm$Cette semaine, tu examines ton cœur avant d'ouvrir ta Bible.

1. Écris ton intention. Sur une feuille, termine honnêtement cette phrase : « Je médite la Parole de Dieu parce que... »

2. Situe-la. Relis ta phrase et demande-toi : est-ce une mauvaise intention, une intention secondaire (moralité, sagesse, inspiration) ou l'intention ultime, connaître Jésus ? Sois sincère. Il n'y a pas de bonne ou de mauvaise réponse ici, seulement un point de départ.

3. Mesure ton amour. Pose-toi cette question : qu'est-ce que j'aime en Jésus, personnellement, au-delà de ma communauté et de mes habitudes ? Écris-le.

4. Écris ta phrase d'intention. En une phrase, avec tes mots : « Je médite la Parole de Dieu pour connaître Jésus et lui plaire. » Relis-la avant chaque lecture cette semaine.$edm$, $edm$✅ Acquis, je maîtrise bien : ...

⏳ En cours, je comprends mais je dois approfondir : ...

🔄 À travailler, je dois revenir dessus plus tard : ...

(Exemples de points à évaluer : les quatre fondements · l'intention vient du cœur · mauvaises intentions, intentions secondaires, intention ultime · religion ou amour pour Jésus-Christ · ma propre intention.)$edm$, false, true),
('formation', 3, 1, 1, $edm$Savoir méditer la Parole de Dieu$edm$, $edm$Le rôle de l'Esprit Saint$edm$, $edm$À la fin de ce module, tu sauras :
- expliquer pourquoi l'Esprit est indispensable pour méditer ;
- dire ce que devient la méditation sans l'Esprit ;
- reconnaître si ta méditation vient de l'Esprit, grâce à son fruit ;
- inviter l'Esprit avant de lire.$edm$, $edm$VI. LE RÔLE DE L'ESPRIT SAINT

POURQUOI L'ESPRIT EST INDISPENSABLE

L'Esprit révèle Jésus : il ouvre nos yeux spirituels pour voir Christ dans toute la Bible (Jean 15:26, 16:14).

L'Esprit nous rappelle : il fait remonter les versets au bon moment, face aux tentations ou aux épreuves (Jean 14:26).

L'Esprit enseigne : il illumine notre intelligence, révèle les mystères de Dieu, nous guide dans la compréhension (Jean 16:13).

SANS L'ESPRIT, PAS DE VRAIE MÉDITATION

Sans l'Esprit, la méditation devient une simple étude littéraire ou intellectuelle. Les pharisiens connaissaient les Écritures par cœur mais ont crucifié le Messie qu'elles annonçaient : ils lisaient sans l'Esprit.

Le critère de mesure : est-ce que ma méditation me rapproche de Jésus ? Si oui, c'est l'œuvre de l'Esprit (amour croissant, foi fortifiée, humilité, obéissance joyeuse). Si non (orgueil, critique, sécheresse, division), ce n'est pas l'Esprit qui guide.

COMMENT INVITER L'ESPRIT

- Prier avant de lire : « Esprit Saint, enseigne-moi »
- Rester humble, reconnaître notre besoin
- Confesser nos péchés, qui bloquent l'œuvre de l'Esprit
- Être disposé à obéir à ce qu'il révèle
- Dépendre constamment de lui, jamais de notre seule intelligence$edm$, $edm$- L'Esprit est indispensable : il révèle Jésus, il nous rappelle les versets et il enseigne.
- Sans l'Esprit, la méditation devient une simple étude littéraire ou intellectuelle.
- Les pharisiens connaissaient les Écritures par cœur, mais ils lisaient sans l'Esprit et ont crucifié le Messie.
- Le critère de mesure : ma méditation me rapproche-t-elle de Jésus ?
- Le fruit de l'Esprit : amour croissant, foi fortifiée, humilité, obéissance joyeuse.
- Quand ce n'est pas l'Esprit qui guide : orgueil, critique, sécheresse, division.
- Pour inviter l'Esprit : prier avant de lire, rester humble, confesser mes péchés, être disposé à obéir, dépendre de lui.$edm$, $edm$Cette semaine, tu invites l'Esprit avant chaque lecture, puis tu vérifies ce que ta lecture produit.

1. Invite l'Esprit. Avant de lire, prends quelques instants. Prie : « Esprit Saint, enseigne-moi. » Reconnais humblement ton besoin de lui. Confesse ce que tu as à confesser. Dis-lui que tu es disposé à obéir à ce qu'il te montrera.

2. Lis lentement un court passage. Un Évangile, un psaume, un passage de ton choix.

3. Mesure. Après ta lecture, pose-toi la question : cette méditation me rapproche-t-elle de Jésus ? Note ce que tu remarques : amour, foi, humilité, obéissance, ou au contraire orgueil, critique, sécheresse, division.

4. Note ce que l'Esprit t'a rappelé. Pendant ta journée, si un verset te revient au bon moment, note-le avec la situation où il est revenu.$edm$, $edm$✅ Acquis, je maîtrise bien : ...

⏳ En cours, je comprends mais je dois approfondir : ...

🔄 À travailler, je dois revenir dessus plus tard : ...

(Exemples de points à évaluer : pourquoi l'Esprit est indispensable · ce que devient la méditation sans l'Esprit · le critère de mesure et le fruit de l'Esprit · comment inviter l'Esprit · ma pratique de la semaine.)$edm$, false, true),
('formation', 4, 1, 1, $edm$Savoir méditer la Parole de Dieu$edm$, $edm$Comment méditer concrètement$edm$, $edm$À la fin de ce module, tu sauras :
- méditer un passage de la Bible en suivant dix étapes pratiques ;
- tenir un journal spirituel pour fixer ce que Dieu révèle ;
- citer les bienfaits de la méditation, sur le plan spirituel, social, intellectuel et émotionnel.$edm$, $edm$VII. COMMENT MÉDITER CONCRÈTEMENT

LES ÉTAPES PRATIQUES

1. Lire lentement : quelques versets bien compris valent mieux que des chapitres survolés.

2. Réfléchir sur le sens : Que dit ce texte ? Que signifie-t-il ? Quels mots sont clés ? Qu'est-ce qui me frappe ?

3. Comprendre le contexte : Que se passe-t-il avant/après ? Qui écrit, à qui, pourquoi ?

4. Prier avant, pendant et après la lecture.

5. Écouter l'Esprit : quand un verset frappe particulièrement, s'arrêter : c'est souvent Dieu qui parle.

6. Appliquer concrètement : quelle décision prendre, quelle attitude corriger, quel péché abandonner, quelle action poser aujourd'hui ? Soyez spécifique.

7. Mémoriser les versets clés, pour les avoir disponibles dans les moments de besoin.

8. Méditer toute la journée : ruminer le verset, y revenir mentalement.

9. Partager avec d'autres croyants ce que Dieu a montré.

10. Obéir : la vraie preuve d'une méditation authentique.

Tenir un journal spirituel (date, passage, découvertes, application, prière) aide à fixer ce que Dieu révèle et à suivre sa croissance.

LES BIENFAITS DE LA MÉDITATION

Spirituellement : une foi plus forte, une vie plus sainte, une paix profonde, une joie durable

Socialement : plus d'engagement, de meilleures relations, un témoignage efficace

Intellectuellement : la sagesse divine, un meilleur discernement, une perspective éternelle

Émotionnellement : stabilité, guérison intérieure, espérance renouvelée$edm$, $edm$- Lire lentement : quelques versets bien compris valent mieux que des chapitres survolés.
- Réfléchir sur le sens, comprendre le contexte (qui écrit, à qui, pourquoi).
- Prier avant, pendant et après la lecture, et écouter l'Esprit.
- Appliquer concrètement, de façon spécifique : décision, attitude, péché, action.
- Mémoriser les versets clés, méditer toute la journée, partager avec d'autres croyants.
- Obéir : c'est la vraie preuve d'une méditation authentique.
- Le journal spirituel (date, passage, découvertes, application, prière) fixe ce que Dieu révèle.
- Les bienfaits : une foi plus forte, de meilleures relations, la sagesse divine, une stabilité émotionnelle.$edm$, $edm$Cette semaine, tu médites un passage court en suivant les dix étapes, et tu ouvres ton journal spirituel.

1. Choisis un court passage (quelques versets) d'un Évangile ou d'un psaume.

2. Médite-le en suivant les dix étapes. Lis lentement, réfléchis sur le sens, comprends le contexte, prie avant, pendant et après, écoute l'Esprit, applique concrètement, mémorise un verset clé, médite-le toute la journée, partage-le avec un croyant, obéis.

3. Ouvre ton journal spirituel. Pour chaque méditation, note : la date, le passage, ce que tu as découvert, l'application (spécifique) et ta prière.

4. Reviens-y chaque jour de la semaine. Reprends le même passage ou un nouveau, et note ce que Dieu te montre. À la fin de la semaine, relis ton journal et repère comment tu as grandi.$edm$, $edm$✅ Acquis, je maîtrise bien : ...

⏳ En cours, je comprends mais je dois approfondir : ...

🔄 À travailler, je dois revenir dessus plus tard : ...

(Exemples de points à évaluer : lire lentement et comprendre le contexte · prier et écouter l'Esprit · appliquer concrètement · mémoriser et méditer toute la journée · obéir · tenir mon journal spirituel.)$edm$, false, true),
('formation', 5, 1, 1, $edm$Savoir méditer la Parole de Dieu$edm$, $edm$Les erreurs à éviter$edm$, $edm$À la fin de ce module, tu sauras :
- reconnaître les cinq grandes erreurs de la méditation ;
- repérer les autres pièges courants ;
- comprendre pourquoi la Parole de Dieu doit rester une boussole qui corrige, et jamais un outil pour justifier ;
- vérifier ta propre manière de méditer.$edm$, $edm$VIII. LES ERREURS À ÉVITER

1. MÉDITER POUR IMPRESSIONNER

Certains étudient la Bible pour accumuler des connaissances et impressionner les autres. Cela conduit à l'orgueil spirituel, au mépris des autres croyants, à la division dans l'Église, et finalement à l'inefficacité spirituelle malgré toute cette connaissance.

« La connaissance enfle, mais l'amour édifie » (1 Corinthiens 8:1)

2. MÉDITER AVEC DE MAUVAISES INTENTIONS

D'autres lisent la Bible pour manipuler les autres, justifier leurs comportements, attaquer leurs adversaires, ou gagner des débats. Cela transforme la Parole de Dieu en instrument de manipulation, exactement ce que Satan a fait en citant l'Écriture pour tenter Jésus.

3. MÉDITER POUR CONTREDIRE DIEU

Certains abordent la Bible avec un esprit critique destructeur : chercher les contradictions, rejeter la seigneurie de Christ, nier l'autorité de l'Écriture, tordre le sens des passages. Cela révèle un cœur rebelle qui ne cherche pas vraiment la vérité, mais qui veut rester maître de sa propre vie.

4. MÉDITER DE FAÇON ÉGOÏSTE

D'autres ne lisent la Bible que de manière utilitariste : uniquement pour résoudre leurs problèmes, comme une formule magique, sans chercher Dieu lui-même, sans désir de transformation, sans souci d'obéissance. La Bible devient alors un simple outil de développement personnel, vidé de sa dimension spirituelle.

5. MÉDITER POUR SE JUSTIFIER SOI-MÊME

Il y a une erreur particulièrement subtile et dangereuse : prendre la Parole de Dieu non pas pour se laisser corriger par elle, mais pour justifier son péché.

La Bible sert de boussole. Mais certaines personnes se permettent de la prendre et de l'appliquer de manière partiale, en sélectionnant ce qui les arrange, alors que c'est cette même Parole qui doit nous permettre de discerner, de séparer ce qui vient de la chair et ce qui vient de l'Esprit.

Il y a des choses que nous faisons qui sont des erreurs, que nous devrions reconnaître devant Dieu. Mais au lieu de cela, nous prenons parfois la Parole pour justifier nos mauvaises œuvres, sans tenir compte du fait qu'elle nous demande justement de ne pas agir ainsi.

Certes, l'homme peut être faible. Mais ne pas reconnaître sa faute, et se servir en plus de la Parole pour la justifier, c'est mauvais.

Ce qui compte, c'est que nous sommes des êtres humains faits à l'image de Dieu, ayant le Saint-Esprit, pouvant être convaincus de péché. La Parole nous fortifie et nous fait comprendre qu'il y a un Dieu qui relève. Elle contient des promesses pour toute forme de faiblesse ou d'incapacité.

La Parole de Dieu n'est pas un livre de contentement de nos mauvaises actions, de nos mauvaises pensées, de nos erreurs ou de nos fautes. Elle est plutôt un livre qui sert de boussole, un baromètre qui nous permet de comprendre ce que nous posons comme erreur, que ce soit par omission, volontairement, ou par obsession.

Il faut éviter le piège de faire de la Parole de Dieu un bouc émissaire de nos mauvaises actions, pour demeurer confortablement dans une mauvaise vie. Elle ne doit jamais devenir un outil pour excuser ce qu'elle-même condamne. Elle doit toujours rester ce qui nous corrige, jamais ce qui nous couvre.

AUTRES PIÈGES COURANTS

- Lire sans prier
- Ignorer le contexte
- Ne jamais appliquer
- Être irrégulier
- Éviter les passages dérangeants
- S'isoler sans jamais partager avec d'autres croyants$edm$, $edm$- Cinq erreurs à éviter : méditer pour impressionner, avec de mauvaises intentions, pour contredire Dieu, de façon égoïste, pour se justifier soi-même.
- Méditer pour impressionner conduit à l'orgueil, à la division et à l'inefficacité spirituelle.
- Méditer avec de mauvaises intentions fait de la Parole un instrument de manipulation.
- Méditer pour contredire Dieu révèle un cœur rebelle.
- Méditer de façon égoïste fait de la Bible une formule magique ou un simple outil de développement personnel.
- La plus subtile des erreurs : se servir de la Parole pour justifier son péché au lieu de se laisser corriger.
- La Parole de Dieu est une boussole et un baromètre : elle corrige, elle ne couvre jamais.
- Les autres pièges : lire sans prier, ignorer le contexte, ne jamais appliquer, être irrégulier, éviter les passages dérangeants, s'isoler.$edm$, $edm$Cette semaine, tu examines ta manière de méditer, en toute honnêteté devant Dieu.

1. Repère tes erreurs. Relis les cinq erreurs. Pour chacune, demande-toi : est-ce que je fais cela, même un peu ? Note une situation précise où tu as lu la Bible de cette manière.

2. Fais l'examen de la cinquième. Prends un domaine de ta vie où tu as une faiblesse ou une faute. Demande-toi : est-ce que j'ai déjà utilisé un verset pour m'excuser ou me justifier, au lieu de me laisser corriger ? Si oui, reconnais-le devant Dieu.

3. Fais le point sur les autres pièges. Lis la liste : lire sans prier, ignorer le contexte, ne jamais appliquer, être irrégulier, éviter les passages dérangeants, s'isoler. Choisis-en un seul à corriger cette semaine.

4. Lis un passage dérangeant. Choisis un passage que tu évites d'habitude, lis-le lentement, prie, et laisse-le te corriger. Note ce que tu apprends.$edm$, $edm$✅ Acquis, je maîtrise bien : ...

⏳ En cours, je comprends mais je dois approfondir : ...

🔄 À travailler, je dois revenir dessus plus tard : ...

(Exemples de points à évaluer : les cinq erreurs de la méditation · la Parole qui corrige et ne couvre pas · les autres pièges courants · mon examen personnel.)


==================================================
CONCLUSION : LA BIBLE COMME BOUSSOLE
==================================================

La Bible n'est pas un livre magique tombé du ciel, mais l'histoire d'un peuple à qui Dieu s'est révélé, à travers laquelle nous pouvons aujourd'hui entendre sa voix.

Elle doit servir de boussole qui guide nos choix et nous ramène sur le droit chemin, jamais d'outil pour justifier nos idées, couvrir nos fautes, ou contrôler les autres.

Une méditation authentique se reconnaît à ses fruits : elle nous rapproche de Jésus, nous rend humbles, produit l'amour, pousse à l'obéissance, transforme notre caractère, donne la paix, fortifie la foi.

L'intention doit toujours rester la même : méditer non pour développer une religion, mais pour développer notre amour et notre foi en Jésus-Christ, dans le but ultime de le connaître Lui.

« Le salut consiste à Te connaître, Toi le seul vrai Dieu, et Ton fils unique que Tu as envoyé » (Jean 17:3)$edm$, true, true),
('formation', 6, 2, 2, $edm$Savoir invoquer Dieu$edm$, $edm$Comprendre l'invocation$edm$, $edm$À la fin de ce module, tu sauras :
- dire ce qu'est l'invocation, et ce qu'elle n'est pas ;
- distinguer prier et invoquer ;
- expliquer pourquoi Dieu nous invite à L'invoquer, au-delà de nos problèmes ;
- t'attendre à une chose précise quand tu invoques : que Dieu réponde.$edm$, $edm$I. INTRODUCTION : QU'EST-CE QUE L'INVOCATION ?

La question fondamentale, celle qui est au cœur de toute la vie spirituelle du croyant, c'est celle-ci : Comment puis-je invoquer Dieu ?

Qu'est-ce que je dois savoir exactement pour que mon appel ne soit pas un simple cri qui se perd dans le vide ? Quelle est la connaissance qui me manque pour que, chaque fois que j'invoque Dieu, Il ne reste pas une idée lointaine, mais qu'Il se manifeste de manière présente, tangible et réelle dans mon ici et maintenant ?

Il faut que tu comprennes quelque chose d'essentiel : invoquer Dieu, ce n'est pas essayer de prouver que Dieu existe en parlant de Lui. Ce n'est pas un exercice religieux que tu fais pour montrer aux autres ou à toi-même que tu as la foi. Invoquer Dieu, ce n'est pas non plus une simple reconnaissance intellectuelle du fait qu'Il est partout.

Non. C'est une question de réalité concrète. C'est une question de tangibilité.

Celui qui invoque Dieu doit s'attendre à une seule et unique chose : que Dieu réponde.

Dieu a scellé cet engagement plusieurs fois dans Sa Parole : « Invoque-moi et je te répondrai. Appelle mon nom et je te répondrai. »

Ce n'est pas une éventualité. Ce n'est pas une suggestion soumise au hasard. C'est une promesse de réaction immédiate. Dieu ne peut pas être appelé et rester muet. L'invocation, c'est l'acte spirituel qui déclenche une réponse dans le monde physique. C'est l'acte par lequel l'homme refuse le silence du ciel et exige que le Créateur se manifeste.


II. LA DIFFÉRENCE FONDAMENTALE : PRIER VS INVOQUER

Il existe une distinction majeure, une frontière nette dans la pratique spirituelle, que beaucoup de croyants ne voient pas. Appeler et demander, ce n'est absolument pas la même chose.

La prière (demander). Quand tu pries, tu demandes. Et on peut demander sans force de paroles. Pourquoi ? Parce que Dieu, dans Son omniscience, a déjà reçu ta requête avant même que tu ne la formules.

La prière, c'est souvent une présentation de tes besoins, un exposé de tes difficultés. On prie dans une posture d'attente. On attend jusqu'à ce que Dieu agisse, c'est-à-dire jusqu'à ce que le résultat de l'action divine devienne visible dans nos circonstances.

Quand tu pries, tu attends l'exaucement.

L'invocation (appeler). Invoquer, ça veut dire littéralement appeler. Et quand il s'agit d'appeler, on entre dans une dimension de convocation.

Tu peux invoquer de manière incessante. Imagine que quelqu'un soit quelque part, peut-être occupé ou à une certaine distance. Tu peux crier son nom une fois, 10 fois, 100 fois, 1000 fois. Tu ne t'arrêtes pas tant qu'il ne s'est pas retourné vers toi, tant qu'il n'est pas venu à toi.

On peut appeler sans cesse. Cette répétition n'est pas une « vaine parole » ou une technique pour persuader Dieu. C'est l'insistance de celui qui réclame une présence. On répète l'appel jusqu'à ce que la personne réponde.

Dans l'invocation de Dieu, la règle est simple : c'est jusqu'à ce qu'Il réponde.

La différence cruciale : la prière attend une action. L'invocation exige une réponse.

- Prier, c'est demander à Dieu d'agir sur ta situation.
- Invoquer, c'est appeler Dieu pour qu'Il réponde et se manifeste.

Et voici la clé : Dieu peut ne pas exaucer ta prière (Il peut dire non à ce que tu demandes si ce n'est pas dans Sa volonté), mais Il ne peut pas ne pas répondre à ton invocation.

Quand tu L'appelles correctement, Il répond. Toujours. C'est Sa promesse.


III. POURQUOI L'HOMME INVOQUE-T-IL DIEU ?

Historiquement, et dans le secret de nos propres parcours, l'invocation surgit presque toujours du sol fertile de la détresse.

Les réalités dures de la vie terrestre sont là, implacables : la souffrance, le manque, l'oppression, l'impasse. Ce sont ces poids écrasants qui nous poussent hors de nous-mêmes vers le divin.

Dieu ne rejette pas ce cri né de la douleur. Il dit d'ailleurs : « Invoque-moi au jour de la détresse. »

Mais voici ce que beaucoup ne comprennent pas : le but de Dieu en nous invitant à L'invoquer dépasse de loin la simple résolution de nos problèmes immédiats. En répondant à l'invocation, Dieu poursuit des objectifs bien plus profonds :

1. Manifester Sa présence réelle. Il veut que tu sortes de la croyance abstraite. Il veut que tu ne te contentes plus de « croire » qu'Il est là parce que c'est écrit dans un livre. Il veut que tu le saches parce que tu L'as expérimenté. Il veut que ta foi passe de la théologie à l'expérience vivante.

2. Révéler les choses cachées. L'invocation est la clé dont parle Jérémie 33:3. Elle te donne accès à des secrets, à des dimensions cachées de ta propre vie, à des profondeurs dont tu n'avais aucune connaissance. Quand Dieu répond à ton invocation, Il ne se contente pas d'apparaître. Il ouvre ton intelligence à ce que tu ne pouvais pas voir.

3. Transmettre la connaissance. C'est le point vital. Son peuple périt par manque de connaissance. L'invocation est le canal par lequel le savoir divin descend pour éclairer l'intelligence humaine. C'est un téléchargement spirituel. Quand tu invoques Dieu, tu ne reçois pas seulement Sa présence, tu reçois Sa sagesse, Sa révélation, Sa compréhension des choses.$edm$, $edm$- Invoquer, ce n'est pas prouver que Dieu existe, ni faire un exercice religieux : c'est une question de réalité concrète.
- Celui qui invoque s'attend à une seule chose : que Dieu réponde.
- Prier, c'est demander et attendre l'exaucement. Invoquer, c'est appeler et exiger une réponse.
- On peut appeler sans cesse, jusqu'à ce que Dieu réponde.
- Dieu peut ne pas exaucer une prière, mais Il ne peut pas ne pas répondre à une invocation faite correctement.
- On invoque souvent dans la détresse, mais Dieu veut aller plus loin : manifester Sa présence, révéler les choses cachées, transmettre la connaissance.$edm$, $edm$Cette semaine, tu passes de la compréhension à l'expérience.

1. Fais la différence dans ta propre vie. Prends une feuille et écris : une situation pour laquelle tu as prié (demandé) et que tu attends encore, et une situation pour laquelle tu veux maintenant appeler Dieu jusqu'à ce qu'Il réponde.

2. Récite la promesse. Chaque matin, dis à voix haute : « Invoque-moi et je te répondrai. » Dis-la lentement, comme une promesse qui te concerne.

3. Fais un premier essai d'appel. Pendant cinq minutes, appelle Dieu simplement, en répétant son nom, sans rien demander. Note ce que tu remarques.

4. Note le but profond. À la fin de la semaine, écris : qu'ai-je expérimenté de Sa présence ? Qu'ai-je compris que je ne savais pas ?$edm$, $edm$✅ Acquis, je maîtrise bien : ...

⏳ En cours, je comprends mais je dois approfondir : ...

🔄 À travailler, je dois revenir dessus plus tard : ...

(Exemples de points à évaluer : la différence entre prier et invoquer · ce que j'attends quand j'invoque · les trois buts de Dieu dans l'invocation.)$edm$, false, true),
('formation', 7, 2, 2, $edm$Savoir invoquer Dieu$edm$, $edm$Connaître son Dieu$edm$, $edm$À la fin de ce module, tu sauras :
- expliquer pourquoi il faut connaître les noms de Dieu avant de L'invoquer ;
- expliquer pourquoi on apprend ces noms sous forme de poème ;
- distinguer les noms hébreux traduits et les noms qui disent ce que Dieu est ;
- connaître les noms du Père, du Fils et du Saint-Esprit, avec leur sens ;
- réciter par cœur, à voix haute, les trois poèmes.$edm$, $edm$ON N'APPELLE PAS UN INCONNU

Invoquer, c'est appeler quelqu'un par son nom. Et pour appeler quelqu'un par son nom, il faut d'abord le connaître. Beaucoup de gens crient « Dieu ! » sans savoir qui Il est. Toi, tu vas apprendre à connaître ton Dieu : ses noms, ses attributs, ce qu'Il est pour toi.


UN NOM DIT QUI IL EST

Dans la Bible, un nom ne sert pas seulement à désigner quelqu'un, il révèle sa nature. Quand Dieu se révèle par un nouveau nom, Il montre une facette de ce qu'Il est. Connaître ses noms, c'est donc connaître son caractère.


DEUX SORTES DE NOMS

- Les noms hébreux, que l'on traduit. Par exemple Jéhovah Jiré : l'Éternel pourvoira. El Shaddai : Dieu Tout-Puissant. On dit le nom, puis son sens.
- Les noms qui disent ce qu'Il est. Par exemple Alpha et Oméga : le commencement et la fin. Il est le Bon Berger. Il est la Lumière du monde. Ils commencent par « Il est ».


JÉHOVAH OU YAHWEH ?

C'est le même nom, celui que les Hébreux écrivaient YHWH. « Yahweh » est la transcription que retiennent la plupart des spécialistes, « Jéhovah » est la forme traditionnelle en français, et nos Bibles traduisent par « l'Éternel ».


LE PÈRE, LE FILS ET LE SAINT-ESPRIT

Dieu se révèle en trois personnes, et chacune a ses noms. Il n'existe aucune liste complète, car la Bible contient des centaines de noms et de titres. Tu vas en connaître un grand nombre, mais une question se pose aussitôt.


DU SAVOIR À LA RELATION

Il ne suffit pas de connaître ces noms comme on connaît une liste. Connaître, ici, veut dire : je sais qui Il est pour moi. Chaque nom, tu le dis donc pour toi : l'Éternel est ma paix, il est mon Berger, il est ma lumière. C'est ce qui transforme un savoir en relation.

Mais voici le problème : comment retenir autant de noms, avec leur sens ? Une liste à lire s'oublie vite. C'est pour cela que ce cours te les donne sous forme de poème.


POURQUOI UN POÈME ?

Le poème n'est pas une formule à dire pour invoquer Dieu. C'est un moyen de mémorisation, placé dans le cours pour t'aider à retenir les noms de Dieu. C'est comme les enfants à l'école : on leur fait chanter les leçons, parce que ce qui est chanté ou rythmé se retient bien mieux que ce qui est seulement lu.

1. Un poème se retient. Une liste de cent noms s'oublie en une heure. Un poème, avec son rythme et ses répétitions, s'imprime dans la mémoire. Dit à voix haute plusieurs fois, il reste en toi sans effort.

2. Un poème se dit à voix haute. Une liste se lit en silence, un poème se prononce. En le disant avec ta voix, tu retiens avec ta bouche, avec ton oreille et avec ton esprit, et non avec les yeux seulement.

3. Un poème rend le nom personnel. Une liste dit : « l'Éternel est paix ». Le poème te fait dire : « l'Éternel est ma paix ». Dans la liste, tu apprends une information sur Dieu. Dans le poème, tu retiens ce que Dieu est pour toi.


COMMENT LIRE ET APPRENDRE LES POÈMES

Chaque ligne contient trois choses : un nom de Dieu, son sens, et ce que ce nom devient pour toi. Prends cette ligne : Jéhovah Shalom, l'Éternel est paix, l'Éternel est ma paix. Le nom est Jéhovah Shalom, son sens est « l'Éternel est paix », et « ma paix » est ce que tu dis pour toi.

1. Lis d'abord le poème lentement et en entier, sans chercher à retenir.
2. Relis-le ligne par ligne, à voix haute, en pensant à ce que chaque nom veut dire.
3. Apprends-le par petits blocs, un bloc après l'autre.
4. Reviens-y souvent, jusqu'à pouvoir le réciter sans le lire.

Tu n'as pas besoin de tout comprendre d'un coup pour commencer. Ce qui compte, c'est de répéter, à voix haute, jusqu'à ce que les noms soient en toi.


POÈME DU PÈRE

Elohim, Dieu mon Créateur, c'est Toi qui m'as formé.
El Shaddai, Dieu Tout-Puissant, rien ne Te dépasse dans ma vie.
El Elyon, Dieu Très-Haut, Tu es au-dessus de tout ce qui m'entoure.
El Olam, le Dieu éternel, Tu étais avant moi, Tu seras toujours.
El Roï, le Dieu qui me voit, rien de moi ne T'est caché.
El Haï, le Dieu vivant, Tu es vivant pour moi.

Jéhovah Jiré, l'Éternel pourvoira, Il pourvoit à tout ce qui me manque.
Jéhovah Rapha, l'Éternel qui guérit, Il est mon guérisseur.
Jéhovah Nissi, l'Éternel ma bannière, je me tiens sous Son drapeau.
Jéhovah Shalom, l'Éternel est paix, l'Éternel est ma paix.
Jéhovah Tsidkenou, l'Éternel notre justice, l'Éternel est ma justice.
Jéhovah Shammah, l'Éternel est là, Il est là avec moi.
Jéhovah Mekaddishkem, l'Éternel qui me sanctifie.
Jéhovah Sabaoth, l'Éternel des armées, qui combat pour moi.
Jéhovah Roï, l'Éternel mon berger, je ne manquerai de rien.
Jéhovah Ori, l'Éternel ma lumière.
Jéhovah Uzzi, l'Éternel ma force.
Jéhovah Machsi, l'Éternel mon refuge.

Il est le JE SUIS, celui qui est, qui était, et qui sera toujours pour ma vie.
Il est Adonaï, mon Seigneur et mon Maître.
Il est le Saint d'Israël, le Roi éternel, qui règne à jamais sur ma vie.
Il est mon Rocher, mon Bouclier, ma haute retraite.
Il est mon Sauveur, mon Rédempteur.
Il est le Dieu fidèle, qui tient parole.
Il est le Dieu qui pardonne, qui efface mes fautes.
Il est le Père des miséricordes, le Dieu de toute consolation, Il me console.
Il est le Dieu de paix, le Dieu de ma paix.
Il est le Dieu d'espérance, le Dieu de mon espérance.
Il est le Dieu de toute grâce, le Dieu de toutes mes grâces.
Il est le Père des lumières, Il est ma lumière.
Il est le Dieu de vérité, Il est ma vérité.
Il est amour, Il m'a aimé le premier, et moi aussi, je L'aime.


POÈME DU FILS

Yeshoua, l'Éternel sauve, l'Éternel m'a sauvé.
HaMashiach, l'Oint, le Christ, celui qui est mort pour moi.
Emmanuel, Dieu avec nous, Dieu avec moi.
Il est le Sauveur, le Sauveur du monde, mon Sauveur.
Il est le Seigneur, le Fils de Dieu, le Fils de l'homme.
Il est mon Rabbi, le Maître qui m'enseigne.
Il est le Verbe, la Parole faite chair, la Parole devenue homme pour moi.

Il est l'Admirable, mon Admirable.
Il est le Conseiller, mon Conseiller.
Il est le Dieu puissant, mon Dieu Tout-Puissant.
Il est le Père éternel.
Il est le Prince de la paix, le Prince de ma paix.
Il est l'Agneau de Dieu qui ôte le péché du monde, qui a ôté le péché qui m'écrasait.

Il est l'Alpha et l'Oméga, le commencement et la fin, le début et la fin de ma vie.
Il est le Fidèle et le Véritable, celui qui ne trahit jamais.
Il est le Vivant, celui qui a les clés de la mort.
Il est le Roi des rois et le Seigneur des seigneurs.
Il est le Lion de la tribu de Juda, le vainqueur qui a vaincu pour moi.

Il est le Pain de vie, le pain de ma vie.
Il est la Lumière du monde, celui qui m'éclaire.
Il est la Porte, par Lui j'entre.
Il est le Bon Berger, qui a donné sa vie pour moi.
Il est la Résurrection et la Vie, j'étais mort, et je suis ressuscité en Christ.
Il est le Chemin, la Vérité et la Vie, par Lui j'ai accès au Père.
Il est le vrai Cep, je demeure en Lui, Il m'émonde afin que je porte plus de fruit.

Il est mon Avocat, mon Intercesseur, mon Médiateur, devant Dieu, je suis pur.
Il est le grand Souverain Sacrificateur.
Il est la Pierre angulaire, ma vie est bâtie sur Lui.
Il est l'Époux, mon Époux.


POÈME DU SAINT-ESPRIT

Il est l'Esprit de Dieu.
Il est le Parakletos, mon Consolateur, celui qui est appelé à mes côtés.
Il est l'Enseignant, qui m'enseigne toutes choses.
Il est l'Esprit de vérité, qui me conduit dans toute la vérité.
Il est l'Esprit de vie.
Il est l'Esprit d'adoption, par Lui je crie : Abba, Père.
Il est l'Esprit de grâce.

Il est l'Esprit de sagesse,
l'Esprit d'intelligence,
l'Esprit de conseil,
l'Esprit de force,
l'Esprit de connaissance,
l'Esprit de la crainte de l'Éternel.

Il est l'Esprit de la promesse, Il me scelle.
Il est les arrhes, le gage de mon héritage.
Il est le Don de Dieu.$edm$, $edm$- On n'invoque bien que celui qu'on connaît.
- Un nom de Dieu révèle ce qu'Il est.
- Il y a des noms hébreux traduits et des noms qui commencent par « Il est ».
- Jéhovah et Yahweh sont le même nom.
- Le poème est un moyen de mémorisation, comme un chant qui aide les enfants à retenir une leçon : il se retient, se dit à voix haute et rend le nom personnel.
- Le Père, le Fils et le Saint-Esprit ont chacun leurs noms, que le poème rassemble.
- Je dis chaque nom pour moi : mon Berger, ma paix, ma lumière.$edm$, $edm$Cette semaine, tu apprends les trois poèmes du contenu par cœur et tu les récites à voix haute. Avant de commencer, relis « Pourquoi un poème ? », pour savoir pourquoi tu le fais : retenir les noms de ton Dieu.

1. Jours 1 et 2 : le Père. Lis le poème en entier, puis apprends-le par petits blocs (les noms en El, puis ceux en Jéhovah, puis ceux en « Il est »). Un bloc après l'autre.
2. Jours 3 et 4 : le Fils. Même méthode.
3. Jour 5 : le Saint-Esprit. Le plus court : tu peux le réciter en entier ce jour-là.
4. Jours 6 et 7 : les trois ensemble. Récite-les d'un trait, à voix haute, le matin.

Quelques conseils :
- Récite à voix haute, pas dans ta tête.
- Dis chaque nom pour toi (« mon Berger », « ma paix »).
- Enregistre ta voix et réécoute-toi pour vérifier ce que tu as retenu.$edm$, $edm$✅ Acquis, je maîtrise bien : ...

⏳ En cours, je comprends mais je dois approfondir : ...

🔄 À travailler, je dois revenir dessus plus tard : ...

(Exemples de points à évaluer : pourquoi un poème · le poème du Père · le poème du Fils · le poème du Saint-Esprit · réciter sans lire · dire les noms pour moi.)$edm$, false, true),
('formation', 8, 2, 2, $edm$Savoir invoquer Dieu$edm$, $edm$Invoquer avec précision$edm$, $edm$À la fin de ce module, tu sauras :
- expliquer pourquoi connaître le nom de Dieu donne de la puissance à ton appel ;
- comprendre que Dieu s'est révélé comme « JE SUIS », la réponse exacte à ta réalité ;
- reconnaître l'erreur d'invoquer « n'importe comment » ;
- identifier ta réalité actuelle et l'attribut de Dieu qui y répond.$edm$, $edm$LE SECRET DE LA PUISSANCE : CONNAÎTRE LES ATTRIBUTS DU « JE SUIS »

Pour invoquer Dieu de manière efficace et puissante, il te faut impérativement savoir qui Il est.

Tu ne peux pas appeler avec succès quelqu'un dont tu ignores le nom ou avec qui tu n'as aucune relation spécifique.

Exemple concret : si tu es dans un lieu public bondé et que tu cries « Monsieur ! », qu'est-ce qui se passe ? Soit personne ne répond, soit tout le monde se retourne sans savoir qui est concerné. L'appel est dilué, il manque de cible, il n'a pas de puissance.

Mais si tu appelles par un nom précis, la personne concernée tressaille immédiatement et réagit.

Dieu s'est révélé comme « JE SUIS ». Ce n'est pas un nom statique, figé. C'est une identité en mouvement. Cela signifie qu'Il est la réponse immédiate et exacte à la réalité que tu traverses au moment précis où tu L'appelles.

- Si tu es dans la confusion et que tu as besoin de direction, Dieu EST la Connaissance.
- Si tu es face à la mort ou à la stagnation, Dieu EST la Vie et la Résurrection.
- Si tu es dans l'indigence, Dieu EST le Pourvoyeur.
- Si ton corps est brisé, Dieu EST la Guérison.
- Si tu es dans les ténèbres, Dieu EST la Lumière.


L'ERREUR FATALE : INVOQUER « N'IMPORTE COMMENT »

Invoquer Dieu « n'importe comment », avec des termes vagues et généraux, c'est une erreur de connaissance qui paralyse la réponse.

Beaucoup disent simplement « Seigneur, Seigneur », mais cela reste une formule religieuse sans substance réelle. Ce sont des mots dans le vide.

La puissance réside dans la précision.

Il faut se référer aux attributs de Dieu révélés dans la Bible. Qui appelles-tu exactement ?

- « J'appelle le Dieu de ma réalité actuelle. »
- « J'appelle le Dieu qui domine cette circonstance précise. »
- « J'appelle le Dieu qui EST ma Lumière dans ces ténèbres. »
- « J'appelle le Dieu qui EST ma Force dans cette faiblesse. »

C'est cette précision qui force la porte du ciel. C'est cette connaissance précise de Ses noms et de Ses attributs qui rend ton invocation irrésistible.


LES ATTRIBUTS DE DIEU SELON TES BESOINS

Si tu es dans la confusion, l'ignorance, le doute : invoque Dieu comme la Sagesse, la Connaissance, la Lumière. Jacques dit que si quelqu'un manque de sagesse, qu'il la demande à Dieu. Jésus a dit « Je suis la Lumière du monde ». C'est cet attribut que tu dois invoquer.

Si tu es malade, ton corps souffre, tu as une infirmité : invoque le Guérisseur, Jéhovah Rapha. Dieu a dit « Je suis l'Éternel qui te guérit » (Exode 15:26). Il a pris nos infirmités et porté nos maladies. C'est ce Dieu-là que tu appelles.

Si tu es dans la pauvreté, le manque, l'indigence : invoque le Pourvoyeur, Jéhovah Jiré. Abraham L'a appelé ainsi quand Dieu a pourvu le bélier (Genèse 22:14). Paul dit que Dieu pourvoira à tous vos besoins selon sa richesse (Philippiens 4:19).

Si tu es dans la peur, l'anxiété, l'angoisse : invoque la Paix, le Refuge, la Forteresse. Jésus a dit « Je vous laisse ma paix ». Le Psaume 91 Le révèle comme notre refuge et notre forteresse.

Si tu te sens seul, abandonné, rejeté : invoque l'Ami, le Compagnon, Celui qui ne t'abandonne jamais. Dieu a promis « Je ne te délaisserai point, je ne t'abandonnerai point » (Hébreux 13:5). Jésus a appelé ses disciples « mes amis ».

Si tu es opprimé, dans un combat spirituel, attaqué : invoque le Guerrier, le Libérateur, l'Éternel des Armées. Exode 15:3 dit « L'Éternel est un vaillant guerrier ». C'est Lui qui combat pour toi.

Si tu es accablé par le péché, la culpabilité, la condamnation : invoque le Pardon, la Purification, la Justification. 1 Jean 1:9 dit que si nous confessons nos péchés, Il est fidèle et juste pour nous pardonner et nous purifier.

Si tu es face à la mort, au désespoir, à la stagnation : invoque la Résurrection et la Vie. Jésus a dit « Je suis la résurrection et la vie » (Jean 11:25). Là où il y a mort, Il apporte la vie.

Si tu es égaré, perdu, sans direction : invoque le Berger, le Chemin, le Guide. Le Psaume 23 révèle Dieu comme notre berger. Jésus a dit « Je suis le chemin » (Jean 14:6).

Si tu as besoin de conseil, de direction pour tes décisions : invoque le Conseiller Admirable. Ésaïe 9:5 Le révèle ainsi. C'est Celui qui t'éclaire dans tes choix.

Si tu as besoin d'enseignement, de révélation, de compréhension : invoque le Saint-Esprit, l'Enseignant. Jésus a dit que le Saint-Esprit vous enseignera toutes choses (Jean 14:26). C'est Lui qui ouvre ton intelligence.

Si tu as besoin de consolation, de réconfort, de force : invoque le Saint-Esprit, le Consolateur. C'est Son nom même (Jean 14:16). Il est celui qui est appelé à tes côtés pour te consoler.$edm$, $edm$- Pour invoquer avec puissance, il faut savoir qui Dieu est.
- Un appel sans nom précis est dilué, comme « Monsieur ! » crié dans la foule.
- Dieu s'est révélé comme « JE SUIS » : une identité en mouvement, la réponse exacte à la réalité que je traverse.
- L'erreur fatale est d'invoquer « n'importe comment », avec des termes vagues.
- La puissance réside dans la précision.
- Chaque réalité (confusion, maladie, manque, peur, solitude, combat, péché, mort, égarement, besoin de conseil, d'enseignement, de consolation) appelle un attribut précis de Dieu.$edm$, $edm$Fais ce travail à froid, avant de te mettre à invoquer, avec une feuille et un stylo. Prends une seule situation, la plus présente en ce moment.

ÉTAPE 1 : IDENTIFIER TA RÉALITÉ ACTUELLE

Pose-toi cette question : Quelle est ma situation exacte maintenant ? Sois précis. Ne reste pas dans le vague.

Exemples :
- « Je suis confus, je ne sais pas quelle décision prendre »
- « Je suis malade, mon corps souffre »
- « Je suis dans le manque financier »
- « Je suis accablé par la peur »
- « Je me sens seul et abandonné »
- « Je suis dans les ténèbres, je ne comprends pas ce qui m'arrive »

Écris ta réalité actuelle :

_________________________________

ÉTAPE 2 : IDENTIFIER L'ATTRIBUT DE DIEU QUI CORRESPOND

Reprends « Les attributs de Dieu selon tes besoins » dans le contenu et cherche l'attribut qui répond exactement à ta réalité. Les noms, tu les as appris au module 2, donc tu les reconnais : tu n'as pas à chercher longtemps. Choisis-en un seul.

Quel attribut de Dieu correspond à ta réalité ?

_________________________________

Garde cette feuille, elle te servira au module suivant.$edm$, $edm$✅ Acquis, je maîtrise bien : ...

⏳ En cours, je comprends mais je dois approfondir : ...

🔄 À travailler, je dois revenir dessus plus tard : ...

(Exemples de points à évaluer : pourquoi la précision donne de la puissance · le « JE SUIS » · l'erreur d'invoquer n'importe comment · identifier ma réalité · choisir l'attribut qui y répond.)$edm$, false, true),
('formation', 9, 2, 2, $edm$Savoir invoquer Dieu$edm$, $edm$Entrer et invoquer$edm$, $edm$À la fin de ce module, tu sauras :
- te mettre en position avant d'invoquer : poser, entrer, te disposer ;
- comprendre ce qui se passe en toi pendant l'invocation incessante ;
- reconnaître la réponse de Dieu, qui vient par le Saint-Esprit ;
- persévérer jusqu'à la réponse, sans t'arrêter trop vite ;
- conduire toi-même une session d'invocation du début à la fin.$edm$, $edm$SE METTRE EN POSITION : POSER, ENTRER, SE DISPOSER

Entendre Dieu, invoquer Dieu, sous-entend trois choses pratiques : poser, entrer, se disposer.

1. Poser. Humainement, tu ne peux pas te déconnecter du monde par ta seule force. Ce n'est pas ce qu'on te demande. On te demande de poser : tu décides de ne plus t'accrocher à tout ce qui existe physiquement autour de toi et en toi. La famille, le travail, les inquiétudes, les pensées, les sentiments, les ressentiments, le vide, le manque, les relations, les choses de la vie physique. Tu ne fabriques pas le silence, tu choisis de ne plus tenir ces choses. C'est l'invocation elle-même qui fera la déconnexion réelle.

2. Entrer. C'est ce qui fait la particularité d'un enfant de Dieu : intégrer le règne de l'esprit. Tu te vois et tu te conçois dans une dimension spirituelle, en Christ. Les yeux fermés, il y a un nom qui t'admet dans le règne de l'esprit : Jésus. Au nom de Jésus, par la prière, par le jeûne et même par la méditation, tu entres. Et quand tu es admis dans ce règne, toutes tes pensées existent dans le but d'entendre Dieu.

3. Te disposer. Quand tu es dans la dimension de l'esprit, il faut une précision : pourquoi je viens ? Je pourrais venir pour adorer Dieu, pour supplier Dieu, pour parler à Dieu. Mais ici, je me dispose à appeler Dieu, à l'invoquer. C'est tellement précis. Il dit : « Invoque-moi et je te répondrai », et à ce moment-là tu commences à L'invoquer.


CE QUI SE PASSE PENDANT QUE TU INVOQUES

Ce que tu as décidé de poser au départ, c'est maintenant l'invocation incessante qui le réalise.

Pendant que tu continues d'invoquer de manière incessante, un processus spirituel profond et transformateur se met en place.

LES 5 PREMIÈRES MINUTES : LE COMMENCEMENT DU VIDAGE

« Jésus, JE T'APPELLE ! » (tu répètes)

Tes pensées sont encore très présentes. Elles tournent en boucle : « Est-ce que ça va marcher ? », « J'ai tellement de problèmes », « Qu'est-ce que je vais faire si... », « Peut-être que je devrais arrêter... ». Tes émotions sont encore fortes : la peur, l'anxiété, la tristesse, le doute. Tu es encore très conscient du monde autour de toi, de tes problèmes, de toi-même.

Continue quand même. Ne t'arrête pas parce que tu ne « sens » rien encore. C'est normal. Tu es en train de commencer le processus de vidage.

10 À 20 MINUTES : TES PROPRES PENSÉES COMMENCENT À S'EFFACER

« Jésus, JE T'APPELLE ! » (tu répètes)

Tes pensées commencent à perdre de leur force. Elles sont encore là, mais elles deviennent moins bruyantes. Tu es moins distrait par elles. Ton focus devient plus clair. Tu commences à être vraiment concentré sur l'invocation elle-même. Le bruit mental commence à diminuer.

Continue. Plus fort même. Tu commences à entrer dans quelque chose de réel. Ne recule pas maintenant.

30 MINUTES À 1 HEURE : TES PROPRES SENTIMENTS S'EFFACENT

« Jésus, JE T'APPELLE ! » (tu répètes, sans t'arrêter)

Tes émotions se calment progressivement. La peur qui t'oppressait recule. L'anxiété diminue. La tristesse perd son emprise. Ce n'est pas que tu les ignores volontairement : c'est que l'invocation incessante les déplace. Il ne reste plus de place pour elles. Tu entres dans une zone de calme profond que tu n'avais pas au début.

Continue. Tu es sur le bon chemin. C'est maintenant que beaucoup abandonnent parce qu'ils se sentent « mieux ». Mais le « mieux » n'est pas l'objectif. La réponse de Dieu est l'objectif.

AU-DELÀ D'1 HEURE : UNE SEULE CHOSE DEVIENT IMPORTANTE

« Jésus, JE T'APPELLE ! » (tu continues, inlassablement)

Progressivement, ton objectif devient de L'entendre. Rien d'autre ne compte plus. Tes problèmes ? Secondaires. Tes besoins ? Secondaires. Tes questions ? Secondaires. Une seule chose compte désormais : que Dieu parle. Tant qu'Il ne te parle pas, tu es là. Tu restes là. Tu continues d'appeler. Tu ne bouges pas jusqu'à ce qu'Il te parle.

LA GRANDE DÉCONNEXION SE PRODUIT

- Déconnexion du monde. Le bruit du monde extérieur, ses préoccupations, ses urgences factices, ses sollicitations constantes, tout cela se tait. Tu n'es plus dans le monde. Tu es dans un espace spirituel où seul Dieu compte.
- Déconnexion de l'orgueil personnel. Ton ego, ta suffisance, ton impression de contrôler ta vie, tout cela s'effondre. Tu réalises ta dépendance totale. Tu deviens simplement celui qui appelle et qui attend.
- Déconnexion du moi. Tes désirs personnels, tes ambitions, ce que « toi » tu veux, tout cela passe au second plan. Il ne reste que la soif de Dieu.
- Déconnexion des pensées sarcastiques. Ces voix intérieures qui se moquent, qui critiquent, qui doutent, se taisent. L'invocation les fait fuir.
- Déconnexion des pensées d'inquiétude et de tristesse. Plus tu invoques, moins ces pensées ont de prise sur toi. Elles perdent leur pouvoir. Elles s'évaporent.

LE VIDAGE COMPLET DE L'ESPRIT

L'invocation incessante vide ton esprit de tout ce qui est inutile. Toutes les voix étrangères (les voix de la chair, de l'âme, les voix inutiles, les voix extérieures) se taisent progressivement. Les pensées parasites, les préoccupations sans fin, les doutes, les peurs, tout cela est évacué. Ton esprit devient comme un bocal vide, un espace pur qui n'attend qu'un seul liquide spécial : la présence du Saint-Esprit. Tu ne vides pas ton esprit juste pour le vider. Tu le vides pour faire de la place au Saint-Esprit.

L'ÉTAT DE RÉCEPTIVITÉ TOTALE

Tellement ton esprit est devenu pur et silencieux, tu n'existes plus que pour entendre Dieu. La personne que tu étais, avec toutes ses préoccupations, ses pensées, ses émotions, n'existe plus à ce moment-là. Il ne reste que quelqu'un qui écoute, qui attend, qui a soif de la voix de Dieu.


RECONNAÎTRE LA RÉPONSE DE DIEU

C'est dans cet espace vide et pur, créé par l'invocation incessante, que Dieu répond. Et voici ce qui est capital : quand Dieu répond à ton invocation, c'est le Saint-Esprit qui vient.

La douce voix de Dieu (le Saint-Esprit qui parle). C'est souvent la manière la plus manifeste dont Dieu répond. Ce n'est pas un cri tonitruant, ni une voix audible comme celle d'un homme. C'est une voix douce, intérieure, paisible, mais tellement claire et reconnaissable. C'est le Saint-Esprit qui parle directement à ton esprit. Tu l'entends dans ton cœur. Elle est douce, mais elle porte une autorité absolue et apporte la certitude. Quand le Saint-Esprit parle ainsi, tu sais que c'est Lui : ce n'est pas ta propre pensée qui vagabonde, c'est Sa voix. Élie l'a expérimenté : Dieu n'était pas dans le vent violent, ni dans le tremblement de terre, ni dans le feu, mais dans un murmure doux et léger (1 Rois 19:12). Cette douce voix est précise : le Saint-Esprit te guide, te console, te corrige, te révèle. Elle résonne clairement parce qu'il n'y a plus rien pour la couvrir. Juste toi et le Saint-Esprit. Juste ton esprit vide et Sa voix qui le remplit.

Le Saint-Esprit qui enseigne (compréhension soudaine). Quelque chose que tu ne comprenais pas devient soudain clair dans ton esprit. Les pièces du puzzle se mettent en place. Tes yeux spirituels s'ouvrent. C'est le Saint-Esprit qui répond en éclairant ton intelligence. Jésus a dit : « Le consolateur, l'Esprit Saint, que le Père enverra en mon nom, vous enseignera toutes choses » (Jean 14:26).

Le Saint-Esprit qui conduit (direction précise). Tu ne savais pas quoi faire, et soudainement tu sais. Ce n'est pas que tu as réfléchi et trouvé une solution : la direction s'est imposée à toi de manière claire. Jésus a dit : « Quand le consolateur sera venu, l'Esprit de vérité, il vous conduira dans toute la vérité » (Jean 16:13).

Le Saint-Esprit qui console (paix soudaine). Tu étais troublé, agité, et soudainement une paix profonde envahit ton cœur. Ce n'est pas une paix que tu as fabriquée par ta volonté, c'est une paix qui descend sur toi. Cette paix-là surpasse toute intelligence (Philippiens 4:7).

Une parole intérieure claire. Parfois, ce n'est pas une voix que tu entends, mais une parole qui s'impose dans ton esprit avec une force et une clarté inhabituelles. Ce n'est pas ta propre réflexion. Elle porte l'autorité, elle apporte la paix ou la direction, elle coupe court à toute confusion.

Une manifestation physique. Un changement dans ton corps si tu étais malade. Un changement dans ta situation si tu étais dans le besoin. Une porte qui s'ouvre alors qu'elle était fermée. C'est la réponse tangible de Dieu dans le monde physique.

Un verset biblique qui s'illumine. Tu lis ou tu te souviens d'un passage des Écritures, et il devient vivant pour toi. Il parle directement à ta situation. C'est le Saint-Esprit qui te parle à travers la Parole de Dieu.


NE T'ARRÊTE PAS TROP VITE

Instruction critique. Beaucoup invoquent 2 ou 3 minutes et abandonnent en disant « Dieu ne répond pas ». Ne fais pas cette erreur.

Invoque jusqu'à ce que ton esprit soit complètement vide de tout ce qui n'est pas Dieu. Invoque jusqu'à ce que tu n'existes plus que pour L'entendre. Invoque jusqu'à ce qu'il y ait de la place pour que le Saint-Esprit vienne et remplisse le vide. C'est là qu'Il répond.

Le vidage de ton esprit prend du temps. La déconnexion de toutes les voix parasites ne se fait pas en 5 minutes. Persiste. Insiste. Refuse d'abandonner. Dieu a promis de répondre à celui qui L'invoque. Il le fera. Mais Il attend que tu sois dans l'état de réceptivité totale où Sa voix peut être entendue clairement.


QUESTIONS PRATIQUES FRÉQUENTES

Combien de temps dois-je invoquer ? Jusqu'à ce que Dieu réponde par Son Saint-Esprit. Ça peut être 5 minutes pour certains, 1 heure, plusieurs heures, ou plusieurs jours où tu reviens invoquer encore et encore. Ne t'arrête pas avant la réponse. La promesse de Dieu est claire : Il répondra.

Dois-je invoquer à voix haute ? Oui, si possible. L'invocation verbale a une puissance particulière. Ta voix déchire l'atmosphère spirituelle. Tu engages tout ton être, pas seulement ta pensée. Si tu ne peux pas parler à voix haute, le Saint-Esprit entend aussi ton cœur. Mais chaque fois que c'est possible, invoque à voix audible.

Que faire si je ne « sens » rien pendant les premières minutes ? C'est normal. Continue. Le vidage de ton esprit et la déconnexion de toutes les voix parasites prennent du temps. Le processus est en train de se mettre en place même si tu ne le sens pas immédiatement. Tu es en train de créer l'espace pour que le Saint-Esprit vienne.

Comment savoir si c'est vraiment le Saint-Esprit qui parle ou juste mes propres pensées ? La voix du Saint-Esprit a des caractéristiques reconnaissables. Elle apporte la paix, même quand elle te corrige. Elle est alignée avec la Parole de Dieu. Elle porte une autorité qui n'est pas la tienne. Elle produit du fruit : sagesse, direction claire, consolation véritable. Avec la pratique de l'invocation, tu apprendras à reconnaître Sa voix de plus en plus clairement.

Puis-je invoquer plusieurs attributs en même temps ? Oui, si ta situation l'exige. Par exemple, si tu es malade ET dans le manque financier, tu peux invoquer « le Guérisseur et le Pourvoyeur ». Mais reste précis. Ne dilue pas ton invocation en appelant dix attributs différents sans focus.

Et si Dieu ne répond pas dans le sens que j'attendais ? Souviens-toi de la différence entre invoquer et prier. Quand tu invoques, tu demandes une RÉPONSE (la manifestation du Saint-Esprit), pas nécessairement un EXAUCEMENT spécifique. Le Saint-Esprit répondra toujours, mais Sa réponse peut être différente de ce que tu imaginais. Paul demandait la guérison, Dieu a répondu « Ma grâce te suffit ». C'était une vraie réponse, celle dont il avait réellement besoin.

Que faire si mes pensées reviennent pendant l'invocation ? C'est normal, surtout au début. Ne les combats pas. Continue d'invoquer. Répète le nom de Dieu encore et encore. Plus tu invoques, plus ces pensées perdront leur force et finiront par s'évaporer. L'invocation incessante est l'arme qui chasse les pensées parasites et qui fait de la place pour le Saint-Esprit.$edm$, $edm$- Avant d'invoquer, je me mets en position : je pose (je décide de ne plus m'accrocher), j'entre (au nom de Jésus, dans le règne de l'esprit), je me dispose (je viens pour appeler).
- Je ne peux pas me déconnecter par mes seules forces : c'est l'invocation incessante qui réalise la déconnexion.
- Au début, les pensées et les émotions sont fortes. Elles s'effacent progressivement si je continue.
- Le « mieux » n'est pas l'objectif : la réponse de Dieu est l'objectif.
- L'invocation vide l'esprit pour faire de la place au Saint-Esprit.
- Quand Dieu répond, c'est le Saint-Esprit qui vient : par une voix douce, une compréhension, une direction, une paix, une parole intérieure, une manifestation physique ou un verset qui s'illumine.
- La voix du Saint-Esprit apporte la paix, est alignée avec la Parole de Dieu et porte une autorité qui n'est pas la mienne.
- Je ne m'arrête pas trop vite : j'invoque jusqu'à ce que Dieu réponde.$edm$, $edm$UNE SESSION D'INVOCATION, DU DÉBUT À LA FIN

1. Identifie ta situation. Reprends la feuille du module 3 : une seule situation, celle qui te pèse le plus, et l'attribut de Dieu qui y répond. Demande-toi aussi comment le Saint-Esprit peut répondre : as-tu besoin qu'Il t'enseigne, qu'Il te conduise, ou qu'Il te console ?

2. Prépare-toi. Trouve un endroit où tu peux invoquer à voix haute sans être dérangé.

3. Mets-toi en position. Pose, entre, dispose-toi.

4. Pose le cadre. Fais la déclaration initiale :

   « Ô [Nom/Attribut de Dieu], JE T'INVOQUE !
   Toi qui es [rappelle qui Il est selon Sa Parole],
   [Décris ta situation en quelques mots],
   Mais Toi Tu es [affirme qu'Il EST la solution] !
   JE T'INVOQUE ! Manifeste-Toi à moi !
   Réponds-moi !
   JE T'INVOQUE jusqu'à ce que Tu répondes ! »

5. Entre dans l'appel incessant.

   « [Nom de Dieu], JE T'APPELLE ! »

   Continue. Continue. Continue. Sans t'arrêter.

6. Ne t'arrête pas avant que le Saint-Esprit réponde. Continue pendant des heures s'il le faut. Laisse le processus de vidage se faire. Fais de la place pour que le Saint-Esprit vienne.

7. Reçois la réponse. Quand le Saint-Esprit répond (et Il le fera), reçois Sa réponse avec reconnaissance. Qu'Il t'enseigne, te conduise ou te console, reçois ce qu'Il te donne. Note ensuite ce que tu as reçu.


EXEMPLE D'UNE SESSION COMPLÈTE

Situation : tu es dans la confusion totale concernant une décision importante.

Tu identifies l'attribut : Dieu de Sagesse, Lumière, Conseiller Admirable, Saint-Esprit Enseignant.

Tu poses le cadre :

« Ô Dieu de Sagesse, Lumière du monde, Conseiller Admirable, JE T'INVOQUE !
Toi qui connais toutes choses, Toi qui éclaires les ténèbres,
Je suis dans la confusion, je ne sais pas quelle décision prendre,
Mais Toi Tu es ma Sagesse, Tu es ma Lumière, Tu es mon Conseiller !
JE T'INVOQUE ! Manifeste-Toi à moi !
Saint-Esprit, viens m'enseigner, viens me conduire !
Réponds-moi ! Éclaire mon intelligence !
JE T'INVOQUE jusqu'à ce que Tu répondes ! »

Puis tu continues l'appel incessant :

« Jésus, ma Lumière, JE T'APPELLE ! » (tu répètes)

- Les 5 premières minutes : tes pensées tournent encore (« Et si je me trompe ? », « Peut-être que je devrais... », « Les gens vont penser que... »). Tu continues quand même.
- 10 à 20 minutes : les pensées perdent de leur force. Tu es plus concentré sur l'invocation. Le bruit mental diminue. Tu continues.
- 30 minutes à 1 heure : l'anxiété s'évapore. La peur recule. Tu entres dans un calme profond, mais ce n'est pas encore la réponse. Tu continues.
- Au-delà d'1 heure : ton esprit est maintenant vide. Tu n'existes plus que pour une chose : L'entendre. Il y a de la place pour que le Saint-Esprit vienne. Tu continues.
- Et soudain, le Saint-Esprit répond. Sa douce voix se fait entendre, claire, précise, paisible mais autoritaire : « Choisis le chemin A. Je serai avec toi. » Ou une compréhension soudaine s'impose : le Saint-Esprit t'enseigne. Ou une paix absolue envahit ton cœur concernant une option : le Saint-Esprit te console. Ou une direction précise s'impose : le Saint-Esprit te conduit. Dieu a répondu par Son Saint-Esprit.

C'est maintenant. Pas demain. Pas ce soir. Maintenant.

Quelle situation vas-tu amener devant Dieu en invocation dès maintenant ? Quel aspect du Saint-Esprit as-tu besoin de recevoir : Son enseignement, Sa direction ou Sa consolation ?$edm$, $edm$✅ Acquis, je maîtrise bien : ...

⏳ En cours, je comprends mais je dois approfondir : ...

🔄 À travailler, je dois revenir dessus plus tard : ...

(Exemples de points à évaluer : poser, entrer, me disposer · ce qui se passe pendant l'invocation · reconnaître la voix du Saint-Esprit · persévérer jusqu'à la réponse · ma première session complète.)$edm$, false, true),
('formation', 10, 2, 2, $edm$Savoir invoquer Dieu$edm$, $edm$Invoquer pour la communion$edm$, $edm$À la fin de ce module, tu sauras :
- invoquer Dieu non par détresse, mais pour communier avec Lui ;
- comprendre que, dans la communion, c'est le Saint-Esprit qui vient ;
- citer ses trois missions : t'enseigner, te conduire, te consoler ;
- invoquer avec autorité et assurance, parce que tu connais Celui que tu appelles.$edm$, $edm$V. LA DIMENSION SUPÉRIEURE : L'INVOCATION POUR LA COMMUNION

Il existe une dimension de l'invocation que le monde religieux ignore trop souvent, parce qu'il est trop occupé à demander des miracles : invoquer Dieu pour communier avec Lui.

Ici, l'objectif n'est plus de « régler un problème » ou d'obtenir quelque chose. L'objectif, c'est d'habiter avec la Vie elle-même.

Notre Dieu n'est pas un distributeur automatique de solutions. Ce n'est pas une machine à miracles qu'on active quand on a un besoin. C'est un Dieu d'intimité.

Tu n'as pas besoin d'être dans la détresse pour invoquer Dieu. Tu peux L'invoquer simplement pour être avec Lui. C'est même la dimension la plus élevée de l'invocation : appeler Dieu non pas parce que tu as un problème, mais parce que tu désires Sa présence.


LES ATTRIBUTS RELATIONNELS DE DIEU

Selon le prophète Ésaïe, Il est l'Admirable Conseiller. Il est l'Ami fidèle.

Invoquer Dieu pour ta marche quotidienne, c'est L'appeler simplement parce que tu as soif de Sa présence. Parce que tu refuses de faire un pas de plus sans Lui. C'est vouloir vivre en intimité constante avec Lui. C'est faire de chaque instant un autel d'appel.


LA PRÉSENCE RÉELLE : LE SAINT-ESPRIT QUI VIENT

Voici ce qu'il faut absolument comprendre concernant la présence réelle de Dieu quand tu L'invoques pour la communion : c'est le Saint-Esprit qui vient.

Jésus Lui-même l'a dit : « Il est avantageux pour vous que je m'en aille, car si je ne m'en vais pas, le consolateur ne viendra pas vers vous ; mais, si je m'en vais, je vous l'enverrai » (Jean 16:7).

Le Saint-Esprit, c'est Dieu présent avec toi, en toi, maintenant.

Quand tu invoques Dieu pour la communion et qu'Il répond, c'est le Saint-Esprit qui se manifeste. Et Il ne vient pas les mains vides. Il vient avec trois missions précises.

1. Il t'enseigne.
« Le consolateur, l'Esprit Saint, que le Père enverra en mon nom, vous enseignera toutes choses » (Jean 14:26). Quand le Saint-Esprit vient en réponse à ton invocation, Il ouvre ton intelligence. Il te révèle les mystères. Il éclaire la Parole devant tes yeux. Il te donne la connaissance que tu n'avais pas. C'est un Enseignant vivant qui habite en toi.

2. Il te conduit.
« Quand le consolateur sera venu, l'Esprit de vérité, il vous conduira dans toute la vérité » (Jean 16:13). Le Saint-Esprit ne te laisse pas errer. Il te montre le chemin. Il te guide dans tes décisions. Il dirige tes pas jour après jour. C'est un Guide personnel qui marche avec toi.

3. Il te console.
C'est Son nom même : le Consolateur (en grec : Parakletos, littéralement « celui qui est appelé aux côtés »). Le Saint-Esprit vient te consoler dans tes peines, te fortifier dans tes faiblesses, te réconforter dans tes détresses. Il est le Compagnon présent dans toutes tes épreuves.


INVOQUER POUR RECEVOIR LE SAINT-ESPRIT

Tu peux invoquer :

- L'Ami : et c'est le Saint-Esprit qui vient pour ne plus te laisser seul dans le tumulte de tes pensées.
- Le Conseiller : et c'est le Saint-Esprit qui vient pour que tes décisions ne soient plus le fruit de ta chair ou de tes peurs, mais de Sa sagesse.
- Le Compagnon : et c'est le Saint-Esprit qui vient pour que ta vie ne soit plus une lutte solitaire, mais une marche côte à côte avec l'Éternel.
- L'Enseignant : et c'est le Saint-Esprit qui vient pour t'enseigner toutes choses et te conduire dans toute la vérité.


LA COMMUNION RÉELLE

C'est en ce sens que Dieu nous console, nous enseigne et nous conduit.

Ce n'est pas une consolation à distance. Ce n'est pas un enseignement théorique. Ce n'est pas une direction vague. C'est le Saint-Esprit présent, actif, parlant, guidant, consolant.

Quand tu invoques Dieu pour la communion, tu ne reçois pas juste une « bonne émotion spirituelle ». Tu reçois la Personne du Saint-Esprit qui vient habiter ta réalité, illuminer ton intelligence, diriger tes pas et consoler ton cœur.


LA CONNAISSANCE INTIME PRODUIT L'AUTORITÉ

C'est cette connaissance intime de Sa personne, cette expérience répétée du Saint-Esprit qui vient quand tu L'invoques, qui te permet d'invoquer avec une autorité et une assurance totales.

Ce n'est plus une invocation au hasard où tu espères, avec tremblement et doute, être peut-être entendu. C'est une certitude absolue basée sur le caractère immuable de Dieu.

Tu appelles Quelqu'un que tu connais. Tu sais que quand tu L'invoques, le Saint-Esprit vient. Tu l'as expérimenté. Ce n'est plus une théorie. C'est ta réalité vécue.

Et parce que tu Le connais intimement, tu sais avec une certitude inébranlable qu'au cri de ta voix, Il se lève.

Tu n'espères plus qu'Il réponde. Tu SAIS qu'Il répond.$edm$, $edm$- On peut invoquer Dieu sans être dans la détresse, simplement pour communier avec Lui : c'est la dimension la plus élevée de l'invocation.
- Notre Dieu n'est pas un distributeur de solutions : c'est un Dieu d'intimité.
- Dans la communion, c'est le Saint-Esprit qui vient : Dieu présent avec moi, en moi, maintenant.
- Il vient avec trois missions : m'enseigner, me conduire, me consoler.
- Je peux invoquer l'Ami, le Conseiller, le Compagnon ou l'Enseignant.
- Ce n'est pas une émotion spirituelle : c'est la Personne du Saint-Esprit qui vient.
- La connaissance intime de Dieu donne de l'autorité et de l'assurance : je ne m'attends plus qu'Il réponde, je sais qu'Il répond.$edm$, $edm$Cette semaine, invoque pour la communion, sans rien demander, simplement pour être avec Lui.

1. Mets-toi en position : pose, entre, dispose-toi (module 4).
2. Choisis une invocation parmi les trois ci-dessous.
3. Dis-la à voix haute, puis entre dans l'appel incessant.
4. Continue jusqu'à ce que le Saint-Esprit vienne, jusqu'à ce que Sa présence devienne réelle et tangible.
5. Note ce que tu as reçu : un enseignement, une direction, une consolation.


INVOCATION DU SAINT-ESPRIT POUR LA COMMUNION QUOTIDIENNE

« Saint-Esprit, Consolateur, Enseignant, Guide de ma vie, JE T'INVOQUE !
Ce jour que le Père a fait, je refuse de le vivre sans Toi.
JE T'INVOQUE ! Viens habiter en moi, marche avec moi.
Enseigne-moi, conduis-moi, console-moi.
JE T'INVOQUE jusqu'à ce que Ta présence devienne tangible. »

Puis :

« Saint-Esprit, JE T'APPELLE ! » (tu répètes)

Continue jusqu'à ce que le Saint-Esprit vienne, jusqu'à ce que Sa présence devienne réelle et tangible.


INVOCATION MATINALE POUR LA COMMUNION

« Ô mon Ami, mon Compagnon de vie, JE T'INVOQUE !
Ce jour que Tu as fait, je refuse de le vivre sans Toi.
Saint-Esprit, JE T'INVOQUE ! Manifeste Ta présence à mes côtés.
Marche avec moi aujourd'hui.
Parle-moi, conseille-moi, accompagne-moi, enseigne-moi.
JE T'INVOQUE jusqu'à ce que je sente que Tu es là. »

Puis :

« Jésus, mon Ami, JE T'APPELLE ! »
« Saint-Esprit, mon Compagnon, JE T'APPELLE ! » (tu répètes)

Continue jusqu'à ce que la présence du Saint-Esprit devienne tangible, jusqu'à ce que tu saches qu'Il marche avec toi.


INVOCATION POUR RECEVOIR L'ENSEIGNEMENT DU SAINT-ESPRIT

« Saint-Esprit, Enseignant divin, JE T'INVOQUE !
Toi que Jésus a envoyé pour m'enseigner toutes choses,
JE T'INVOQUE ! Viens ouvrir mon intelligence !
Révèle-moi les mystères, éclaire la Parole devant mes yeux.
JE T'INVOQUE jusqu'à ce que Tu m'enseignes ! »

Puis :

« Saint-Esprit, Enseignant, JE T'APPELLE ! » (tu répètes)

Continue jusqu'à ce que le Saint-Esprit vienne t'enseigner, jusqu'à ce que ton intelligence s'ouvre et que tu comprennes ce que tu ne comprenais pas.$edm$, $edm$✅ Acquis, je maîtrise bien : ...

⏳ En cours, je comprends mais je dois approfondir : ...

🔄 À travailler, je dois revenir dessus plus tard : ...

(Exemples de points à évaluer : invoquer sans être dans la détresse · le Saint-Esprit qui vient · ses trois missions · l'assurance qui vient de la connaissance de Dieu · mes invocations de la semaine.)


==================================================
CONCLUSION DE LA FORMATION
==================================================

L'invocation de Dieu n'est pas une technique religieuse. C'est la clé de la vie spirituelle réelle, celle qui transforme la théologie en expérience, la croyance en rencontre, l'espérance en certitude.

Apprends à invoquer. Connais Celui que tu appelles. Et ta vie ne sera plus jamais la même.$edm$, true, true),
('formation', 11, 3, 3, $edm$Savoir prier Dieu$edm$, $edm$La prière et ses fondements$edm$, $edm$À la fin de ce module, tu sauras :
- donner l'origine du mot « prière » et sa définition complète ;
- citer les principaux mots hébreux et grecs qui expriment la prière ;
- expliquer pourquoi l'invocation est la prière fondamentale et prioritaire ;
- expliquer comment prier la prière de demande, avec une foi qui vient des paroles de Christ.$edm$, $edm$QU'EST-CE QUE LA PRIÈRE ?

Commençons par l'étymologie du mot prière.

Le mot prière vient du latin precaria, qui signifie obtenu par la prière, par la demande. Il dérive du verbe latin precari, qui veut dire demander avec insistance, supplier, implorer. La racine latine prex, precis désigne une demande instante, une supplication adressée à une divinité ou à une autorité supérieure.

En hébreu biblique, plusieurs mots expriment la prière. Tefillah, qui vient de la racine palal, signifiant intercéder, juger, intervenir. C'est le mot général pour prière. Et tachanunim, qui signifie supplications, expression de la grâce recherchée.

En grec biblique, nous avons proseuché, qui signifie littéralement prière adressée à Dieu, avec l'idée de s'approcher de Dieu pour Lui parler. Et déesis, qui désigne une demande, une requête spécifique, une supplication pour un besoin particulier.

Voyons maintenant la signification profonde.

Étymologiquement, la prière porte en elle l'idée d'un mouvement vers Dieu. Un acte de se tourner vers Lui, de s'approcher de Lui avec des demandes, des supplications, mais aussi avec un cœur ouvert à Sa présence.

C'est une communication ascendante, de l'homme vers Dieu, et descendante, de Dieu vers l'homme, créant ainsi un pont spirituel, un dialogue vivant entre le créé et le Créateur.

La prière est donc, dans son essence étymologique, l'acte de tendre la main vers le divin, d'ouvrir son cœur à la présence de Dieu, et de créer un espace de rencontre où le ciel et la terre se touchent.

Voici la définition complète.

La prière est une communication multidimensionnelle avec Dieu. Elle engage l'esprit, l'âme et le corps. Elle transcende le temps et l'espace. Elle ouvre des portes dans le monde visible et invisible. C'est le langage de l'intimité avec Dieu, le souffle de l'âme, et le pouvoir qui fait descendre le ciel sur la terre.


LA PRIÈRE D'INVOCATION, ET LE FONDEMENT DE LA PRIÈRE DE DEMANDE

Commençons par la prière d'invocation.

L'invocation de Dieu est un type de prière fondamental et prioritaire. Toute prière doit commencer par l'invocation divine. Invoquez-moi au jour de la détresse ; je te délivrerai, et tu me glorifieras. Psaume 50 verset 15.

C'est inviter Dieu dans notre dimension, s'inviter chez Dieu. Cette prière ouvre l'accès aux autres dimensions spirituelles. Quiconque invoquera le nom du Seigneur sera sauvé. Romains 10 verset 13.

Sans inviter Dieu d'abord, nous ne pouvons bénéficier pleinement des autres aspects de la prière. C'est ce que l'Écriture appelle la violence pour posséder le royaume de Dieu. Depuis le temps de Jean-Baptiste jusqu'à présent, le royaume des cieux est forcé, et ce sont les violents qui s'en emparent. Matthieu 11 verset 12.

Pour ce qui concerne le comment, nous avons déjà développé cette option dans la rubrique savoir invoquer Dieu.

Venons-en maintenant à la prière de demande.

Ne vous inquiétez de rien ; mais en toute chose faites connaître vos besoins à Dieu par des prières et des supplications, avec des actions de grâces. Philippiens 4 verset 6.

Jésus Lui-même a enseigné : Demandez, et l'on vous donnera ; cherchez, et vous trouverez ; frappez, et l'on vous ouvrira. Car quiconque demande reçoit, celui qui cherche trouve, et l'on ouvre à celui qui frappe. Matthieu 7 versets 7 et 8.

Il est essentiel de prier pour demander, de présenter nos besoins spécifiques devant le Seigneur afin qu'Il nous les accorde. Vous ne possédez pas, parce que vous ne demandez pas. Jacques 4 verset 2. Cette dimension de la prière reconnaît notre dépendance de Dieu et Sa volonté de pourvoir à nos besoins. Et mon Dieu pourvoira à tous vos besoins selon sa richesse, avec gloire, en Jésus-Christ. Philippiens 4 verset 19.

Comment prier la prière de demande ? La prière doit se faire avec foi.

Comment pouvons-nous définir la foi selon la Bible ? La foi est certes une ferme assurance des choses qu'on espère, la démonstration de celles qu'on ne voit pas. Mais la foi en elle-même se définit par sa provenance. La foi est la foi en fonction d'où elle vient. Ainsi, elle vient de ce qu'on entend, et ce qu'on entend vient des paroles de Christ.

Si elle ne vient pas de Christ, ce n'est donc pas la foi dont parle Hébreux. Car dans les paroles de Christ il y a la volonté de Dieu, les recommandations, les révélations, le royaume de Dieu, les promesses et notre devenir selon Christ.

Cette demande est mûrie par une foi éduquée par les paroles de Christ. C'est pourquoi Jésus dit : Si vous demeurez dans ma parole, vous êtes vraiment mes disciples ; vous connaîtrez la vérité, et la vérité vous affranchira. Jean 8 versets 31 et 32. Une demande qui produit un exaucement est une libération totale d'un autre état de vie.

Il ne faut pas demander pour demander, mais plutôt demander selon une foi éduquée aux valeurs du royaume. Sinon il n'y aura aucunement un exaucement, et le sujet sur lequel quelqu'un pourrait s'attarder risquerait de ne jamais arriver à aboutissement.$edm$, $edm$- Le mot « prière » vient du latin precaria : obtenu par la prière, par la demande.
- En hébreu : tefillah (mot général) et tachanunim (supplications). En grec : proseuché (s'approcher de Dieu pour Lui parler) et déesis (requête spécifique).
- La prière est un mouvement vers Dieu et une communication dans les deux sens, ascendante et descendante.
- La prière est une communication multidimensionnelle avec Dieu : esprit, âme et corps.
- L'invocation est un type de prière fondamental et prioritaire : toute prière doit commencer par elle.
- Sans inviter Dieu d'abord, on ne bénéficie pas pleinement des autres aspects de la prière.
- La prière de demande présente nos besoins spécifiques à Dieu, et elle se fait avec foi.
- La foi se définit par sa provenance : elle vient de ce qu'on entend, et ce qu'on entend vient des paroles de Christ.
- Il ne faut pas demander pour demander, mais selon une foi éduquée aux valeurs du royaume.$edm$, $edm$Cette semaine, tu passes de la définition à la pratique.

1. Écris ta propre phrase. En une phrase, avec tes mots : « Pour moi, prier, c'est... »

2. Commence par l'invocation. Avant de présenter une demande, invoque Dieu en reprenant ce que tu as appris dans la semaine « Savoir invoquer Dieu ».

3. Écris une demande précise. Choisis un besoin spécifique et formule-le en quelques mots.

4. Examine ta foi. Pose-toi la question : cette demande s'appuie-t-elle sur une parole de Christ (une promesse, une volonté de Dieu, une recommandation) ? Note la parole sur laquelle tu t'appuies.

5. Présente ta demande à Dieu avec foi. Puis note ce que tu remarques, dans les deux sens : ce que tu as dit à Dieu, et ce que tu as perçu de Lui.$edm$, $edm$✅ Acquis, je maîtrise bien : ...

⏳ En cours, je comprends mais je dois approfondir : ...

🔄 À travailler, je dois revenir dessus plus tard : ...

(Exemples de points à évaluer : l'origine et la définition de la prière · l'invocation comme prière fondamentale · la prière de demande · la foi qui vient des paroles de Christ · ma première demande.)$edm$, false, true),
('formation', 12, 3, 3, $edm$Savoir prier Dieu$edm$, $edm$Demander et recevoir$edm$, $edm$À la fin de ce module, tu sauras :
- demander et recevoir avec foi, sans douter ;
- comprendre la prière d'accord et la pratiquer avec d'autres croyants ;
- comprendre la condition de la demeure en Christ et de ses paroles en nous ;
- discerner les paroles que Dieu a laissées pour ta vie.$edm$, $edm$DEMANDER ET RECEVOIR AVEC FOI, ET PAR ACCORD

Voyons d'abord comment demander et recevoir avec foi.

La foi sans doute est la clé de l'exaucement. Mais qu'il la demande avec foi, sans douter ; car celui qui doute est semblable au flot de la mer, agité par le vent et poussé de côté et d'autre. Jacques 1 verset 6.

Jésus nous enseigne que nous devons croire que nous avons déjà reçu au moment même où nous prions. C'est pourquoi je vous dis : Tout ce que vous demanderez en priant, croyez que vous l'avez reçu, et vous le verrez s'accomplir. Marc 11 verset 24.

La foi authentique ne demande pas en espérant peut-être recevoir, mais en sachant avec certitude que Dieu a déjà accordé la demande dans le monde spirituel. Or la foi est une ferme assurance des choses qu'on espère, une démonstration de celles qu'on ne voit pas. Hébreux 11 verset 1.

Cette foi s'appuie sur la fidélité de Dieu et sur Ses promesses. Dieu n'est point un homme pour mentir, ni fils d'un homme pour se repentir. Ce qu'il a dit, ne le fera-t-il pas ? Ce qu'il a déclaré, ne l'exécutera-t-il pas ? Nombres 23 verset 19.

Voyons maintenant comment demander et recevoir par accord.

Jésus a révélé une puissance extraordinaire dans l'accord spirituel entre deux ou plusieurs croyants. Je vous dis encore que, si deux d'entre vous s'accordent sur la terre pour demander une chose quelconque, elle leur sera accordée par mon Père qui est dans les cieux. Matthieu 18 verset 19.

Le mot s'accorder vient du grec symphoneo, qui signifie être en harmonie, en symphonie. C'est plus qu'être d'accord intellectuellement. C'est avoir la même foi, la même vision, le même esprit concernant la requête.

Voici ce qui rend cette prière particulière : elle ne repose pas d'abord sur la foi individuelle, mais sur des pensées et des aspirations communes. Ailleurs, l'exaucement dépend de la foi de celui qui demande. Ici, ce qui est requis, c'est que deux personnes veuillent réellement la même chose devant Dieu, avec le même cœur et la même attente. C'est l'unité qui porte la prière, non la mesure de foi de chacun.

C'est pourquoi cette prière doit se développer partout où des vies se rencontrent. Dans la famille, entre époux, entre parents et enfants. Dans l'amitié, entre ceux qui portent le même fardeau. Et en milieu professionnel, entre croyants qui veulent la même chose pour leur travail et leur environnement.

Lorsque deux personnes s'accordent dans la prière, elles créent une force spirituelle multipliée. Cinq d'entre vous en poursuivront cent, et cent d'entre vous en poursuivront dix mille. Lévitique 26 verset 8. Le principe de l'accord multiplie l'efficacité spirituelle de manière exponentielle.

La présence de Christ est garantie dans cet accord. Car là où deux ou trois sont assemblés en mon nom, je suis au milieu d'eux. Matthieu 18 verset 20. C'est cette présence divine qui transforme l'accord humain en décret céleste.


DEMANDER ET RECEVOIR PAR LA DEMEURE EN CHRIST ET SES PAROLES EN NOUS

Jésus a donné une promesse extraordinaire, mais elle est conditionnée. Si vous demeurez en moi, et que mes paroles demeurent en vous, demandez ce que vous voudrez, et cela vous sera accordé. Jean 15 verset 7.

Remarque bien l'ordre. La première condition n'est pas la parole, c'est la demeure. Si vous demeurez en moi, d'abord. Et ensuite seulement : et que mes paroles demeurent en vous. On ne reçoit pas les paroles de Christ à distance. On les reçoit en demeurant.

Mais de quelles paroles s'agit-il ? Voici le point que beaucoup manquent, et qui explique tant de prières restées sans réponse.

La Bible dit que la foi vient de ce que l'on entend, et que ce que l'on entend vient de la parole de Christ. Or Christ ne parle pas seulement dans les pages de l'Écriture. Il a laissé des paroles générales pour tous, mais il y a aussi des paroles qui te sont adressées, à toi. Ce sont celles-là qui, lorsqu'elles demeurent en toi, produisent l'exaucement.

Ce ne sont donc pas obligatoirement des paroles bibliques, bien que la Bible en fasse partie. Car Dieu est un Dieu d'alliance, et dans toute alliance il y a des paroles. Et dans ces paroles se trouve Sa volonté.

Ces paroles personnelles peuvent se vérifier par la Bible : elles vont toujours dans le sens de la Parole de Dieu.

C'est pourquoi on ne peut pas être exaucé sur n'importe quelle parole simplement parce qu'elle est écrite. Dieu cautionne ce qu'Il t'a donné. Tu peux prononcer des versets à longueur de journée. Cela peut être permis, mais pas nécessairement parfait selon Dieu pour ta vie.

D'où la nécessité absolue de discerner.

Ne vous conformez pas au siècle présent, mais soyez transformés par le renouvellement de l'intelligence, afin que vous discerniez quelle est la volonté de Dieu, ce qui est bon, agréable et parfait. Romains 12 verset 2.

Il faut discerner. Si tu ne connais pas les paroles que Dieu a laissées pour ta vie, tes prières seront vaines. Tu prieras beaucoup et tu n'obtiendras rien. Non parce que Dieu est sourd, mais parce que tu réclames sur une parole qui ne t'a pas été donnée.

Voyons ce que produit une parole qui demeure.

Dieu dit à Abraham : je ferai de toi le père d'une multitude. Cette parole demeure en lui. Et c'est précisément pourquoi, le jour où Dieu lui demande son fils, Abraham n'a pas peur. Il raisonne selon la parole reçue : Celui qui m'a promis une multitude ne peut pas se contredire. S'Il me demande Isaac, je le donne, car la promesse tient. La parole demeurée en lui a produit une obéissance que la logique humaine n'aurait jamais permise.

Dieu dit à Josué : nul ne tiendra devant toi. Alors quand Josué se tient devant les murailles de Jéricho, il sait une chose : cette muraille ne peut pas tenir. Elle est déjà tombée dans la parole avant de tomber dans la pierre.

Dieu donne toutes sortes de paroles.

Il donne des paroles de devenir, des paroles de transformation, des paroles d'avenir. Il donne des promesses, des recommandations, des exigences, des instructions. Il révèle à Ses enfants ce qui est caché, ce dont ils n'ont aucune connaissance. Quand on L'invoque, Il révèle.

Et si ces paroles ne demeurent pas en nous, si nous les recevons sans les garder, si nous les entendons sans les faire habiter, nous ne sommes pas réellement des disciples exaucés dans leur destinée.

Que la parole de Christ habite parmi vous abondamment. Colossiens 3 verset 16. Lorsqu'elle habite ainsi, elle devient notre système de pensée, notre conviction profonde, notre réalité spirituelle. Nos pensées deviennent Ses pensées, nos désirs deviennent Ses désirs, nos prières deviennent l'expression de Sa volonté. Or nous, nous avons la pensée de Christ. 1 Corinthiens 2 verset 16.

C'est alors que la demande cesse d'être une supplication et devient une réclamation. On ne demande plus selon sa volonté charnelle, mais selon Sa volonté déjà révélée.$edm$, $edm$- La foi est la clé de l'exaucement : on demande avec foi, sans douter.
- Jésus enseigne de croire qu'on a déjà reçu au moment même où l'on prie.
- La foi authentique sait avec certitude que Dieu a déjà accordé la demande dans le monde spirituel, car elle s'appuie sur la fidélité de Dieu et sur Ses promesses.
- S'accorder vient du grec symphoneo : être en harmonie, en symphonie. C'est avoir la même foi, la même vision, le même esprit.
- La prière d'accord repose sur l'unité, non sur la mesure de foi de chacun. Elle se développe dans la famille, l'amitié et le milieu professionnel.
- La présence de Christ est garantie dans l'accord : là où deux ou trois sont assemblés en son nom.
- Première condition de Jean 15:7 : la demeure en Christ. Ensuite seulement, ses paroles demeurent en nous.
- Il y a des paroles générales pour tous, et des paroles adressées à chacun. Elles se vérifient par la Bible.
- Il faut discerner les paroles que Dieu a laissées pour sa vie, sinon on réclame sur une parole qui n'a pas été donnée.
- Quand la parole demeure, la demande cesse d'être une supplication et devient une réclamation.$edm$, $edm$1. DEMANDER AVEC FOI : LA PRIÈRE POUR LA GUÉRISON

Voici la pratique. Lorsque tu pries pour la guérison, ne demande pas en doutant si Dieu peut guérir. Au lieu de cela, prie ainsi :

Père, je viens à Toi au nom de Jésus. Ta Parole déclare que par les meurtrissures de Jésus, je suis guéri. Je ne prie pas pour être guéri, car je crois que je suis déjà guéri par le sacrifice de Christ. Je reçois maintenant ma guérison par la foi. Mon corps se conforme à cette vérité spirituelle. Je Te remercie Père, car c'est déjà fait. Au nom de Jésus, amen.

Puis, même si les symptômes persistent, continue à remercier Dieu comme si c'était déjà accompli. Ne parle plus de ta maladie, mais de ta guérison. Déclare : je suis guéri. Cette confession de foi activera la manifestation physique de ce qui est déjà une réalité spirituelle.


2. DEMANDER PAR ACCORD

Voici la pratique. Un couple traverse une difficulté : l'attente d'un enfant, un projet qui n'avance pas. Ils cessent de prier chacun de son côté avec ses propres mots. Ils s'assoient ensemble et nomment la même chose devant Dieu :

Père céleste, au nom de Jésus, nous sommes ici tous les deux, unis devant Toi. Nous nous accordons pour cette chose. Nous ne demandons pas séparément, nous demandons d'une seule voix. Tu as dit que si deux s'accordent sur la terre, cela leur sera accordé par Toi qui es dans les cieux. Nous déclarons ensemble que c'est fait, au nom de Jésus. Amen.

Puis ils tiennent l'accord dans la durée. L'un ne peut pas déclarer la promesse dans la prière et se plaindre le reste de la journée. Ce serait rompre la symphonie. Ils confessent la même chose devant Dieu et entre eux. Et quand l'un faiblit, l'autre le relève.

L'Esprit confirme alors l'accord. Il donne aux deux la même conviction, la même paix sur le sujet, souvent au même moment, sans qu'ils se soient concertés.

Le même principe s'applique entre amis portant un même fardeau, et entre collègues croyants qui veulent la même chose pour leur environnement de travail.


3. DEMANDER PAR LA DEMEURE EN CHRIST ET SES PAROLES EN NOUS

Voici la pratique.

D'abord, demeure. La demeure en Christ n'est pas une visite occasionnelle, c'est un état permanent de communion, d'intimité et de dépendance. Celui qui demeure en moi et en qui je demeure porte beaucoup de fruit, car sans moi vous ne pouvez rien faire. Jean 15 verset 5.

Ensuite, cherche à connaître les paroles que Dieu a laissées pour ta vie. Invoque-Le, consulte-Le, laisse l'Esprit te révéler ce qu'Il a dit sur toi, ton devenir, ta destinée, Ses exigences, Ses instructions. Note-les. Elles sont ton alliance.

Puis fais-les demeurer. Prends la parole reçue et médite-la jusqu'à ce qu'elle cesse d'être une information pour devenir ta nature. Répète-la, déclare-la, laisse-la déloger toute pensée contraire.

Alors, quand vient le besoin, prie sur cette base :

Père, au nom de Jésus, je demeure en Toi et Ta parole demeure en moi. Tu m'as dit ceci sur ma vie. Je ne demande pas selon mon anxiété ni selon ce que je vois. Je demande selon ce que Tu as dit sur ma vie. Ta parole ne peut mentir, et ce que Tu as déclaré, Tu l'exécutes. Je reçois maintenant l'accomplissement, au nom de Jésus. Amen.

Et tiens-toi comme Abraham devant l'autel, comme Josué devant Jéricho : ce qui te fait face ne peut pas tenir contre la parole que Dieu t'a donnée.$edm$, $edm$✅ Acquis, je maîtrise bien : ...

⏳ En cours, je comprends mais je dois approfondir : ...

🔄 À travailler, je dois revenir dessus plus tard : ...

(Exemples de points à évaluer : demander avec foi · la prière d'accord · la demeure en Christ · discerner les paroles que Dieu m'a laissées · tenir l'accord dans la durée.)$edm$, false, true),
('formation', 13, 3, 3, $edm$Savoir prier Dieu$edm$, $edm$Chercher Dieu et lui parler$edm$, $edm$À la fin de ce module, tu sauras :
- chercher la face de Dieu Lui-même, sans rien demander ;
- parler à Dieu comme à un ami proche, en attendant une réponse ;
- consulter Dieu avant de prendre une décision importante ;
- reconnaître comment Dieu répond.$edm$, $edm$LA PRIÈRE POUR CHERCHER DIEU

Commençons par la prière pour chercher Dieu.

Différente de l'invocation, cette prière vise à chercher la face de Dieu Lui-même. Quand tu dis : Cherchez ma face ! Mon cœur dit à ton égard : Je cherche ta face, ô Éternel ! Psaume 27 verset 8.

Elle réside dans l'expression profonde du cœur, car Dieu se laisse trouver par ceux qui Le cherchent avec sincérité. Vous me chercherez, et vous me trouverez, si vous me cherchez de tout votre cœur. Jérémie 29 verset 13.

Notre cœur est souvent accaparé par le temps, l'argent, notre avenir, nos inquiétudes et nos combats. Là où est ton trésor, là aussi sera ton cœur. Matthieu 6 verset 21.

Mais parvenir à donner toute la place à Dieu permet à Dieu de se laisser véritablement trouver. Approchez-vous de Dieu, et il s'approchera de vous. Jacques 4 verset 8.

L'invocation invite des portions ou des dimensions de Dieu, mais Dieu qui se laisse trouver, c'est Dieu Lui-même dans Sa splendeur. Ce n'est pas une question de délivrance ou de réaliser quelque chose de spécifique, mais de vivre la réalité de l'amour de Dieu de manière si profonde qu'on comprend, comme Paul : Christ est ma vie, et la mort m'est un gain. Philippiens 1 verset 21.

C'est l'expérience de Paul ravi au troisième ciel. Je connais un homme en Christ, qui fut, il y a quatorze ans, ravi jusqu'au troisième ciel. 2 Corinthiens 12 verset 2. Ou de Moïse qui a vu la gloire de Dieu. Tu verras mon dos, mais ma face ne pourra pas être vue. Exode 33 verset 23.

Comment chercher Dieu ?

Le chercher nécessite de se mettre à l'écart de toutes pensées qui pourraient remplir nos cœurs, et d'effacer la ruse ou la malice qui animent le cœur. Pour ce faire, il faut être intéressé par Dieu Lui-même. Abandonner toute demande. Apprendre à simplement chérir Sa présence sans fin et Lui donner son temps.

Chercher Dieu n'est pas un exercice religieux, c'est une quête d'amour. C'est le cœur qui crie : Je veux Te connaître, pas seulement connaître de Toi. Je veux Te voir, pas seulement voir ce que Tu fais.


LA PRIÈRE POUR PARLER À DIEU

Venons-en maintenant à la prière pour parler à Dieu.

Dieu est un Père et un Conseiller. Car un enfant nous est né, un fils nous est donné, et la domination reposera sur son épaule ; on l'appellera Admirable, Conseiller, Dieu puissant, Père éternel, Prince de la paix. Ésaïe 9 verset 5.

Il est important de s'adresser à Lui avec l'espérance d'une réponse, comme l'a fait le prophète Habakuk : Je me tiendrai à mon poste, je me placerai sur la tour, et je veillerai pour voir ce que l'Éternel me dira. Habakuk 2 verset 1.

Cette prière est une communication vivante où nous vivons Ses consolations, recevons Ses enseignements sur toute chose, et communions avec Lui. Ce que nous avons vu et entendu, nous vous l'annonçons, à vous aussi, afin que vous aussi vous soyez en communion avec nous. Or, notre communion est avec le Père et avec son Fils Jésus-Christ. 1 Jean 1 verset 3.

C'est un dialogue, un échange intime avec notre Créateur. L'Éternel parlait avec Moïse face à face, comme un homme parle à son ami. Exode 33 verset 11.

Comment parler à Dieu ?

Parle à Dieu comme à un ami proche. Partage tes joies, tes peines, tes questions. Tout va de l'amour qu'on porte à Son égard, ou du moins de la folie qui nous anime à Son sujet.

Cela semblera fou de parler à quelqu'un que tu n'entends pas. Et pourtant Dieu parle. C'est pourquoi pour Lui parler, il faut développer une sensibilité à l'Esprit afin de rester connecté à chaque fois, car Il est un Ami plus proche que notre peau.

Parler à Dieu nécessite d'être attentif.


PARLER À DIEU EN LE CONSULTANT

Consulter Dieu, c'est aussi parler à Dieu. Car c'est une prière où Dieu parle pour confirmer selon l'information demandée ou les possibilités exposées.

Tout au long de l'Écriture, nous voyons des hommes de Dieu consulter l'Éternel avant de prendre des décisions importantes. David, en particulier, consultait constamment l'Éternel.

David consulta l'Éternel, en disant : Monterai-je contre les Philistins ? Les livreras-tu entre mes mains ? Et l'Éternel dit à David : Monte, car je livrerai les Philistins entre tes mains. 2 Samuel 5 verset 19.

Puis, face au même ennemi, il consulte de nouveau. David consulta l'Éternel. Et l'Éternel dit : Ne monte pas ; tourne-les par derrière, et tu arriveras sur eux vis-à-vis des mûriers. 2 Samuel 5 verset 23.

Regarde bien. Même adversaire, stratégie différente. David ne présumait jamais de la stratégie divine, même face au même ennemi rencontré à plusieurs reprises. Ce que Dieu a dit hier ne dispense pas de Le consulter aujourd'hui.

Josué aussi a appris l'importance de consulter Dieu. Lorsqu'il a négligé de le faire avec les Gabaonites, il a été trompé. Ils prirent de leurs provisions, et ne consultèrent point l'Éternel. Josué 9 verset 14. Cette négligence a conduit Josué à faire alliance avec des ennemis déguisés, une erreur aux conséquences durables pour Israël.

Voyons le bien-fondé de la consultation.

La consultation divine n'est pas une option pour le croyant qui désire marcher dans la volonté parfaite de Dieu. Contrairement à David qui ne bougeait jamais sans consulter l'Éternel, Josué a agi sur ses propres conclusions et en a payé le prix.

Consulter Dieu, c'est reconnaître que notre discernement naturel est insuffisant, et que Dieu seul connaît la fin dès le commencement. Confie-toi en l'Éternel de tout ton cœur, et ne t'appuie pas sur ta sagesse ; reconnais-le dans toutes tes voies, et il aplanira tes sentiers. Proverbes 3 versets 5 et 6.

Dieu désire nous guider dans toutes nos décisions. Si quelqu'un d'entre vous manque de sagesse, qu'il la demande à Dieu, qui donne à tous simplement et sans reproche, et elle lui sera donnée. Jacques 1 verset 5.

Le Seigneur promet : Je t'instruirai et te montrerai la voie que tu dois suivre ; je te conseillerai, j'aurai le regard sur toi. Psaume 32 verset 8.

Sa promesse est claire : Tes oreilles entendront derrière toi une voix qui dira : Voici le chemin, marchez-y ! Car vous iriez à droite, ou vous iriez à gauche. Ésaïe 30 verset 21.$edm$, $edm$- La prière pour chercher Dieu vise la face de Dieu Lui-même, différente de l'invocation qui invite des portions ou des dimensions de Dieu.
- Dieu se laisse trouver par ceux qui le cherchent avec sincérité, de tout leur cœur.
- Chercher Dieu nécessite de se mettre à l'écart, d'abandonner toute demande, et de chérir Sa présence.
- Chercher Dieu n'est pas un exercice religieux, c'est une quête d'amour : connaître Dieu, pas seulement connaître de Lui.
- La prière pour parler à Dieu est un dialogue : on s'adresse à Lui avec l'espérance d'une réponse.
- On parle à Dieu comme à un ami proche, en développant une sensibilité à l'Esprit et en étant attentif.
- Consulter Dieu, c'est une prière où Dieu parle pour confirmer selon l'information demandée ou les possibilités exposées.
- David consultait toujours : même adversaire, stratégie différente. Ce que Dieu a dit hier ne dispense pas de Le consulter aujourd'hui.
- Josué a été trompé pour avoir négligé de consulter l'Éternel.
- Consulter Dieu, c'est reconnaître que notre discernement naturel est insuffisant.$edm$, $edm$1. CHERCHER DIEU

Voici la pratique. Retire-toi dans un lieu silencieux où tu ne seras pas dérangé. Éteins ton téléphone. Ferme la porte. Mets de côté toutes tes préoccupations, tes problèmes, tes besoins.

Entre dans ce temps en disant simplement : Seigneur, au nom de Jésus, je viens juste pour Toi. Je ne veux rien d'autre que Ta présence. Tu es suffisant pour moi.

Ferme les yeux. Ne demande rien. Ne supplie pas pour une délivrance. N'intercède pas pour quelqu'un. Reste simplement là, en silence, devant Lui.

Au début, ton esprit sera agité, plein de pensées. Laisse-les passer comme des nuages. Recentre-toi doucement sur Dieu. Dis simplement : Je T'aime, Seigneur. Je Te désire, Toi seul.

Parfois, adore-Le en murmurant : Tu es saint. Tu es magnifique. Tu es tout pour moi. Laisse ton cœur s'attacher à Lui sans agenda, sans liste de prières, sans programme.

Reste ainsi trente minutes, une heure, ou plus si possible.

Dans ces moments, Dieu peut se révéler à toi d'une manière nouvelle. Tu peux expérimenter Sa paix qui surpasse toute intelligence, Sa joie inexprimable, Sa présence tangible. Parfois Il ne se manifeste pas de manière spectaculaire, mais tu développes une intimité profonde avec Lui qui transformera toute ta vie spirituelle.

Fais cela régulièrement, quotidiennement si possible. David disait : Une chose que je demande à l'Éternel, que je recherche : c'est d'habiter dans la maison de l'Éternel tous les jours de ma vie, pour contempler la magnificence de l'Éternel et pour méditer dans son temple. Psaume 27 verset 4.


2. PARLER À DIEU

Voici la pratique. Prends un moment chaque jour pour un dialogue intime avec Dieu, comme tu le ferais avec ton meilleur ami.

Par exemple, le matin en te réveillant, avant de toucher ton téléphone, dis : Bonjour Père, au nom de Jésus. Comment vas-Tu aujourd'hui ? Moi, je me sens de telle manière. J'ai cette journée devant moi avec telles activités. Qu'en penses-Tu ?

Puis reste silencieux quelques instants. Écoute. Dieu peut répondre par une impression dans ton cœur. Par une pensée soudaine qui n'est pas la tienne. Par un verset biblique qui te vient à l'esprit. Par un sentiment de paix ou d'alerte. Par une image mentale. Ou par une petite voix douce dans ton esprit.

Continue la conversation : Père, hier j'ai vécu ceci. J'ai ressenti cela. Toi, qu'aurais-Tu fait à ma place ?

Attends Sa réponse. Sois patient. L'oreille spirituelle se développe avec la pratique.

Partage tes doutes sans crainte : Seigneur, je ne comprends pas pourquoi telle chose est arrivée. Aide-moi à comprendre Ta perspective.

Partage tes joies : Père, aujourd'hui j'ai reçu cette bénédiction. Merci. Tu es tellement bon.

Note dans un journal ce que tu perçois de Dieu. Avec le temps, tu reconnaîtras de mieux en mieux Sa voix, distincte de ta propre pensée ou de la voix de l'ennemi.

Mes brebis entendent ma voix ; je les connais, et elles me suivent. Jean 10 verset 27. Si tu es Son enfant, tu peux entendre Sa voix.


3. CONSULTER DIEU

Voici la pratique. Supposons que tu doives prendre une décision importante : changer d'emploi ou rester dans ton poste actuel.

Entre en prière ainsi :

Père céleste, au nom de Jésus, je viens Te consulter concernant cette opportunité. Voici la situation. Je T'expose les deux options. Option A : accepter le nouveau poste, déménager, saisir cette opportunité. Option B : rester où je suis, continuer à construire ici. Seigneur, quelle est Ta volonté ? Quel chemin veux-Tu que je prenne ? Je ne veux pas choisir selon ma sagesse humaine, mais selon Ta sagesse divine. Parle-moi, Père. Je T'écoute. Au nom de Jésus, amen.

Puis attends. Ne demande pas Seigneur, bénis mon choix. Pose la question précise, comme David, et tais-toi.

L'Esprit répond. Il imprime une pensée qui n'est pas la tienne et qui revient. Il donne une conviction qui ne repart pas. Il ouvre un passage de la Parole qui parle exactement à ta situation. Il fait voir. Ou Il fait ressentir Sa présence qui confirme.

Dieu peut aussi répondre par la paix intérieure. Que la paix de Christ, à laquelle vous avez été appelés pour former un seul corps, règne dans vos cœurs. Colossiens 3 verset 15. Tu ressens une paix profonde concernant une option, et une agitation concernant l'autre.

Il peut répondre par des circonstances, en ouvrant ou en fermant des portes de manière évidente. Ou par le conseil de frères matures. Les projets réussissent avec un grand nombre de conseillers. Proverbes 15 verset 22.

Ne te précipite pas. Si tu n'as pas de clarté, attends. Jeûne et prie. Dieu parlera au temps convenable. Celui qui croit ne se hâtera point. Ésaïe 28 verset 16.$edm$, $edm$✅ Acquis, je maîtrise bien : ...

⏳ En cours, je comprends mais je dois approfondir : ...

🔄 À travailler, je dois revenir dessus plus tard : ...

(Exemples de points à évaluer : chercher Dieu sans rien demander · parler à Dieu comme à un ami · consulter Dieu avant une décision · reconnaître sa réponse · tenir un journal de ce que je perçois de Dieu.)$edm$, false, true),
('formation', 14, 3, 3, $edm$Savoir prier Dieu$edm$, $edm$Se bâtir par l'Esprit$edm$, $edm$À la fin de ce module, tu sauras :
- expliquer pourquoi on prie pour se bâtir, et en quoi cela diffère de prier pour une situation ;
- distinguer les trois types de prière par l'Esprit : en langues, par sensibilité à l'Esprit, par soupir ;
- appliquer chacun de ces trois types dans ta vie de prière.$edm$, $edm$LA PRIÈRE POUR SE BÂTIR, PAR L'ESPRIT

Il faut prier pour se bâtir, se fortifier, se renforcer spirituellement jusqu'à en vivre les effets physiquement. Pour vous, bien-aimés, vous édifiant vous-mêmes sur votre très sainte foi, et priant par le Saint-Esprit. Jude verset 20.

Se recueillir dans la présence de Dieu nous rend forts, productifs et joyeux. La joie de l'Éternel sera votre force. Néhémie 8 verset 10. On devient solide comme des rochers.

Nous donnons place au Saint-Esprit afin qu'Il siège en nous avec vie et puissance. Que le Dieu de l'espérance vous remplisse de toute joie et de toute paix dans la foi, pour que vous abondiez en espérance, par la puissance du Saint-Esprit. Romains 15 verset 13.

Ainsi, nous développons force, puissance et sensibilité à l'Esprit. Fortifiez-vous dans le Seigneur, et par sa force toute-puissante. Éphésiens 6 verset 10.

Comment prier pour se bâtir ?

Cela consiste à prier par l'Esprit et par la Parole. C'est une prière où la place est laissée au Saint-Esprit pour prier par soupirs inexprimables, et où nous nous rattachons la Parole de Dieu pour que ce que nous lisons devienne une réalité pour nous.

Donner la place à l'Esprit dans notre cœur, c'est accepter de devenir puissant et bâti selon Dieu et à Son image. Se rattacher la Parole, c'est faire en sorte que les promesses, les manifestations de Dieu et Ses actions passées se lient à notre nature et nous arrivent personnellement.

Voici le principe fondamental. On ne se rattache pas prioritairement la Parole de Dieu par situation, mais d'abord par la vie. La vie se bâtit, car elle est permanente. La situation se règle, car elle est temporaire.

Prier pour se bâtir vise d'abord à construire notre être spirituel, notre identité en Christ, notre nature transformée. C'est cette vie solidement bâtie qui nous permettra ensuite de faire face aux situations passagères. Nous ne prions pas d'abord pour résoudre des problèmes, mais pour devenir des personnes établies dans la Parole et dans l'Esprit.

Voyons maintenant les types de prière par l'Esprit.


PREMIÈREMENT, LA PRIÈRE EN LANGUES

Le parler en langues est un don du Saint-Esprit donné pour l'édification personnelle du croyant. Celui qui parle en langue s'édifie lui-même ; celui qui prophétise édifie l'Église. 1 Corinthiens 14 verset 4.

Lorsque nous prions en langues, c'est notre esprit qui prie, dirigé par le Saint-Esprit, contournant notre intelligence limitée. Car si je prie en langue, mon esprit est en prière, mais mon intelligence demeure stérile. 1 Corinthiens 14 verset 14.

Le jour de la Pentecôte, les disciples ont reçu ce don. Ils furent tous remplis du Saint-Esprit, et se mirent à parler en d'autres langues, selon que l'Esprit leur donnait de s'exprimer. Actes 2 verset 4.

L'apôtre Paul pratiquait abondamment cette forme de prière. Je rends grâces à Dieu de ce que je parle en langue plus que vous tous. 1 Corinthiens 14 verset 18.

Prier en langues permet à l'Esprit d'intercéder au-delà de notre compréhension, touchant des réalités spirituelles que nous ne connaissons pas, brisant des forteresses que nous ne voyons pas, et nous édifiant dans les profondeurs de notre être spirituel.


DEUXIÈMEMENT, LA PRIÈRE PAR SENSIBILITÉ À L'ESPRIT

L'Esprit Saint habite en nous et nous aide dans nos faiblesses, notamment dans la prière. De même aussi l'Esprit nous aide dans notre faiblesse, car nous ne savons pas ce qu'il nous convient de demander dans nos prières. Mais l'Esprit lui-même intercède par des soupirs inexprimables. Romains 8 verset 26.

Cette prière n'est pas intellectuelle ou planifiée, mais spontanée et dirigée par l'Esprit. Il s'agit d'être sensible aux mouvements de l'Esprit en nous et d'y obéir.

Priez en tout temps par l'Esprit, avec toutes sortes de prières et de supplications. Éphésiens 6 verset 18. Cela signifie laisser l'Esprit initier, diriger et terminer nos prières selon Sa connaissance parfaite de la volonté du Père.

L'Esprit connaît les pensées de Dieu et connaît aussi nos besoins profonds. Et celui qui sonde les cœurs connaît quelle est la pensée de l'Esprit, parce que c'est selon Dieu qu'il intercède en faveur des saints. Romains 8 verset 27.

Développer cette sensibilité nous permet de prier avec précision et efficacité, même pour des situations dont nous ignorons les détails.


TROISIÈMEMENT, LA PRIÈRE PAR SOUPIR

Il y a des moments où la charge spirituelle est si lourde, la douleur si profonde, ou la situation si complexe que les mots humains ne suffisent plus. C'est là qu'intervient la prière par soupirs.

De même aussi l'Esprit nous aide dans notre faiblesse, car nous ne savons pas ce qu'il nous convient de demander dans nos prières. Mais l'Esprit lui-même intercède par des soupirs inexprimables. Romains 8 verset 26.

Le mot grec pour soupirs inexprimables est stenagmos alaletos. Des gémissements qui ne peuvent être articulés en mots humains. C'est une intercession qui vient des profondeurs de l'esprit, au-delà du langage.

Jésus Lui-même a pratiqué cette forme de prière. Devant le tombeau de Lazare : Jésus, frémissant de nouveau en lui-même, se rendit au sépulcre. Jean 11 verset 38. Le mot frémir indique un gémissement profond, une agitation intérieure intense.

Ces soupirs sont l'expression de l'Esprit qui combat dans les profondeurs, qui travaille des percées, qui enfante des délivrances dans le monde spirituel. Cette prière par soupirs édifie profondément celui qui la pratique, le fortifiant spirituellement de l'intérieur.$edm$, $edm$- Il faut prier pour se bâtir, se fortifier, se renforcer spirituellement.
- Prier pour se bâtir, c'est prier par l'Esprit et par la Parole.
- Principe fondamental : on se rattache la Parole d'abord par la vie, non par situation. La vie se bâtit, car elle est permanente. La situation se règle, car elle est temporaire.
- On ne prie pas d'abord pour résoudre des problèmes, mais pour devenir une personne établie dans la Parole et dans l'Esprit.
- La prière en langues : un don du Saint-Esprit pour l'édification personnelle. C'est l'esprit qui prie, contournant notre intelligence limitée.
- La prière par sensibilité à l'Esprit : spontanée et dirigée par l'Esprit. Elle permet de prier avec précision, même pour des situations dont on ignore les détails.
- La prière par soupir : des gémissements qui ne peuvent être articulés en mots humains (stenagmos alaletos). Jésus l'a pratiquée devant le tombeau de Lazare.
- Ces trois types fortifient celui qui les pratique, et brisent des forteresses dans le monde spirituel.$edm$, $edm$1. LA PRIÈRE EN LANGUES

Voici la pratique. Si tu as reçu le baptême du Saint-Esprit avec l'évidence du parler en langues, consacre quotidiennement un temps spécifique à prier en langues.

Par exemple, chaque matin pendant trente minutes à une heure, ou même plus si possible, entre dans ta chambre, ferme la porte, et commence à prier en langues.

Au début, commence doucement, puis laisse l'Esprit augmenter l'intensité. Parfois, les langues seront douces comme un murmure d'adoration. D'autres fois, elles seront fortes comme un cri de guerre spirituel.

Ne cherche pas à comprendre avec ton intelligence ce que tu dis. C'est normal. C'est ton esprit qui parle les mystères de Dieu. Car celui qui parle en langue ne parle pas aux hommes, mais à Dieu, car personne ne le comprend, et c'est en esprit qu'il dit des mystères. 1 Corinthiens 14 verset 2.

Après ce temps de prière en langues, tu te sentiras rechargé spirituellement, fortifié, renouvelé. C'est comme une batterie spirituelle qui se recharge. Des situations qui semblaient impossibles deviennent possibles. Des fardeaux lourds deviennent légers. Ta sensibilité spirituelle s'aiguise.


2. LA PRIÈRE PAR SENSIBILITÉ À L'ESPRIT

Voici la pratique. Tu es en train de vaquer à tes occupations quotidiennes quand soudainement, sans raison apparente, une personne te vient fortement à l'esprit. Tu ressens un poids, une urgence, un fardeau concernant elle. C'est l'Esprit Saint qui t'appelle à intercéder.

Immédiatement, arrête ce que tu fais si possible, et commence à prier : Seigneur, au nom de Jésus, je ne sais pas ce qui se passe avec cette personne, mais Ton Esprit me pousse à prier pour elle. Saint-Esprit, prie à travers moi selon Ta connaissance parfaite.

Puis laisse-toi guider. Tu peux ressentir l'urgence de prier pour sa protection : Père, je la couvre du sang de Jésus, protège-la de tout danger. Pour sa délivrance : je brise toute chaîne spirituelle sur elle, au nom de Jésus. Pour son salut : touche son cœur, ouvre ses yeux spirituels. Pour sa santé : guéris-la, fortifie-la.

Continue à prier jusqu'à ce que le fardeau se lève, jusqu'à ce que tu ressentes une paix, une libération dans ton esprit. C'est le signe que la mission d'intercession est accomplie.

Plus tard, tu peux découvrir que cette personne était effectivement dans une situation critique à ce moment précis. Un accident évité, une tentation intense, une crise personnelle. Ton obéissance à l'Esprit l'a couverte dans le monde spirituel.

Cette sensibilité se développe avec la pratique. Plus tu obéis aux petites impulsions de l'Esprit, plus Il te confiera des intercessions profondes et stratégiques.


3. LA PRIÈRE PAR SOUPIR

Voici la pratique. Entre dans ta chambre de prière. Mets-toi à genoux ou prosterne-toi face contre terre. Commence à prier, mais au lieu de chercher des mots éloquents, laisse sortir ce qui est dans les profondeurs de ton esprit.

Des soupirs profonds commencent à monter. Des gémissements.

Ne les réprime pas. Ne cherche pas à être présentable ou religieux. Laisse l'Esprit gémir à travers toi. C'est l'intercession la plus profonde, la plus puissante, et celle qui te bâtit le plus spirituellement.

Parfois, ces soupirs sont accompagnés de larmes. Celui qui sème avec larmes moissonnera avec chants d'allégresse. Psaume 126 verset 5.

Tu peux rester ainsi dix minutes, trente minutes, une heure. Ne regarde pas l'horloge. Continue jusqu'à ce que tu sentes un relâchement, une percée dans l'esprit.

Cette forme de prière travaille dans les profondeurs du monde spirituel tout en te fortifiant et te bâtissant intérieurement. Elle brise des forteresses anciennes, déracine des maux héréditaires, ouvre des cieux d'airain, et te rend spirituellement plus fort et plus mature. C'est l'enfantement spirituel dont parle Paul : Mes enfants, pour qui j'éprouve de nouveau les douleurs de l'enfantement, jusqu'à ce que Christ soit formé en vous. Galates 4 verset 19.$edm$, $edm$✅ Acquis, je maîtrise bien : ...

⏳ En cours, je comprends mais je dois approfondir : ...

🔄 À travailler, je dois revenir dessus plus tard : ...

(Exemples de points à évaluer : prier pour me bâtir plutôt que pour une situation · la prière en langues · la sensibilité à l'Esprit · la prière par soupir · ma pratique de la semaine.)$edm$, false, true),
('formation', 15, 3, 3, $edm$Savoir prier Dieu$edm$, $edm$Se bâtir par la Parole$edm$, $edm$À la fin de ce module, tu sauras :
- expliquer ce que signifie prier par la Parole ;
- prier avec les psaumes, en quatre étapes ;
- prier par information historique, à partir de ce que Dieu a fait ;
- prier par promesse biblique, en distinguant la promesse de devenir et la promesse d'avenir.$edm$, $edm$LA PRIÈRE POUR SE BÂTIR, PAR LA PAROLE

Prier par la Parole signifie prier pour se construire spirituellement. Quand nous prions ainsi, nous cherchons à relier la Parole de Dieu à notre vie concrète, à faire en sorte que ce que nous lisons devienne une réalité pour nous. Nous prions pour que les promesses, les manifestations de Dieu et Ses actions passées se rattachent à notre nature et nous arrivent personnellement.

Lorsque Christ déclare : Voici les miracles qui accompagneront ceux qui auront cru, nous prions en tant que croyants pour que cette parole s'accomplisse dans nos vies. Prier par la Parole est donc un moyen de se bâtir spirituellement.


PREMIÈREMENT, PRIER AVEC LES PSAUMES

Un psaume est l'expression d'une prière sous forme de cantique.

Les psaumes contiennent toutes les formes de prière imaginables : louanges, adorations, recueillements, recommandations au Seigneur, prières d'accusation, moments d'exaucement ou de non-exaucement, paroles prophétiques. Ce sont des recueils composés par des personnes qui ont tellement prié que leurs prières sont devenues des collections permanentes.

Prier avec les psaumes ne vise pas immédiatement à répondre à une situation précise. Cette pratique nous permet plutôt d'éduquer notre âme, de l'aiguiser à la présence de Dieu, de bâtir notre esprit comme une forteresse vivante, et de relever en nous l'autorité de Dieu. La compréhension de cette parole nous envoie hériter de manière manifeste de ce qui y est dit.

Voici le processus de prière avec les psaumes. Voici ce qui se passe lorsqu'on lit un psaume de manière répétée, de la première à la douzième lecture.

Premièrement, la lecture : on découvre le texte.
Deuxièmement, l'expression selon le psaume : à force de lire, on apprend à s'exprimer selon les mots du psaume.
Troisièmement, la personnalisation : on personnalise l'expression du psaume à notre propre situation.
Quatrièmement, les proclamations : la maturité acquise par cette lecture nous permet d'en extraire des paroles à déclarer pour que ce que nous désirons se réalise.

Les psaumes conduisent particulièrement vers des manifestations spirituelles en Christ.


DEUXIÈMEMENT, PRIER PAR INFORMATION HISTORIQUE

C'est prier à partir de ce que Dieu a fait dans le passé. Les récits bibliques ne sont pas de simples souvenirs, mais des témoignages vivants de la nature immuable de Dieu. Ce que Dieu a fait hier révèle qui Il est aujourd'hui. En priant à partir des actions historiques de Dieu, nous rattachons Sa nature et Sa puissance démontrées à notre propre vie.

Prenons l'exemple de Jésus guérissant l'aveugle de naissance, en Jean chapitre 9.

La pratique se déroule en cinq étapes. La lecture : lire attentivement le récit de Jean 9. La compréhension : comprendre l'action de Dieu, la guérison d'un aveugle de naissance, l'utilisation de la boue, la manifestation de la gloire de Dieu. La méditation : méditer sur la nature de ce Dieu qui guérit, qui utilise des moyens inattendus, qui manifeste Sa puissance. L'expression par la foi : exprimer sa foi que ce même Dieu peut agir aujourd'hui dans sa propre vie. Et la proclamation : déclarer et rattacher personnellement cette action divine.


TROISIÈMEMENT, PRIER PAR PROMESSE BIBLIQUE

Les promesses bibliques sont les déclarations de Dieu concernant ce qu'Il fera pour nous ou ce que nous deviendrons en Lui. Prier par promesse, c'est s'approprier ces paroles divines et les rattacher à notre réalité personnelle. Il existe deux catégories principales de promesses.

D'abord, la promesse de devenir, c'est-à-dire ce que vous deviendrez.

Ces promesses définissent notre identité spirituelle et les capacités que Dieu nous donne en Christ. Elles révèlent qui nous sommes appelés à être et ce que nous pouvons accomplir par Sa puissance. En priant ces promesses, nous bâtissons notre vie sur cette nouvelle identité.

Prenons Marc chapitre 16, versets 17 et 18. Voici les miracles qui accompagneront ceux qui auront cru : en mon nom, ils chasseront les démons ; ils parleront de nouvelles langues ; ils saisiront des serpents ; s'ils boivent quelque breuvage mortel, il ne leur fera point de mal ; ils imposeront les mains aux malades, et les malades seront guéris.

Ensuite, la promesse d'avenir, c'est-à-dire ce que Dieu prépare pour vous.

Ces promesses concernent le plan et la destinée que Dieu a préparés pour notre vie. Elles révèlent Ses intentions bienveillantes et la direction dans laquelle Il nous conduit. En priant ces promesses, nous alignons notre foi et nos attentes sur ce que Dieu a déjà décidé d'accomplir pour nous.

Prenons Jérémie chapitre 29 verset 11. Car je connais les projets que j'ai formés sur vous, dit l'Éternel, projets de paix et non de malheur, afin de vous donner un avenir et de l'espérance.$edm$, $edm$- Prier par la Parole, c'est prier pour se construire spirituellement, en reliant la Parole de Dieu à sa vie concrète.
- Prier avec les psaumes ne vise pas d'abord une situation précise : cela éduque l'âme, l'aiguise à la présence de Dieu et bâtit l'esprit comme une forteresse vivante.
- Quatre étapes avec un psaume : la lecture, l'expression selon le psaume, la personnalisation, les proclamations.
- Prier par information historique, c'est prier à partir de ce que Dieu a fait dans le passé : ce que Dieu a fait hier révèle qui Il est aujourd'hui.
- Cinq étapes : la lecture, la compréhension, la méditation, l'expression par la foi, la proclamation.
- Prier par promesse biblique, c'est s'approprier les paroles divines et les rattacher à sa réalité personnelle.
- Deux catégories de promesses : la promesse de devenir (identité et capacités en Christ) et la promesse d'avenir (le plan et la destinée que Dieu a préparés).$edm$, $edm$1. PRIER AVEC LES PSAUMES

Voici la pratique. Choisis un psaume, par exemple le Psaume 91. Lis-le lentement chaque jour pendant plusieurs semaines.

La première semaine, tu lis simplement, tu découvres les mots. Celui qui demeure sous l'abri du Très-Haut.

La deuxième semaine, tu commences à t'exprimer selon le psaume. En prière, tu dis : Seigneur, je veux demeurer sous Ton abri.

La troisième semaine, tu personnalises : Éternel, Tu es mon refuge et ma forteresse, mon Dieu en qui je me confie.

La quatrième semaine et au-delà, tu proclames avec autorité : Aucun malheur ne m'arrivera. Aucun fléau n'approchera de ma tente. Car Il a ordonné à ses anges de me garder dans toutes mes voies.

Le psaume n'est plus un simple texte, il est devenu ta prière, ton langage spirituel, ta proclamation de foi. Ton âme est éduquée, ton esprit est bâti.


2. PRIER PAR INFORMATION HISTORIQUE

Voici l'exemple concret. Après avoir lu et médité Jean 9, prie ainsi :

Père, au nom de Jésus, comme Tu as ouvert les yeux de l'aveugle de naissance, ouvre mes yeux spirituels. Comme Tu as utilisé la boue, une chose simple, pour manifester Ta gloire, utilise même mes faiblesses pour manifester Ta puissance. Tu es le même hier, aujourd'hui et éternellement. Ce que Tu as fait pour cet homme, Tu peux le faire pour moi. Je me rattache cette œuvre. Je reçois par la foi que Tu opères en moi comme Tu as opéré en lui. Au nom de Jésus, amen.

Tu ne pries pas seulement pour une guérison physique, tu te bâtis spirituellement en rattachant à ta vie la nature guérisseuse et miraculeuse de Dieu.


3. PRIER PAR PROMESSE : LA PROMESSE DE DEVENIR

Voici l'exemple concret. Prie ainsi :

Père, au nom de Jésus, Ta Parole déclare que ces miracles accompagneront ceux qui auront cru. Je suis un croyant, donc ces miracles m'accompagnent. Je reçois cette capacité de chasser les démons en Ton nom. Je reçois le pouvoir d'imposer les mains aux malades et de les voir guérir. Je suis devenu une personne qui porte Ta puissance miraculeuse. Ce n'est pas par mes forces, mais par Ta grâce. Cette promesse est mienne. Je la rattache à ma vie. Je suis ce que Tu as dit que je suis. Au nom de Jésus, amen.

Répète cette prière régulièrement. Tu te bâtis spirituellement en rattachant à ta nature cette identité miraculeuse que Dieu te donne en Christ.


4. PRIER PAR PROMESSE : LA PROMESSE D'AVENIR

Voici l'exemple concret. Prie ainsi :

Père, au nom de Jésus, Tu connais les projets que Tu as formés sur moi. Ce sont des projets de paix et non de malheur. Tu me donnes un avenir et de l'espérance. Je ne marche pas dans l'incertitude ou la peur. Je marche dans la confiance que Tu as préparé mon chemin. Même si je ne vois pas encore tous les détails, je sais que Ton plan pour moi est bon. Je m'aligne avec Tes projets. Je rejette tout projet de l'ennemi. Je reçois l'avenir que Tu as préparé pour moi. Cette promesse est mienne. Au nom de Jésus, amen.

Cette prière te bâtit spirituellement en enracinant en toi une confiance profonde dans la bonté et la fidélité de Dieu concernant ton avenir.$edm$, $edm$✅ Acquis, je maîtrise bien : ...

⏳ En cours, je comprends mais je dois approfondir : ...

🔄 À travailler, je dois revenir dessus plus tard : ...

(Exemples de points à évaluer : prier avec les psaumes · prier par information historique · la promesse de devenir · la promesse d'avenir · ma pratique de la semaine.)$edm$, false, true),
('formation', 16, 3, 3, $edm$Savoir prier Dieu$edm$, $edm$Intercéder, créer, détruire et vivre en prière$edm$, $edm$À la fin de ce module, tu sauras :
- expliquer ce qu'est l'intercession et son fondement : l'amour du prochain ;
- prier pour créer, en proclamant ce que Dieu a déjà donné ;
- prier pour détruire les œuvres de l'ennemi, avec autorité et avec amour ;
- faire de la prière un mode de vie.$edm$, $edm$LA PRIÈRE D'INTERCESSION

L'intercession est l'acte de se tenir entre Dieu et une autre personne, ou une situation, ou une nation, pour plaider en sa faveur.

Je cherchai parmi eux un homme qui élevât un mur, qui se tînt à la brèche devant moi en faveur du pays, afin que je ne le détruisisse pas ; et je n'en trouvai point. Ézéchiel 22 verset 30.

Jésus Lui-même intercède continuellement pour nous. C'est pourquoi il peut aussi sauver parfaitement ceux qui s'approchent de Dieu par lui, étant toujours vivant pour intercéder en leur faveur. Hébreux 7 verset 25. L'intercesseur imite Christ en portant le fardeau des autres devant Dieu.

Abraham a intercédé pour Sodome. Abraham s'approcha, et dit : Feras-tu périr le juste avec le méchant ? Genèse 18 verset 23.

Moïse a intercédé pour Israël après le veau d'or, se plaçant lui-même sur la ligne. Pardonne maintenant leur péché ! Sinon, efface-moi de ton livre que tu as écrit. Exode 32 verset 32.

Comment prier l'intercession ?

L'intercession nécessite de porter le fardeau de l'autre comme si c'était le sien propre. Portez les fardeaux les uns des autres, et accomplissez ainsi la loi de Christ. Galates 6 verset 2. Ce n'est pas une prière distante et détachée, mais un engagement du cœur.

L'Esprit Saint Lui-même intercède à travers nous quand nous ne savons pas comment prier. De même aussi l'Esprit nous aide dans notre faiblesse, car nous ne savons pas ce qu'il nous convient de demander dans nos prières. Mais l'Esprit lui-même intercède par des soupirs inexprimables. Romains 8 verset 26.

Voyons maintenant le bien-fondé de l'intercession.

Intercéder n'est pas d'abord une technique de prière. C'est l'expression naturelle du plus grand commandement après l'amour de Dieu : Tu aimeras ton prochain comme toi-même. Matthieu 22 verset 39.

Celui qui aime véritablement son prochain ne peut rester indifférent à son sort spirituel, à ses souffrances, à son éloignement de Dieu. L'amour authentique refuse qu'il arrive à autrui ce qu'on ne voudrait pas pour soi-même. Et il pousse naturellement à porter l'autre devant Dieu.

C'est pourquoi Jésus déclare : Heureux ceux qui procurent la paix, car ils seront appelés fils de Dieu. Matthieu 5 verset 9. L'intercesseur est un artisan de paix. Il se place entre le jugement et la personne, entre la détresse et le secours, pour réconcilier, pour attirer la miséricorde.

Et Jésus déclare aussi : Heureux ceux qui ont faim et soif de la justice, car ils seront rassasiés. Matthieu 5 verset 6. Celui qui intercède porte en lui une soif que justice soit rendue, que la volonté de Dieu s'accomplisse dans la vie d'un autre. Il connaît et désire la justice de Dieu au-delà de son propre intérêt.

Dieu prête une attention particulière à la voix de ceux qui intercèdent, parce que cette prière est portée par l'amour et non par l'intérêt personnel.


LA PRIÈRE POUR CRÉER

L'homme, étant à l'image de Dieu, doit développer la prière de création : appeler à l'existence ce qui n'existe pas. Dieu appelle les choses qui ne sont point comme si elles étaient. Romains 4 verset 17.

Il faut proclamer créativement. La mort et la vie sont au pouvoir de la langue. Proverbes 18 verset 21. À défaut de cette dimension, les prières resteront toujours des supplications dans une conscience de souffrance, et non dans une conscience du pouvoir et des bénédictions déjà donnés par Dieu, qui attendent simplement d'être manifestés.

Oublie tes problèmes et commence à créer. Oublie tes réalités présentes et crée. Si quelqu'un est en Christ, il est une nouvelle création. Les choses anciennes sont passées ; voici, toutes choses sont devenues nouvelles. 2 Corinthiens 5 verset 17.

Tu as la nouveauté en toi qui n'attend que ton expression pour prendre vie, comme la lumière qui est apparue lorsque Dieu dit : Que la lumière soit. Et la lumière fut. Genèse 1 verset 3.

C'est un autre ordre d'opération. Même si tu ne vois pas encore, la vie est dans ta bouche. Car c'est en croyant du cœur qu'on parvient à la justice, et c'est en confessant de la bouche qu'on parvient au salut. Romains 10 verset 10.


LA PRIÈRE POUR DÉTRUIRE

La mort et la vie sont au pouvoir de la langue ; quiconque l'aime en mangera les fruits. Proverbes 18 verset 21.

Détruis les œuvres de l'ennemi. Le Fils de Dieu a paru afin de détruire les œuvres du diable. 1 Jean 3 verset 8. Si quelque chose tombe sur toi, qu'elle se brise ; mais si tu tombes sur les obstacles, écrase-les. Voici, je vous ai donné le pouvoir de marcher sur les serpents et les scorpions, et sur toute la puissance de l'ennemi ; et rien ne pourra vous nuire. Luc 10 verset 19.

Tu ne t'es pas édifié spirituellement pour rien. Les murailles doivent s'effondrer devant toi, comme à Jéricho. Le peuple poussa des cris, et les sacrificateurs sonnèrent des trompettes. Lorsque le peuple entendit le son de la trompette, il poussa de grands cris, et la muraille s'écroula. Josué 6 verset 20.

Tu es trop bâti spirituellement pour reculer. Frappe, détruis. C'est aussi ton droit et ton pouvoir, car rien ne pourra vous nuire. Si satan te gêne, frappe-le.

Ce n'est pas un jeu. Le parcours spirituel pour arriver à ce niveau de prière n'est pas de l'amusement. Il faut frapper avec autorité. Les armes avec lesquelles nous combattons ne sont pas charnelles ; mais elles sont puissantes, par la vertu de Dieu, pour renverser des forteresses. 2 Corinthiens 10 verset 4.

S'il y a un complot contre toi, mets-y la confusion. Réduis à néant leurs desseins, et qu'ils soient confondus. Psaume 83. C'est toi qui as le règne de Dieu, et non eux. Le royaume de Dieu ne vient pas de manière à frapper les regards. On ne dira point : Il est ici, ou : Il est là. Car voici, le royaume de Dieu est au milieu de vous. Luc 17 versets 20 et 21.


LA PRIÈRE COMME MODE DE VIE

La prière doit être une pratique pieuse, une habitude et même une nature. Priez sans cesse. 1 Thessaloniciens 5 verset 17. Il est essentiel d'ordonner sa vie de prière, de la structurer et de la cultiver quotidiennement. Persévérez dans la prière, veillez-y avec actions de grâces. Colossiens 4 verset 2.

Car une vie de prière ordonnée et disciplinée est d'une importance capitale pour tout croyant qui désire marcher dans la plénitude de sa destinée spirituelle. Celui qui demeure sous l'abri du Très-Haut repose à l'ombre du Tout-Puissant. Psaume 91 verset 1.

La prière n'est pas une option, c'est la respiration de l'âme. Sans elle, tu meurs spirituellement. Avec elle, tu règnes.$edm$, $edm$- L'intercession est l'acte de se tenir entre Dieu et une autre personne, une situation ou une nation, pour plaider en sa faveur.
- Jésus intercède continuellement pour nous : l'intercesseur imite Christ en portant le fardeau des autres.
- Intercéder, c'est porter le fardeau de l'autre comme si c'était le sien, par un engagement du cœur. L'Esprit intercède aussi à travers nous par des soupirs inexprimables.
- L'intercession est l'expression naturelle de l'amour du prochain. L'intercesseur est un artisan de paix, avec une soif que la volonté de Dieu s'accomplisse.
- La prière pour créer : appeler à l'existence ce qui n'existe pas, en proclamant ce que Dieu a déjà donné. La vie est dans notre bouche.
- Trois points : parler au présent, ne pas regarder le visible, y revenir.
- La prière pour détruire : détruire les œuvres de l'ennemi, avec autorité, car le pouvoir a été donné.
- Quatre points : être précis, frapper avec autorité et non avec peur, tenir jusqu'à la chute, garder l'amour. On détruit des œuvres, jamais des personnes.
- La prière est un mode de vie : priez sans cesse, ordonnez et structurez sa vie de prière. C'est la respiration de l'âme.$edm$, $edm$1. L'INTERCESSION

Voici la pratique.

Tu portes devant Dieu quelqu'un qui s'est éloigné. Tu ne récites pas son nom. Tu portes son fardeau comme s'il était le tien. Tu te places à la brèche :

Père, au nom de Jésus, je me tiens devant Toi pour lui. Je porte son fardeau comme si c'était le mien. Ne le laisse pas périr. Ouvre ses yeux spirituels. Attire son cœur à Toi. Je me place à la brèche en sa faveur, au nom de Jésus. Amen.

Il y a des jours où tu ne sauras pas quoi dire. C'est là que l'Esprit intercède par des soupirs inexprimables. Laisse-Le prier à travers toi.

Et reviens. Une veille spirituelle ne dure pas un jour. L'Esprit te montrera quand porter, quand insister, et quand rendre grâce parce que la chose est faite dans le ciel avant d'être visible sur la terre.


2. LA PRIÈRE POUR CRÉER

Voici la pratique. Tu es dans une situation de manque, ou devant un projet qui n'existe encore que dans ton cœur. Ne commence pas par décrire ce qui te manque, Dieu le sait déjà.

Entre dans ta chambre et déclare :

Père, au nom de Jésus, Tu appelles les choses qui ne sont point comme si elles étaient. Je suis à Ton image, et je parle selon Ton ordre. Je ne parle pas de ma situation, je parle à ma situation.

Puis proclame au présent, pas au futur :

Au nom de Jésus, il y a la vie dans ce projet. Il prospère. Il porte du fruit. Les portes sont ouvertes. Les hommes qu'il faut viennent à moi. Ce qui était stérile devient fécond. Au nom de Jésus, amen.

Trois choses à surveiller.

Parle au présent. Pas Seigneur, donne-moi, mais je possède. Pas je serai guéri, mais je suis guéri. Dieu a dit que la lumière soit, et la lumière fut. Il n'a pas demandé qu'elle vienne un jour.

Ne regarde pas le visible. Même si rien n'a changé autour de toi, la vie est déjà dans ta bouche. Ce que tu confesses aujourd'hui prend forme dans l'invisible avant d'apparaître.

Reviens-y. La création par la parole n'est pas une déclaration unique. Tu proclames jusqu'à ce que ta propre conscience change, jusqu'à ce que tu ne sois plus dans la conscience de la souffrance, mais dans celle du pouvoir et des bénédictions déjà données.

Et laisse l'Esprit te montrer ce qu'il faut appeler. Il imprime dans le cœur ce que Dieu a déjà préparé, et ce que tu proclames alors n'est plus ton désir, c'est Sa volonté prononcée par ta bouche.


3. LA PRIÈRE POUR DÉTRUIRE

Voici la pratique. Une chose te résiste. Un blocage qui revient, une opposition que tu identifies clairement comme spirituelle, un complot dont tu perçois les effets.

Ne supplie pas. Tu n'es pas venu demander une permission, elle t'a été donnée : je vous ai donné le pouvoir de marcher sur les serpents et les scorpions.

Tiens-toi debout et ordonne :

Au nom de Jésus, je brise cette œuvre. Je renverse cette forteresse. Je détruis ce qui a été dressé contre ma vie. Ce que l'ennemi a bâti, je le démolis maintenant, au nom de Jésus.

Tout complot formé contre moi, au nom de Jésus je le réduis à néant. Que la confusion entre dans leurs desseins. Le règne est à Dieu, et Dieu règne par moi. Au nom de Jésus, amen.

Quatre points essentiels.

Sois précis. N'ordonne pas dans le vide. Nomme ce que tu détruis. Si tu ne le discernes pas, demande d'abord à l'Esprit de te le révéler. Il montre l'adversaire avant le combat.

Frappe avec autorité, pas avec peur. Celui qui crie fort parce qu'il a peur ne détruit rien. Celui qui parle calmement depuis sa position en Christ renverse des murailles.

Tiens jusqu'à la chute. À Jéricho, les murailles ne sont pas tombées au premier tour. Le peuple a tourné sept jours avant le cri qui a tout fait s'écrouler. Ne conclus pas à l'échec parce que rien n'a bougé le premier jour.

Et garde l'amour. Tu détruis des œuvres, jamais des personnes. L'adversaire est spirituel. Celui qui te blesse humainement, tu le bénis. Mais l'œuvre des ténèbres derrière lui, tu la brises.$edm$, $edm$✅ Acquis, je maîtrise bien : ...

⏳ En cours, je comprends mais je dois approfondir : ...

🔄 À travailler, je dois revenir dessus plus tard : ...

(Exemples de points à évaluer : l'intercession · la prière pour créer · la prière pour détruire · la prière comme mode de vie · ma pratique de la semaine.)$edm$, true, true),
('formation', 17, 4, 4, $edm$Savoir adorer Dieu$edm$, $edm$Qu'est-ce qu'adorer vraiment ?$edm$, $edm$À la fin de ce module, tu sauras :
- dire ce qu'est adorer : suraimer ;
- citer l'origine du mot « adorer » et les mots hébreux et grecs qui en parlent ;
- expliquer pourquoi l'adoration est d'abord un état d'amour qui explose dans le cœur, avant l'expression ;
- comprendre l'adoration au milieu des circonstances, comme Job.$edm$, $edm$L'ADORATION : QUAND LE CŒUR APPREND À SURAIMER

QU'EST-CE QU'ADORER VRAIMENT ?

Adorer, simplement dit, c'est suraimer. C'est aimer plus que tout, malgré tout, et au-delà de tout. C'est montrer un amour qui dépasse tous les types d'amour que l'humanité connaît. Le mot vient du latin adorare – qui veut dire littéralement "porter sa bouche vers", un geste qui représentait autrefois le baiser de respect, cette inclinaison du cœur qui se manifeste dans le corps. Dans la Bible hébraïque, shachah signifie se prosterner profondément, halal veut dire louer avec éclat, et en grec, proskuneo évoque l'acte de s'incliner en embrassant vers quelqu'un. Mais tous ces mots pointent vers une seule réalité : un amour qui se donne sans retenue.

Plus précisément dans le contexte d'adorer Dieu, l'adoration est d'abord un état d'amour qui a explosé dans le cœur, bien avant de trouver un point de sortie qu'on appelle l'expression. Quand le cœur est plein d'amour, on arrive à l'expression vraie qui facilite notre entrée dans l'esprit. C'est là que l'heure est venue, et même qu'elle est déjà là, pour que les vrais adorateurs adorent le Père en esprit et en vérité.


L'ADORATION QUI EXALTE DIEU

On pourrait parler d'adoration au sens général, mais concentrons-nous sur une adoration spécifique : celle qui vise l'exaltation de Dieu. Sans amour débordant pour Dieu, il n'y a pas de véritable posture spirituelle, parce que le spirituel en Christ naît de notre sensibilité de cœur. C'est pourquoi, dans le fruit de l'Esprit, le premier point c'est l'amour. Le plus grand commandement parle encore de l'amour, présenté dans toutes les dimensions pour Dieu, mobilisant toutes les dimensions de notre être pour Lui.

La posture dans l'esprit a besoin de l'action profonde de la personne de Dieu dans nos cœurs. L'amour profond pour Dieu, quand il est exprimé, nous rend sensibles à l'Esprit et nous permet de rester dans l'Esprit, pour exprimer la vérité exaltante de Dieu qui a rempli nos cœurs. C'est un processus naturel : l'explosion intérieure vient toujours avant l'expression extérieure. On ne peut donner que ce qu'on possède, et on ne peut exprimer authentiquement que ce qui déborde vraiment.


L'ADORATION AU MILIEU DES CIRCONSTANCES

L'adoration qui monte vers Dieu, le cœur plein d'amour qui s'exprime, ce n'est pas forcément un cœur lié à une âme comblée. Non. On peut connaître des émotions, mais quand cela n'affecte pas l'état de nos cœurs, cela montre la vérité au milieu des réalités. L'adoration qui monte, c'est l'expression pleine de l'amour pour Dieu au milieu des circonstances.

Que Dieu ait fait quelque chose ou pas, tu L'aimes. On t'a poignardé, attristé. Tu as tout perdu, tu as tout gagné. On t'a humilié, abandonné, rejeté. L'essentiel : tu continues de L'aimer de tout, malgré tout, et tu exprimes Sa magnificence. C'est cette adoration qui a de l'impact.

Job l'a vécu quand il a déclaré : "L'Éternel a donné, et l'Éternel a ôté ; que le nom de l'Éternel soit béni !" Ce n'était pas de la résignation, mais de l'adoration pure – un amour qui refuse de dépendre des bénédictions pour exister.$edm$, $edm$- Adorer, c'est suraimer : aimer plus que tout, malgré tout, et au-delà de tout.
- Le mot vient du latin adorare : « porter sa bouche vers », le baiser de respect, une inclinaison du cœur qui se manifeste dans le corps.
- En hébreu : shachah (se prosterner profondément) et halal (louer avec éclat). En grec : proskuneo (s'incliner en embrassant vers quelqu'un).
- Tous ces mots pointent vers un amour qui se donne sans retenue.
- L'adoration est d'abord un état d'amour qui a explosé dans le cœur, avant l'expression.
- L'explosion intérieure vient toujours avant l'expression extérieure : on ne peut exprimer authentiquement que ce qui déborde vraiment.
- L'adoration qui exalte Dieu naît de l'amour débordant pour Lui : l'amour est le premier fruit de l'Esprit.
- L'adoration monte aussi au milieu des circonstances : on aime Dieu qu'Il ait fait quelque chose ou non. C'est celle-là qui a de l'impact.
- Job : « L'Éternel a donné, et l'Éternel a ôté ; que le nom de l'Éternel soit béni ! » C'est de l'adoration pure, non de la résignation.$edm$, $edm$Cette semaine, tu prépares ton cœur. Les étapes concrètes de l'adoration sont dans le module 5.

1. Écris ta propre phrase. En une phrase, avec tes mots : « Pour moi, adorer, c'est... »

2. Relis la définition. Suraimer : aimer plus que tout, malgré tout, et au-delà de tout. Souligne le mot qui te parle le plus.

3. Repère une circonstance. Pense à une situation difficile que tu traverses ou que tu as traversée. Note : mon amour pour Dieu dépend-il de ce qu'Il fait ou ne fait pas ?$edm$, $edm$✅ Acquis, je maîtrise bien : ...

⏳ En cours, je comprends mais je dois approfondir : ...

🔄 À travailler, je dois revenir dessus plus tard : ...

(Exemples de points à évaluer : adorer, c'est suraimer · l'explosion intérieure avant l'expression · l'adoration qui exalte Dieu · l'adoration au milieu des circonstances.)$edm$, false, true),
('formation', 18, 4, 4, $edm$Savoir adorer Dieu$edm$, $edm$Adorer en esprit et en vérité$edm$, $edm$À la fin de ce module, tu sauras :
- expliquer ce que veut dire adorer « en vérité » ;
- expliquer ce que veut dire adorer « en esprit » ;
- faire la différence entre chercher et rechercher ;
- comprendre que l'adoration est une expression du cœur, non une pratique pieuse.$edm$, $edm$ADORER EN ESPRIT ET EN VÉRITÉ

Jésus a révélé à la femme samaritaine que Dieu cherche ceux qui L'adorent en esprit et en vérité. Deux dimensions qu'on ne peut pas séparer.

La vérité, ou en vérité, c'est le ressenti exprimé. Dieu cherche l'expression d'un cœur véridique. Fort ou faible, Dieu veut l'expression de nos cœurs. Ce qu'il faut retenir : si l'homme doit rechercher le Royaume, et si Dieu doit rechercher un vrai adorateur, définissons ce que signifie rechercher, qui est différent de simplement chercher.

Que veut dire rechercher ? On recherche ce qui a de la valeur et de l'importance parmi les hommes pieux, sanctifiés, engagés à servir Dieu, pratiquant les actes de foi et même prophétiques, allant dans les lieux mythiques qui confirment la parole de Dieu, méditant Dieu, ceux qui vont dans les lieux de culte et qui sont vraiment ponctuels... Mais Dieu recherche... ceux qui pourraient L'adorer en esprit et en vérité.

Ce dont je te parle maintenant, c'est l'adoration en termes d'expression de cœur et non de pratique pieuse. Le cœur qui adore n'est rien d'autre que l'esprit vivifié en nous.

Cet esprit qui est en nous n'est pas forcément lié à la chair, mais il est au-dedans de nous. C'est lui qui exprime la vérité, c'est lui qui est l'expression de la vérité de ce qu'on ressent pour Dieu.

Adorer en esprit veut dire que c'est ton esprit qui communique avec l'Esprit de Dieu. Ce n'est plus ton intelligence, ce ne sont plus tes mots réfléchis, mais c'est une connexion spirituelle. Quand on arrive à cet état, on est dans la véritable adoration.

Adorer en vérité, c'est être vrai avec soi-même devant Dieu. C'est ne pas cacher sa douleur, sa joie ou ses doutes, mais tout apporter à Ses pieds en reconnaissant Sa souveraineté. Dieu ne cherche pas des acteurs, Il cherche des cœurs qui se livrent sans fard. Si l'adoration est un parfum, la vérité est le flacon qui le contient. Sans vérité, le parfum se perd. Sans esprit, il n'a pas d'odeur pour Dieu.$edm$, $edm$- Dieu cherche ceux qui L'adorent en esprit et en vérité : deux dimensions qu'on ne peut pas séparer.
- La vérité, c'est le ressenti exprimé : Dieu cherche l'expression d'un cœur véridique, fort ou faible.
- Rechercher est différent de simplement chercher.
- Dieu recherche ceux qui pourraient L'adorer en esprit et en vérité, plus que les pratiques pieuses.
- L'adoration, ici, est une expression du cœur, et non une pratique pieuse.
- Le cœur qui adore n'est rien d'autre que l'esprit vivifié en nous.
- Adorer en esprit : c'est ton esprit qui communique avec l'Esprit de Dieu, au-delà de l'intelligence et des mots réfléchis.
- Adorer en vérité : être vrai avec soi-même devant Dieu, sans cacher sa douleur, sa joie ou ses doutes.
- Dieu ne cherche pas des acteurs, mais des cœurs qui se livrent sans fard.
- Si l'adoration est un parfum, la vérité est le flacon qui le contient : sans vérité, le parfum se perd ; sans esprit, il n'a pas d'odeur pour Dieu.$edm$, $edm$Cette semaine, tu examines ton adoration. Les étapes concrètes sont dans le module 5 (la troisième étape).

1. Écris une phrase vraie. Sans chercher à bien faire, écris en une phrase ce que tu ressens réellement devant Dieu aujourd'hui : fatigue, joie, doute, colère, reconnaissance.

2. Dis-la à Dieu. À voix haute ou dans ton cœur, présente-Lui cette phrase telle quelle, sans la polir.

3. Fais la différence. Note la différence entre une prière récitée par habitude et une expression qui vient vraiment de ton esprit.$edm$, $edm$✅ Acquis, je maîtrise bien : ...

⏳ En cours, je comprends mais je dois approfondir : ...

🔄 À travailler, je dois revenir dessus plus tard : ...

(Exemples de points à évaluer : adorer en vérité · adorer en esprit · chercher et rechercher · une expression du cœur plutôt qu'une pratique pieuse · ma phrase vraie devant Dieu.)$edm$, false, true),
('formation', 19, 4, 4, $edm$Savoir adorer Dieu$edm$, $edm$L'adoration au-delà du chant, et sa puissance$edm$, $edm$À la fin de ce module, tu sauras :
- expliquer pourquoi l'adoration n'est pas le chant ;
- reconnaître les différentes formes que prend l'adoration ;
- comprendre comment l'adoration transforme celui qui adore ;
- comprendre comment l'adoration libère.$edm$, $edm$L'ADORATION AU-DELÀ DU CHANT

L'adoration ne s'arrête pas à la mélodie ou au chant. L'adoration n'est pas le chant. Le chant est un canal d'expression de l'adoration. On peut adorer sans chanter. On peut adorer par un regard, par un soupir, par un silence, parce que le cœur est en train d'exhaler un parfum vers Dieu.

Marie de Béthanie a adoré en cassant un vase de parfum de grand prix aux pieds de Jésus, sans dire un mot. Abraham a adoré en levant le couteau au-dessus d'Isaac. Paul et Silas ont adoré en chantant dans la prison à minuit, le dos ensanglanté. L'adoration prend mille formes quand le cœur est vraiment rempli.


LA PUISSANCE TRANSFORMATRICE DE L'ADORATION

L'adoration a un impact non seulement sur le cœur de Dieu, mais aussi sur celui qui adore. L'adoration nous transforme à l'image de ce qu'on adore. Si on adore Dieu en esprit et en vérité, on commence à refléter Sa nature, Sa paix et Son amour. C'est une loi spirituelle : on devient semblable à ce sur quoi on fixe nos regards avec admiration et amour.

Dieu siège au milieu de l'adoration de Son peuple. Cela veut dire que quand tu adores, tu crées un environnement où Sa présence devient palpable. Ce n'est plus une question de lieu géographique, comme le disait Jésus à la femme samaritaine, mais une question de disposition de cœur. Partout où un cœur s'exprime en vérité, cet endroit devient le parvis de Dieu.

Il y a une libération qui se produit dans l'expression. Beaucoup de lourdeurs spirituelles et émotionnelles ne partent pas par la prière de demande, mais par l'adoration. Pourquoi ? Parce qu'en adorant, tu sors de toi-même, tu sors de tes problèmes pour fixer tes regards sur la grandeur de Dieu. C'est ce transfert de regard qui brise les chaînes. Quand Dieu devient plus grand dans ta vision, tes montagnes reprennent leur vraie taille.$edm$, $edm$- L'adoration n'est pas le chant : le chant est un canal d'expression de l'adoration.
- On peut adorer sans chanter : par un regard, un soupir, un silence.
- L'adoration prend mille formes quand le cœur est vraiment rempli : Marie de Béthanie (le parfum), Abraham (le couteau levé), Paul et Silas (le chant dans la prison).
- L'adoration a un impact sur celui qui adore : elle le transforme à l'image de ce qu'il adore.
- C'est une loi spirituelle : on devient semblable à ce sur quoi on fixe nos regards avec admiration et amour.
- Dieu siège au milieu de l'adoration de Son peuple : quand tu adores, Sa présence devient palpable.
- Partout où un cœur s'exprime en vérité, cet endroit devient le parvis de Dieu.
- L'adoration libère : en adorant, on sort de soi-même et de ses problèmes pour fixer ses regards sur la grandeur de Dieu. Ce transfert de regard brise les chaînes.$edm$, $edm$Cette semaine, tu découvres ta façon d'exprimer l'adoration. Les étapes concrètes sont dans le module 5 (la deuxième étape).

1. Repère ton canal. Demande-toi : par quoi est-ce que j'exprime d'habitude mon adoration (le chant, la parole, l'écriture, le silence, un geste) ?

2. Essaie un autre canal. Pendant cinq minutes, adore Dieu par une autre forme que d'habitude : un regard, un silence, un soupir, une parole, un geste.

3. Note le transfert de regard. Après ce temps, note ce qui s'est passé : sur quoi tes regards étaient-ils fixés avant, et sur quoi sont-ils fixés maintenant ?$edm$, $edm$✅ Acquis, je maîtrise bien : ...

⏳ En cours, je comprends mais je dois approfondir : ...

🔄 À travailler, je dois revenir dessus plus tard : ...

(Exemples de points à évaluer : l'adoration n'est pas le chant · les formes de l'adoration · l'adoration me transforme · Dieu siège au milieu de l'adoration · le transfert de regard qui libère.)$edm$, false, true),
('formation', 20, 4, 4, $edm$Savoir adorer Dieu$edm$, $edm$Comment nourrir l'expression du cœur$edm$, $edm$À la fin de ce module, tu sauras :
- expliquer pourquoi l'expression du cœur doit être nourrie ;
- citer les trois aspects qui nourrissent l'expression du cœur ;
- décrire les quatre dimensions du plus grand commandement ;
- comprendre pourquoi il faut enrichir son langage poétique envers Dieu.$edm$, $edm$COMMENT NOURRIR L'EXPRESSION DU CŒUR

L'expression du cœur est la base de l'adoration. Mais cette expression ne surgit pas du vide – elle se nourrit, elle se cultive, elle s'enrichit. Pour que ton cœur déborde vraiment, il doit être rempli. Pour qu'il exprime la magnificence de Dieu, il doit d'abord la contempler, la recevoir, s'en imprégner.

L'expression du cœur se nourrit de trois aspects essentiels :


PREMIER ASPECT : LE PLUS GRAND COMMANDEMENT

Tout le monde le connaît : aimer Dieu de tout son cœur, de toute son âme, de toute sa pensée, et de toute sa force. C'est le fondement même de l'adoration. Avant toute technique, avant toute forme, il y a cette décision profonde d'aimer Dieu dans toutes les dimensions de ton être.

- De tout ton cœur : le siège de tes émotions, de tes affections, de ce qui te fait vibrer
- De toute ton âme : ta volonté, ton identité profonde, ce que tu es vraiment
- De toute ta pensée : ton intelligence, ta réflexion, ta compréhension de qui Il est
- De toute ta force : ton énergie, tes capacités, tes actions concrètes, tout ce que tu peux mobiliser

Ce commandement n'est pas une obligation légaliste, c'est une invitation à engager tout ton être dans l'acte d'aimer Dieu. L'adoration véritable mobilise la totalité de ce que tu es : ton cœur qui ressent, ton âme qui choisit, ta pensée qui médite, et ta force qui agit.


DEUXIÈME ASPECT : LA PAROLE DE DIEU

L'expression du cœur se nourrit de la Parole de Dieu qui exalte Sa personnalité et Sa toute-puissance. Bien sûr, ce sont des informations qu'on tire de Lui, au niveau de Sa Parole.

Les Écritures ne sont pas seulement un manuel de conduite ou un recueil de promesses – elles sont une révélation de qui Dieu est. Chaque page dévoile un aspect de Sa nature : Sa sainteté qui consume, Sa miséricorde qui restaure, Sa fidélité qui ne vacille jamais, Sa puissance qui crée et recrée, Sa sagesse qui dépasse toute compréhension.

Quand tu médites la Parole avec cette perspective – celle de découvrir Dieu Lui-même – ton cœur s'enrichit d'un vocabulaire spirituel. Tu apprends à Le nommer au-delà des clichés : Il n'est pas seulement "bon", Il est l'Ancien des Jours, le Lion de Juda, l'Époux de l'Église, le Rocher des siècles, le Berger compatissant, le Roi des rois.


TROISIÈME ASPECT : LES TÉMOIGNAGES VÉCUS AVEC DIEU

L'expression du cœur se nourrit également des témoignages vécus avec Dieu, ces moments où tu L'as rencontré personnellement, où Il t'a parlé, où Il est intervenu dans ta vie. Ces expériences peuvent aussi qualifier Dieu, Lui donner des noms issus de ton histoire avec Lui.

Il devient pour toi "Celui qui m'a relevé", "Celui qui m'a consolé dans la nuit", "Celui qui a ouvert un chemin là où il n'y en avait pas", "Celui qui m'a gardé quand tout s'écroulait". Tes témoignages personnels enrichissent ton adoration d'une authenticité que rien d'autre ne peut apporter.


ENRICHIR SON LANGAGE POÉTIQUE ENVERS DIEU

Donc, le cœur a besoin de se nourrir de ces trois choses pour que son expression soit riche, profonde, variée. Il faut enrichir son langage poétique envers Dieu. Bien avant d'avoir la voix, ou la parole, ou bien d'autres choses, il faut avoir le poème, il faut avoir la romance, il faut avoir le sonnet qu'il faut exprimer et qui vient du cœur.

C'est tellement simple : c'est le fait d'exprimer sans réfléchir ce qu'on ressent face à la grandeur de Dieu. Mais pour que cette expression soit naturelle, spontanée, débordante, le cœur doit être nourri. Un cœur mal nourri produit des expressions pauvres, répétitives, vides. Un cœur bien nourri déborde de mille manières de dire "Je T'aime" à Dieu.$edm$, $edm$- L'expression du cœur est la base de l'adoration, mais elle ne surgit pas du vide : elle se nourrit, se cultive, s'enrichit.
- Pour que le cœur déborde, il doit être rempli.
- Trois aspects nourrissent l'expression du cœur : le plus grand commandement, la Parole de Dieu, les témoignages vécus avec Dieu.
- Le plus grand commandement : aimer Dieu de tout son cœur, de toute son âme, de toute sa pensée et de toute sa force. C'est le fondement de l'adoration.
- Cœur : émotions et affections. Âme : volonté et identité. Pensée : intelligence et réflexion. Force : énergie, capacités et actions.
- La Parole de Dieu est une révélation de qui Dieu est, pas seulement un manuel de conduite ou un recueil de promesses.
- Les témoignages personnels donnent à Dieu des noms issus de notre histoire avec Lui.
- Il faut enrichir son langage poétique envers Dieu : un cœur mal nourri produit des expressions pauvres et répétitives, un cœur bien nourri déborde de mille manières de dire « Je T'aime ».$edm$, $edm$Cette semaine, tu commences à nourrir ton cœur. Les étapes concrètes sont dans le module 5 (la première étape).

1. Repère ta dimension la plus faible. Parmi les quatre dimensions du plus grand commandement (cœur, âme, pensée, force), laquelle est la plus faible chez toi ? Note-la.

2. Découvre un aspect de Dieu. Lis un passage de la Bible et demande-toi : qu'est-ce que ce texte me révèle sur la personnalité et la puissance de Dieu ? Note un nom ou un attribut que tu découvres.

3. Donne un nom issu de ton histoire. Pense à un moment où Dieu est intervenu dans ta vie. Écris-le et donne à Dieu un nom qui correspond à ce qu'Il a fait : « Celui qui... »$edm$, $edm$✅ Acquis, je maîtrise bien : ...

⏳ En cours, je comprends mais je dois approfondir : ...

🔄 À travailler, je dois revenir dessus plus tard : ...

(Exemples de points à évaluer : pourquoi nourrir l'expression du cœur · le plus grand commandement · la Parole qui révèle qui Dieu est · les témoignages vécus · enrichir mon langage poétique envers Dieu.)$edm$, false, true),
('formation', 21, 4, 4, $edm$Savoir adorer Dieu$edm$, $edm$Comment pratiquer l'adoration$edm$, $edm$À la fin de ce module, tu sauras :
- citer les trois étapes de la pratique de l'adoration : nourrir le cœur, exprimer le cœur, adorer en esprit et en vérité ;
- nourrir ton cœur du plus grand commandement, de la Parole et de tes témoignages ;
- exprimer ton adoration comme un psalmiste, même au milieu des circonstances difficiles ;
- adorer en esprit et en vérité, et tenir un journal d'adoration.$edm$, $edm$COMMENT PRATIQUER L'ADORATION

Maintenant qu'on sait de quoi le cœur se nourrit et comment l'adoration fonctionne, passons à la pratique concrète. L'apprentissage de l'adoration suit un chemin logique en trois grandes étapes.


PREMIÈRE ÉTAPE : NOURRIR LE CŒUR

Avant de pouvoir adorer avec profondeur, il faut d'abord remplir le cœur. C'est le fondement. Un cœur vide ne peut pas déborder.

1. Se nourrir du plus grand commandement

Prends du temps chaque jour pour méditer sur le plus grand commandement : aimer Dieu de tout ton cœur, de toute ton âme, de toute ta pensée, et de toute ta force.

Pratique concrète :
- Le matin, déclare intentionnellement : "Aujourd'hui, je choisis de T'aimer de tout mon cœur, de toute mon âme, de toute ma pensée, et de toute ma force."
- Demande-toi : "Est-ce que j'engage vraiment toutes ces dimensions dans mon amour pour Dieu ?"
- Identifie quelle dimension est la plus faible chez toi (cœur, âme, pensée ou force) et travaille dessus

2. Se nourrir de la Parole qui révèle qui Il est

Plonge dans les Écritures non pas pour chercher des promesses ou des instructions, mais pour découvrir qui Dieu est.

Pratique concrète :
Chaque jour, lis un passage et pose-toi cette question : "Qu'est-ce que ce texte me révèle sur la personnalité et la puissance de Dieu ?"

Exemples de passages qui exaltent Dieu :

- Psaume 139 : "Tu me sondes et tu me connais... Ta science est trop merveilleuse pour moi" - Découvre Son omniscience et Sa proximité
- Ésaïe 40:12-31 : "Qui a mesuré les eaux dans le creux de sa main ?" - Contemple Sa grandeur et Sa puissance créatrice
- Exode 34:6-7 : "L'Éternel, l'Éternel, Dieu miséricordieux et compatissant" - Médite Ses attributs de grâce
- Apocalypse 4 : "Saint, saint, saint est le Seigneur Dieu, le Tout-Puissant" - Entre dans la vision de Sa sainteté
- Jean 1:1-18 : "Au commencement était la Parole" - Découvre Sa divinité et Son incarnation
- Psaume 103 : "Bénis l'Éternel, mon âme... qui pardonne toutes tes iniquités" - Vois Sa miséricorde
- Job 38-42 : Les questions de Dieu à Job - Sois confronté à Sa souveraineté absolue

Écris dans un carnet les noms et les attributs de Dieu que tu découvres. Enrichis ton vocabulaire spirituel. Au lieu de toujours dire "Dieu est bon", apprends à dire : "Tu es le Tout-Puissant, l'Ancien des Jours, le Lion de Juda, le Consolateur, Celui qui ouvre les chemins, le Rocher inébranlable."

3. Revisiter tes témoignages personnels

Prends le temps de te souvenir des moments où Dieu est intervenu dans ta vie.

Pratique concrète :
- Écris au moins 5 témoignages personnels de moments où tu as vu Dieu agir dans ta vie
- Pour chaque témoignage, donne un nom à Dieu qui correspond à ce qu'Il a fait : "Celui qui m'a relevé", "Celui qui a ouvert la porte", "Celui qui m'a consolé dans la nuit", etc.
- Relis ces témoignages quand ton cœur devient sec
- Raconte-les à Dieu comme une façon de L'adorer : "Tu es Celui qui..."

Exemple :
"Seigneur, je me souviens quand j'étais au plus bas et que Tu es venu me relever. Tu es Celui qui voit dans les profondeurs. Tu es Celui qui n'abandonne pas. Tu es Celui qui restaure..."


DEUXIÈME ÉTAPE : EXPRIMER LE CŒUR

Maintenant que ton cœur est nourri, il est temps de laisser déborder ce qui est à l'intérieur. C'est ici que tu deviens un psalmiste, que tu deviens comme David.

4. Deviens un psalmiste – Exprime ce qui déborde

Avec un cœur nourri de la Parole, des témoignages et du plus grand commandement, exprime maintenant ton adoration.

Pratique concrète :

Écris tes propres psaumes d'adoration :
Ne te contente pas de répéter les paroles des autres. Écris tes propres déclarations d'amour à Dieu. Laisse ton cœur parler sans censure.

Exemple :
"Seigneur, Tu es plus grand que les montagnes qui m'entourent. Tu es le souffle dans mes poumons. Quand tout tremble, Tu restes ferme. Mon cœur T'aime au-delà des mots. Tu es ma joie même dans la nuit..."

Adore à voix haute :
Seul dans ta chambre, déclare à voix haute qui Dieu est pour toi. Ne chante pas forcément, parle-Lui simplement de ton amour pour Lui.

Utilise différents canaux d'expression :
- Si tu aimes écrire : écris des lettres d'amour à Dieu
- Si tu aimes la musique : chante ou joue pour Lui (même si tu n'es pas musicien)
- Si tu es expressif corporellement : danse devant Lui, lève les mains, prosterne-toi
- Si tu es silencieux : reste en silence mais avec un cœur qui Lui parle sans mots
- Si tu es créatif : dessine, peins, crée quelque chose qui exprime ta révélation de qui Il est

L'important n'est pas la qualité artistique, mais l'authenticité du cœur qui déborde.

5. Adore au milieu des circonstances difficiles

C'est ici que ton adoration sera testée et affinée.

Pratique concrète :
Quand quelque chose de difficile arrive – une déception, une frustration, une mauvaise nouvelle, une blessure – choisis consciemment d'adorer malgré tout.

Ne nie pas la douleur. Ne prétends pas que tout va bien. Mais au milieu de cette réalité, déclare quand même qui Dieu est.

Exemple :
"Seigneur, je suis blessé en ce moment. Mon cœur est lourd. Mais malgré cette douleur, je déclare que Tu es bon. Que Tu m'as fait ou pas, je T'aime. Tu restes Dieu. Tu restes fidèle. Mon amour pour Toi ne dépend pas de mes circonstances."

C'est cette adoration-là qui brise les chaînes. C'est cette adoration-là qui a de l'impact.


TROISIÈME ÉTAPE : ADORER EN ESPRIT ET EN VÉRITÉ

Maintenant que ton cœur est nourri et que tu as commencé à exprimer, approfondis ta pratique en entrant dans l'adoration en esprit et en vérité.

6. Pratique l'adoration en esprit

Adorer en esprit, c'est laisser ton esprit communiquer avec l'Esprit de Dieu, au-delà de ton intelligence et de tes mots réfléchis.

Pratique concrète :

Être présent dans la présence de Dieu :
Chaque jour, prends 15 à 20 minutes pour être simplement présent devant Dieu. Pas de programme fixé à l'avance. Juste être là, disponible, le cœur ouvert vers Lui.

Dans cette présence, ton esprit peut s'exprimer de plusieurs manières :

Par le silence :
Parfois, tu seras simplement silencieux devant Lui. Pas un silence vide, mais un silence habité, rempli de Sa présence. Un silence où ton cœur Lui parle sans mots. Un silence où tu Le contemples simplement.

Par le parler en langues :
Parfois, ton esprit voudra s'exprimer en langues. C'est un canal puissant pour adorer en esprit. Quand tu adores en langues, c'est ton esprit qui prie directement, sans passer par le filtre de ton intelligence. Tu contournes les limitations de ton vocabulaire humain et de tes mots réfléchis.

Paul dit dans 1 Corinthiens 14:15 : "Je prierai par l'esprit, mais je prierai aussi avec l'intelligence ; je chanterai par l'esprit, mais je chanterai aussi avec l'intelligence."

- Laisse ton esprit s'exprimer en langues, sans essayer de comprendre
- Tu peux chanter en langues, parler en langues, ou même murmurer en langues
- Ne cherche pas à contrôler ou à comprendre ce qui sort – c'est ton esprit qui communique directement avec Dieu
- Parfois, après avoir adoré en langues, ton esprit sera tellement élevé que des paroles d'adoration en français jailliront naturellement

Par le soupir :
Parfois, ce qui sort de ton esprit c'est un soupir. Un soupir profond qui exprime ce que les mots ne peuvent pas dire. Romains 8:26 nous dit que l'Esprit lui-même intercède par des soupirs inexprimables. Un soupir d'amour, un soupir d'abandon, un soupir de reconnaissance – c'est aussi de l'adoration en esprit.

Par le gémissement :
Parfois aussi, ton esprit peut gémir devant Dieu. Un gémissement qui vient du plus profond de toi, une expression de ton cœur qui va au-delà des mots articulés.

L'important, c'est de laisser ton esprit libre de s'exprimer comme il veut dans ce moment :
- Tantôt ce sera le silence
- Tantôt ce sera le parler en langues
- Tantôt ce sera un soupir
- Tantôt ce sera un gémissement
- Parfois ce sera un mélange de tout cela

Ne force rien. Sois simplement disponible et laisse ton esprit communiquer avec l'Esprit de Dieu de la manière qui monte naturellement de l'intérieur.

Reconnais les moments de connexion spirituelle :
Quand tu adores (par le silence, les langues, les soupirs, le chant, la prière, l'écriture), sois attentif aux moments où tu sens que ton esprit touche l'Esprit de Dieu. C'est comme une chaleur intérieure, une paix profonde, une présence tangible. Ne force pas ces moments, mais apprends à les reconnaître et à y rester.

7. Pratique l'adoration en vérité

Adorer en vérité, c'est être authentique devant Dieu. C'est exprimer le ressenti réel de ton cœur.

Pratique concrète :

L'honnêteté radicale :
Refuse le mensonge de la performance spirituelle. Si tu es fatigué, dis-le. Si tu es en colère, exprime-le. Si tu doutes, partage-le. Si tu es joyeux, manifeste-le.

Dieu ne veut pas des acteurs. Il veut des cœurs vrais.

Exemple d'adoration en vérité dans la difficulté :
"Seigneur, je ne comprends pas pourquoi Tu as permis cela. Mon cœur est confus. Mais même dans ma confusion, je choisis de T'aimer. Je ne vais pas prétendre que tout va bien, mais je vais quand même déclarer que Tu es bon."

Exemple d'adoration en vérité dans la joie :
"Seigneur, mon cœur déborde de reconnaissance aujourd'hui ! Tu as fait tellement pour moi. Je suis tellement heureux de Te connaître. Je T'aime, je T'aime, je T'aime !"

Le journal d'adoration :
Garde un carnet où tu notes :
- Ce que tu découvres sur Dieu chaque jour
- Les moments où ton cœur a vraiment touché le cœur de Dieu
- Tes psaumes personnels
- Tes témoignages réactualisés
- Les noms de Dieu que tu découvres

Ce journal deviendra un trésor spirituel que tu reliras dans les moments de sécheresse.$edm$, $edm$- L'apprentissage de l'adoration suit trois étapes : nourrir le cœur, exprimer le cœur, adorer en esprit et en vérité.
- Première étape : remplir le cœur, car un cœur vide ne peut pas déborder. On se nourrit du plus grand commandement, de la Parole qui révèle qui Dieu est, et de ses témoignages personnels.
- Pour chaque témoignage, on donne à Dieu un nom qui correspond à ce qu'Il a fait.
- Deuxième étape : exprimer ce qui déborde, comme un psalmiste. On écrit ses propres psaumes, on adore à voix haute, on utilise différents canaux d'expression.
- On adore aussi au milieu des circonstances difficiles : on ne nie pas la douleur, mais on déclare quand même qui Dieu est.
- Troisième étape : adorer en esprit, en étant présent devant Dieu 15 à 20 minutes par jour, sans programme, par le silence, les langues, le soupir ou le gémissement, sans rien forcer.
- Adorer en vérité : l'honnêteté radicale, car Dieu ne veut pas des acteurs mais des cœurs vrais.
- Le journal d'adoration garde ce qu'on découvre de Dieu, ses psaumes, ses témoignages et les noms de Dieu.$edm$, $edm$Cette semaine, tu mets en œuvre tes trois étapes, dans l'ordre. Tu peux suivre ce rythme :

1. Jours 1 et 2 : nourrir le cœur. Médite le plus grand commandement, lis chaque jour un passage qui révèle qui Dieu est, et commence à écrire tes témoignages personnels.

2. Jours 3 et 4 : exprimer le cœur. Écris tes propres psaumes d'adoration, adore à voix haute, et choisis d'adorer au milieu d'une difficulté.

3. Jours 5 à 7 : adorer en esprit et en vérité. Consacre 15 à 20 minutes chaque jour à être présent devant Dieu, et pratique l'honnêteté radicale.

4. Pendant toute la semaine : tiens ton journal d'adoration. Note chaque jour ce que tu découvres de Dieu, tes psaumes, tes témoignages et les noms de Dieu.$edm$, $edm$✅ Acquis, je maîtrise bien : ...

⏳ En cours, je comprends mais je dois approfondir : ...

🔄 À travailler, je dois revenir dessus plus tard : ...

(Exemples de points à évaluer : nourrir mon cœur · écrire mes psaumes · adorer dans les difficultés · adorer en esprit · adorer en vérité · tenir mon journal d'adoration.)


==================================================
LA DESTINATION FINALE
==================================================

Cette semaine n'est qu'un commencement. L'adoration n'est pas une discipline à maîtriser, c'est une romance à vivre. C'est un voyage qui ne se termine jamais, parce qu'on ne finit jamais de découvrir les profondeurs de Celui qui est infini. Chaque jour de cette semaine peut devenir une ouverture vers une vie entière d'adoration.

Le but n'est pas de devenir un adorateur parfait, mais un adorateur vrai. Dieu ne cherche pas l'excellence de la forme, mais l'authenticité du fond. Il préfère un cœur brisé mais sincère à un cœur entier mais faux. Il préfère un soupir vrai à mille cantiques répétés mécaniquement.

Alors durant ces sept jours, laisse ton cœur apprendre à suraimer. Laisse l'amour pour Dieu exploser à l'intérieur jusqu'à ce qu'il déborde à l'extérieur. Découvre que l'adoration n'est pas ce que tu fais pour Dieu, mais ce que tu deviens devant Dieu.

Et quand cette semaine se terminera, que l'adoration ne s'arrête pas. Qu'elle devienne le rythme de ta respiration spirituelle, le battement de ton cœur en Christ, le parfum qui se dégage naturellement d'une vie amoureuse de Dieu.

Car c'est cela, finalement, qu'Il recherche : des cœurs qui L'aiment plus que tout, malgré tout, au-delà de tout. Des adorateurs en esprit et en vérité. Des cœurs qui ont appris à suraimer.$edm$, true, true),
('formation', 22, 5, 5, $edm$Savoir marcher avec Dieu$edm$, $edm$Qu'est-ce que marcher avec Dieu ?$edm$, $edm$À la fin de ce module, tu sauras :
- expliquer ce que signifie marcher avec Dieu, et en quoi cela diffère des actions pour réaliser sa destinée ;
- comprendre le concept de la marche : plusieurs pas, un rythme, une direction, un but ;
- citer les trois aspects fondamentaux de la marche avec Dieu ;
- comprendre que, dans la marche, c'est l'Esprit qui pose des pas à travers nous.$edm$, $edm$LA MARCHE AVEC DIEU

QU'EST-CE QUE MARCHER AVEC DIEU ?

La marche avec Dieu est bien différente des simples actions que nous posons pour réaliser notre destinée. La marche concerne avant tout notre manière d'être, et cette manière est directement liée à notre comportement.

Marcher avec Dieu, c'est marcher par Dieu. Nous savons tous que Dieu est esprit et parole, comme Jésus l'a déclaré en Jean 4:24 : « Dieu est esprit, et il faut que ceux qui l'adorent, l'adorent en esprit et en vérité. » Cela signifie donc que marcher avec Dieu, c'est marcher par sa Parole et marcher par son Esprit.

Cette marche va transformer notre manière d'être, c'est-à-dire notre comportement, notre caractère et notre personnalité. Nous serons immédiatement influencés par Dieu lui-même, par son Esprit et par sa Parole. Ainsi, lorsque nous parvenons à marcher avec Dieu, notre caractère et notre comportement se trouvent transformés. Nos manquements, notre façon de vivre sans règles, nos comportements excessifs, nos actions désordonnées et tous nos choix finissent par converger dans le sens de la marche avec Dieu.


COMPRENDRE LE CONCEPT DE LA MARCHE

Marcher, au sens large, c'est poser des pas avec Dieu. Cette image de la marche rappelle l'expérience d'Énoch dans Genèse 5:24 : « Énoch marcha avec Dieu, puis il ne fut plus, parce que Dieu le prit. » Dans chaque pas que nous posons, il y a tout un mouvement, tout un processus. Il y a la force avec laquelle nous posons le pas, il y a le timing du déplacement, il y a le rythme. On ne parle de marche que lorsqu'il y a plusieurs pas. S'il n'y a qu'un seul pas, ce n'est pas encore une marche.

Dans la marche, il y a le déplacement, il y a la rapidité ou le rythme du déplacement, et il y a aussi un objectif. On ne peut pas marcher avec Dieu sans avoir reçu de sa part une direction claire dans notre vie. Si nous marchons avec Dieu, c'est que nous avons une direction, un but à atteindre. Et cet aboutissement nécessite une manière particulière de marcher. C'est cette manière que Dieu nous recommande, c'est cette manière-là que Dieu recherche en nous, comme le prophète Michée l'a exprimé en Michée 6:8 : « On t'a fait connaître, ô homme, ce qui est bien ; et ce que l'Éternel demande de toi, c'est que tu pratiques la justice, que tu aimes la miséricorde, et que tu marches humblement avec ton Dieu. »


LES TROIS ASPECTS FONDAMENTAUX DE LA MARCHE AVEC DIEU

Premier aspect : L'information et la direction

La première chose, c'est l'information, le savoir, la raison pour laquelle nous devons marcher. Sans cette information, sans cette direction claire, sans cette boussole, nos actions ne changeront pas. Notre vie n'est pas motivée par quelque chose d'essentiel, par un but précis que Dieu aimerait nous communiquer. Proverbes 29:18 nous avertit : « Quand il n'y a pas de vision, le peuple est sans frein. »

Deuxième aspect : Marcher par sa Parole

La deuxième chose, c'est marcher selon sa Parole. Il s'agit de la manière dont il nous est recommandé de marcher selon sa Parole. Marcher selon la Parole de Dieu, c'est garder ses paroles, garder ses commandements. Mais les garder signifie les avoir dans son cœur, les avoir dans son âme, comme le Psaume 119:11 l'exprime : « Je serre ta parole dans mon cœur, afin de ne pas pécher contre toi. »

Troisième aspect : Marcher par son Esprit

La troisième chose, c'est marcher par son Esprit, car la Bible dit dans Zacharie 4:6 : « Ce n'est ni par la force, ni par la puissance, mais par mon Esprit, dit l'Éternel des armées. » Pour que toutes les paroles s'accomplissent, il faut l'Esprit. C'est l'Esprit qui donne la vie, comme Jésus l'a dit en Jean 6:63 : « C'est l'esprit qui vivifie ; la chair ne sert à rien. Les paroles que je vous ai dites sont esprit et vie. » Sans l'Esprit, nous ne pouvons rien, car il est avantageux qu'il soit présent pour que nous puissions marcher.

Ces trois aspects sont complémentaires. Le dernier aspect, qui concerne l'Esprit, nécessite que l'Esprit puisse agir à travers nous. Marcher avec Dieu n'est pas simplement dire : « J'ai l'Esprit et je marche parce que l'Esprit m'a orienté pour aller là-bas. » Non, c'est que même dans la marche, ce n'est pas nous qui marchons, c'est l'Esprit qui pose des pas à travers nous. C'est Dieu qui marche à travers nous, comme Paul l'a écrit en Galates 2:20 : « Ce n'est plus moi qui vis, c'est Christ qui vit en moi. »$edm$, $edm$- La marche avec Dieu est différente des actions posées pour réaliser sa destinée : elle concerne avant tout notre manière d'être, liée à notre comportement.
- Marcher avec Dieu, c'est marcher par Dieu : par Sa Parole et par Son Esprit.
- Cette marche transforme notre comportement, notre caractère et notre personnalité : nos manquements, nos excès et nos choix convergent dans le sens de la marche avec Dieu.
- Marcher, c'est poser des pas avec Dieu, comme Énoch. Il y a un mouvement, une force, un timing, un rythme. On ne parle de marche que lorsqu'il y a plusieurs pas.
- On ne peut pas marcher avec Dieu sans avoir reçu de Sa part une direction claire, un but à atteindre.
- Ce que Dieu demande (Michée 6:8) : pratiquer la justice, aimer la miséricorde, marcher humblement avec son Dieu.
- Trois aspects fondamentaux : l'information et la direction, marcher par Sa Parole, marcher par Son Esprit.
- Ces trois aspects sont complémentaires. Dans la marche, ce n'est pas nous qui marchons : c'est l'Esprit qui pose des pas à travers nous (Galates 2:20).$edm$, $edm$Cette semaine, tu poses les bases de ta marche.

1. Écris ta propre phrase. En une phrase, avec tes mots : « Marcher avec Dieu, pour moi, c'est... »

2. Note ta direction. Quelle direction claire Dieu t'a-t-Il donnée dans ta vie ? Écris-la. Si tu ne l'as pas encore, note-le honnêtement.

3. Choisis une parole à garder. Choisis un verset et serre-le dans ton cœur, comme le Psaume 119:11. Relis-le chaque jour.

4. Invite l'Esprit. Demande-Lui de poser Ses pas à travers toi dans ta journée.$edm$, $edm$✅ Acquis, je maîtrise bien : ...

⏳ En cours, je comprends mais je dois approfondir : ...

🔄 À travailler, je dois revenir dessus plus tard : ...

(Exemples de points à évaluer : marcher avec Dieu et manière d'être · le concept de la marche · l'information et la direction · marcher par la Parole · marcher par l'Esprit.)$edm$, false, true),
('formation', 23, 5, 5, $edm$Savoir marcher avec Dieu$edm$, $edm$Les premières conditions pour marcher avec Dieu$edm$, $edm$À la fin de ce module, tu sauras :
- expliquer pourquoi la soumission totale est la première condition pour marcher avec Dieu ;
- comprendre ce que signifie apprendre à dominer, plutôt qu'être influencé ;
- citer les trois choses à dominer : le péché, l'influence des ténèbres, les circonstances ;
- comprendre le lien entre la domination et la foi.$edm$, $edm$LES CONDITIONS POUR MARCHER AVEC DIEU

PREMIÈRE CONDITION : LA SOUMISSION TOTALE

Pour pouvoir marcher avec Dieu, il faut une soumission totale et entière. Le cœur de l'homme est rebelle et tortueux, comme Jérémie 17:9 le déclare : « Le cœur est tortueux par-dessus tout, et il est méchant : qui peut le connaître ? » C'est pourquoi le monde des ténèbres arrive à nous influencer. Pour marcher avec Dieu, nous devons être totalement soumis à lui, selon Jacques 4:7 : « Soumettez-vous donc à Dieu ; résistez au diable, et il fuira loin de vous. »


DEUXIÈME CONDITION : APPRENDRE À DOMINER

Il faut apprendre à dominer. Nous devons refuser la place de celui qui est influencé et prendre la place de celui qui influence.

DOMINER SUR LE PÉCHÉ

La plupart du temps, cela concerne la vie de péché. Il y a des passages dans la Bible qui nous informent que le péché se tient à notre porte et que nous devons le dominer. Genèse 4:7 dit à Caïn : « Si tu agis bien, ne seras-tu pas agréé ? Mais si tu n'agis pas bien, le péché se couche à ta porte, et ses désirs se portent vers toi : mais toi, domine sur lui. »

Mais lorsque nous acceptons que le péché a une influence importante sur nous, lorsque nous admettons : « C'est trop dur cette histoire, Dieu sait bien que c'est comme ça », alors nous laissons le péché prendre la place du dominateur. Nous admettons que nous ne sommes pas forts.

Il faut comprendre que lorsque nous sommes soumis à l'Esprit de Dieu, nous avons la domination sur toute chose. C'est pourquoi la première chose que nous devons dominer, c'est d'abord notre chair. Romains 8:13 nous encourage : « Si vous vivez selon la chair, vous mourrez ; mais si par l'Esprit vous faites mourir les actions du corps, vous vivrez. »

Je suis l'auteur de ma vie, je suis l'acteur, c'est moi qui joue. Ce n'est pas le film qui se joue de moi, je joue mon rôle. Je suis destiné à jouer un rôle spécifique, pas à être influencé. Je suis l'acteur de ma vie, je suis le scénariste de mon histoire. Même si je sais où je vais, c'est moi qui domine, c'est moi qui décide. C'est moi avec Dieu qui écris l'histoire. Lorsque Dieu m'informe, ce n'est pas l'histoire qui m'écrit, ce n'est pas l'influence du péché qui m'écrit.

DOMINER L'INFLUENCE DES TÉNÈBRES

La deuxième chose à dominer, c'est l'influence des ténèbres. Peu importe la situation que tu vis, il faut que la première chose qui résonne en toi soit que tu domines les ténèbres. Peu importe les problèmes que tu as, peu importe la situation que tu traverses, peu importe ce que tu vis, tu dois comprendre à travers la parole de Christ que tu as reçu tout pouvoir pour marcher. Luc 10:19 déclare : « Voici, je vous ai donné le pouvoir de marcher sur les serpents et les scorpions, et sur toute la puissance de l'ennemi ; et rien ne pourra vous nuire. »

Même si tu ne poses pas encore l'acte de marcher, n'accepte pas d'être dominé. Ces voix qui parlent ne sont pas tes voix. Ta voix doit parler plus fort que la voix des ténèbres. La voix de Dieu doit parler encore plus fort que la voix de ce qui t'influence. La source de l'énergie, de l'influence, c'est toi. Tu es l'être supérieur. Les ténèbres qui t'influencent sont inférieures, car c'est toi qui appartiens au royaume le plus puissant. Alors prends la place du dominateur. 1 Jean 4:4 nous rappelle : « Celui qui est en vous est plus grand que celui qui est dans le monde. » C'est dans ton esprit, dans ton cœur, dans ta manière d'être, dans ta foi. C'est cela le deuxième aspect du fait d'être un dominateur.

DOMINER SUR TES CIRCONSTANCES

Le troisième aspect, c'est dominer sur tes circonstances. Refuse d'être l'objet de ta situation, mais fais plutôt de ta situation un objet de gloire. David a vu à travers Goliath une opportunité. En 1 Samuel 17:46-47, David déclara face au géant : « Aujourd'hui l'Éternel te livrera entre mes mains... et toute la terre saura qu'Israël a un Dieu. » Il faut qu'à chaque chose que tu vois, tu voies une opportunité, comme Josué l'avait aussi perçu à travers Caleb qu'il a vu. En effet, dans Nombres 13:30, alors que les autres espions voyaient les géants et les obstacles, Caleb déclara : « Montons, emparons-nous du pays, nous y serons vainqueurs ! » Et Josué se joignit à lui dans cette vision de foi, refusant de voir les circonstances comme des obstacles insurmontables.

Ne te mets jamais en dessous des circonstances que tu vis. Peu importe la pauvreté, peu importe les souffrances, peu importe les calomnies, peu importe les échecs, peu importe les rejets, peu importe les dettes. Assieds-toi et dis : « Dieu m'a mis au-dessus de tout cela, car celui qui vient d'en haut est au-dessus de tout. Je suis au-dessus de toutes ces choses. » Jean 3:31 affirme : « Celui qui vient d'en haut est au-dessus de tous. »

Tant que tu ne mets pas ce fonctionnement dans ta foi, tu ne vas pas vivre ta foi, mais tu vas subir ta situation. Le doute vis-à-vis de Dieu sera grand, alors que pour marcher avec Dieu, il faut lui être agréable par la foi. Hébreux 11:6 nous enseigne : « Or, sans la foi, il est impossible de lui être agréable ; car il faut que celui qui s'approche de Dieu croie que Dieu existe, et qu'il est le rémunérateur de ceux qui le cherchent. »$edm$, $edm$- Première condition : la soumission totale et entière à Dieu (Jacques 4:7). Le cœur est rebelle et tortueux, et le monde des ténèbres arrive à nous influencer.
- Deuxième condition : apprendre à dominer, c'est-à-dire refuser la place de celui qui est influencé et prendre celle de celui qui influence.
- Dominer sur le péché : le péché se couche à notre porte, mais nous devons le dominer (Genèse 4:7). Accepter qu'il est trop fort, c'est lui laisser la place du dominateur.
- Soumis à l'Esprit de Dieu, nous avons la domination sur toute chose, et d'abord sur notre chair (Romains 8:13).
- C'est moi avec Dieu qui écris l'histoire : ni l'histoire ni l'influence du péché ne m'écrivent.
- Dominer l'influence des ténèbres : tu as reçu tout pouvoir (Luc 10:19). Ta voix, et la voix de Dieu, doivent parler plus fort que celle des ténèbres (1 Jean 4:4).
- Dominer sur tes circonstances : refuser d'en être l'objet, en faire un objet de gloire. David a vu une opportunité en Goliath ; Caleb et Josué ont refusé de voir des obstacles insurmontables.
- Sans la foi dans ce fonctionnement, on subit sa situation. Il faut être agréable à Dieu par la foi (Hébreux 11:6).$edm$, $edm$Cette semaine, tu apprends à dominer.

1. Soumets-toi. Prends un moment pour te soumettre à Dieu dans une prière personnelle, avec tes mots, en reprenant Jacques 4:7.

2. Repère où tu es influencé. Note une chose pour chaque domaine : un péché qui te domine, une influence des ténèbres que tu perçois, une circonstance sous laquelle tu te sens écrasé.

3. Prends la place de celui qui influence. À voix haute, déclare pour chaque chose notée ce que dit la Parole (par exemple 1 Jean 4:4, Luc 10:19, Jean 3:31).

4. Regarde une circonstance autrement. Choisis une circonstance difficile et cherche l'opportunité qu'elle contient, comme David face à Goliath.$edm$, $edm$✅ Acquis, je maîtrise bien : ...

⏳ En cours, je comprends mais je dois approfondir : ...

🔄 À travailler, je dois revenir dessus plus tard : ...

(Exemples de points à évaluer : la soumission totale · dominer sur le péché · dominer l'influence des ténèbres · dominer sur mes circonstances · le lien avec la foi.)$edm$, false, true),
('formation', 24, 5, 5, $edm$Savoir marcher avec Dieu$edm$, $edm$Les autres conditions, et ce que produit la marche$edm$, $edm$À la fin de ce module, tu sauras :
- expliquer pourquoi marcher avec Dieu exige d'aimer son prochain ;
- expliquer pourquoi il faut rester sensible à l'Esprit ;
- comprendre ce que signifie donner toutes les commandes de sa vie à Dieu ;
- décrire l'intelligence spirituelle et la libération de la peur et de la timidité qui découlent de la marche.$edm$, $edm$LES CONDITIONS POUR MARCHER AVEC DIEU (SUITE)

TROISIÈME CONDITION : DÉVELOPPER L'AMOUR POUR SON PROCHAIN

Lorsque tu te places au-dessus de tes circonstances, il faut maintenant, au milieu des hommes, développer l'amour. Le plus grand commandement nous demande d'aimer notre prochain comme nous-mêmes, selon Matthieu 22:39 : « Tu aimeras ton prochain comme toi-même. » On ne domine pas sur son prochain, on aime son prochain comme soi-même. C'est une règle importante dans la marche avec Dieu.

Il faut vivre sans intérêts cupides, sans égocentrisme, sans orgueil. Il faut développer l'humilité du cœur. Dieu souhaite que nous puissions la développer, et cela va se faire à travers l'amour que nous portons à notre prochain, parce que nous développons l'amour pour Dieu. 1 Jean 4:20 nous challenge : « Si quelqu'un dit : J'aime Dieu, et qu'il haïsse son frère, c'est un menteur ; car celui qui n'aime pas son frère qu'il voit, comment peut-il aimer Dieu qu'il ne voit pas ? »


QUATRIÈME CONDITION : RESTER SENSIBLE À L'ESPRIT

Ce qui vient en dernier, c'est de toujours rester sensible à l'Esprit. Lorsqu'on n'est pas sensible, on devient égocentrique. Lorsqu'on n'est pas sensible, on devient orgueilleux. Lorsqu'on n'est pas sensible, on n'a pas la patience, et le fruit de l'Esprit n'a pas de place en nous. Galates 5:22-23 énumère ce fruit : « Mais le fruit de l'Esprit, c'est l'amour, la joie, la paix, la patience, la bonté, la bénignité, la fidélité, la douceur, la tempérance. »

Il faut prendre la peine simplement de s'asseoir et dire à Dieu : « Seigneur, je te laisse toute la place. Pose tes pas à travers moi. »


DONNER TOUTES LES COMMANDES À DIEU

Marcher avec Dieu, c'est donner place au Saint-Esprit. Marcher avec Dieu, c'est donner toutes les commandes de notre vie à Dieu. Si nous ne donnons pas toutes les commandes de notre vie à Dieu, nous allons vivre sous l'influence d'un esprit ou d'esprits que nous commanderons, et qui vont injecter en nous des systèmes de pensées égarées, des systèmes de pensées de péché, des systèmes de justification de nous-mêmes, des systèmes qui nourrissent notre nature charnelle.

En revanche, lorsque nous sommes sous l'influence et sous les commandes du Saint-Esprit, nous sommes brisés dans notre état et nous devenons des personnes humbles. Dieu nous enseigne alors, comme Jésus l'a promis en Jean 14:26 : « Mais le consolateur, l'Esprit Saint, que le Père enverra en mon nom, vous enseignera toutes choses, et vous rappellera tout ce que je vous ai dit. »


L'INTELLIGENCE SPIRITUELLE

Un autre point très important : pendant qu'une influence maléfique t'enseigne des systèmes de pensées égarées, pendant que tu marches avec Dieu, Dieu te communique une intelligence spirituelle. Dans cette intelligence, tu auras, selon le livre des Proverbes, la connaissance, le discernement et la réflexion. Proverbes 2:6 affirme : « Car l'Éternel donne la sagesse ; de sa bouche sortent la connaissance et l'intelligence. » Ceci couronne une sagesse profonde.

Alors toutes tes actions seront faites avec la sagesse de l'Esprit. C'est pourquoi la Bible nous dit dans 2 Timothée 1:7 que nous avons reçu « un esprit de force, d'amour et de sagesse ». Voici les commandes du Saint-Esprit lorsque nous nous laissons entièrement plonger dans sa personnalité.


LA LIBÉRATION DE LA PEUR ET DE LA TIMIDITÉ

La timidité n'a plus de place. La peur n'a plus de place. Vivre une vie de peur n'a plus de place. L'inquiétude n'a plus de place. Le doute n'a plus de place.

Même quand tu es faible face à un péché, l'Esprit te dit que tu n'es pas timide, que tu es fort, et que ce péché n'est pas au-dessus de toi. Avec le temps, avec l'écoute du Saint-Esprit, avec le soutien de Dieu dans ta vie, tu parviendras à sortir de toute forme d'influence, que ce soit charnelle, spirituelle ou circonstancielle. Tu t'en sortiras. Philippiens 4:13 nous encourage : « Je puis tout par celui qui me fortifie. »$edm$, $edm$- Troisième condition : développer l'amour pour son prochain (Matthieu 22:39). On ne domine pas sur son prochain, on l'aime comme soi-même.
- Il faut vivre sans intérêts cupides, sans égocentrisme, sans orgueil, avec l'humilité du cœur. Celui qui n'aime pas son frère ne peut pas aimer Dieu (1 Jean 4:20).
- Quatrième condition : rester sensible à l'Esprit. Sans sensibilité, on devient égocentrique, orgueilleux, sans patience, et le fruit de l'Esprit n'a pas de place en nous (Galates 5:22-23).
- Il faut dire à Dieu : « Seigneur, je te laisse toute la place. Pose tes pas à travers moi. »
- Marcher avec Dieu, c'est donner place au Saint-Esprit et lui donner toutes les commandes de notre vie.
- Sans cela, on vit sous l'influence d'esprits que nous commandons, qui injectent des systèmes de pensées égarées, de péché et de justification de soi.
- Sous les commandes du Saint-Esprit, nous sommes brisés, humbles, et Dieu nous enseigne (Jean 14:26).
- Dieu communique une intelligence spirituelle : la connaissance, le discernement, la réflexion, et la sagesse de l'Esprit dans toutes les actions (Proverbes 2:6, 2 Timothée 1:7).
- La timidité, la peur, l'inquiétude et le doute n'ont plus de place. « Je puis tout par celui qui me fortifie » (Philippiens 4:13).$edm$, $edm$Cette semaine, tu donnes les commandes et tu aimes.

1. Aime sans intérêt. Choisis une personne et pose un acte d'amour envers elle, sans rien attendre en retour.

2. Donne la place à l'Esprit. Assieds-toi quelques instants et dis à Dieu avec tes mots : « Seigneur, je te laisse toute la place. Pose tes pas à travers moi. »

3. Repère ce qui paralyse. Note une peur, une inquiétude ou un doute qui te retient, et déclare sur elle Philippiens 4:13.

4. Observe le fruit. Relis Galates 5:22-23 et note quels éléments du fruit de l'Esprit sont présents dans ta vie cette semaine, et lesquels manquent.$edm$, $edm$✅ Acquis, je maîtrise bien : ...

⏳ En cours, je comprends mais je dois approfondir : ...

🔄 À travailler, je dois revenir dessus plus tard : ...

(Exemples de points à évaluer : l'amour du prochain · rester sensible à l'Esprit · donner toutes les commandes à Dieu · l'intelligence spirituelle · la libération de la peur et de la timidité.)$edm$, false, true),
('formation', 25, 5, 5, $edm$Savoir marcher avec Dieu$edm$, $edm$Ce qui nous empêche de marcher avec Dieu$edm$, $edm$À la fin de ce module, tu sauras :
- reconnaître l'orgueil comme premier obstacle à la marche avec Dieu ;
- citer les œuvres de la chair qui empêchent de marcher ;
- comprendre la nécessité d'être conduit par l'Esprit ;
- faire la différence entre ce qui empêche de marcher (la chair) et ce qui permet de marcher (le fruit de l'Esprit).$edm$, $edm$CE QUI NOUS EMPÊCHE DE MARCHER AVEC DIEU

Dès le départ, je disais que lorsqu'on marche avec Dieu, ce n'est pas simplement dans le but d'arriver à une destination. Mais de la même manière que la marche concerne notre caractère et notre comportement positifs, il existe également des comportements négatifs qui nous empêcheront de pouvoir marcher avec Dieu.


L'ORGUEIL, PREMIER OBSTACLE

C'est pourquoi la Bible dit dans Jacques 4:6 : « Dieu résiste aux orgueilleux, mais il fait grâce aux humbles. » Ce qui pourrait d'abord nous empêcher de pouvoir marcher avec Dieu, c'est lorsque nous traçons nous-mêmes, dans le cadre de notre vie, un objectif propre et que nous traçons nos propres voies. Si c'est là notre comportement, c'est de l'orgueil.


LES AUTRES OBSTACLES : LES ŒUVRES DE LA CHAIR

Il y a l'arrogance, il y a la cupidité, la vanité, les envies. Les œuvres de la chair ne nous permettront pas de pouvoir marcher avec Dieu. Galates 5:19-21 les énumère clairement : « Or, les œuvres de la chair sont manifestes, ce sont : l'adultère, l'impudicité, l'impureté, la dissolution, l'idolâtrie, la magie, les inimitiés, les querelles, les jalousies, les animosités, les disputes, les divisions, les sectes, l'envie, l'ivrognerie, les excès de table, et les choses semblables. Je vous dis d'avance, comme je vous l'ai déjà dit, que ceux qui commettent de telles choses n'hériteront point le royaume de Dieu. »

Voici l'ennemi premier de la marche avec Dieu.


LA NÉCESSITÉ D'ÊTRE CONDUIT

C'est pourquoi la Bible nous recommande d'être conduits. Romains 8:14 déclare : « Car tous ceux qui sont conduits par l'Esprit de Dieu sont fils de Dieu. » Être conduit, c'est Dieu qui te conduit. L'Esprit marche à travers toi. Être conduit, c'est comme un véhicule qui a besoin d'un chauffeur pour quitter un point A et aller vers un point B. Le déplacement, c'est une forme de marche.

Mais tant que nous allons vouloir nous diriger nous-mêmes, nous ne serons pas capables de marcher avec Dieu. Il faut apprendre, selon toutes les conditions qui ont été données.


LA CHAIR VERSUS LE FRUIT DE L'ESPRIT

Donc, ce qui nous empêche de marcher avec Dieu, comme je l'ai dit, est en rapport avec la chair. Et ce qui nous permet de marcher avec Dieu est en rapport avec le fruit de l'Esprit.

Galates 5:22-23 établit cette opposition : « Mais le fruit de l'Esprit, c'est l'amour, la joie, la paix, la patience, la bonté, la bénignité, la fidélité, la douceur, la tempérance. » Et le verset 25 ajoute : « Si nous vivons par l'Esprit, marchons aussi selon l'Esprit. »$edm$, $edm$- La marche concerne notre caractère et notre comportement : il existe des comportements négatifs qui nous empêchent de marcher avec Dieu.
- Le premier obstacle est l'orgueil : « Dieu résiste aux orgueilleux, mais il fait grâce aux humbles » (Jacques 4:6). Tracer soi-même un objectif propre et ses propres voies, c'est de l'orgueil.
- Les autres obstacles sont les œuvres de la chair : l'arrogance, la cupidité, la vanité, les envies, et celles que Galates 5:19-21 énumère.
- Les œuvres de la chair sont l'ennemi premier de la marche avec Dieu.
- La Bible recommande d'être conduit : tous ceux qui sont conduits par l'Esprit de Dieu sont fils de Dieu (Romains 8:14).
- Être conduit, c'est Dieu qui te conduit : l'Esprit marche à travers toi, comme un véhicule qui a besoin d'un chauffeur.
- Tant qu'on veut se diriger soi-même, on ne peut pas marcher avec Dieu.
- Ce qui empêche de marcher est en rapport avec la chair. Ce qui permet de marcher est en rapport avec le fruit de l'Esprit.
- « Si nous vivons par l'Esprit, marchons aussi selon l'Esprit » (Galates 5:25).$edm$, $edm$Cette semaine, tu examines ta marche, honnêtement, devant Dieu.

1. Repère l'orgueil. Demande-toi : où est-ce que je trace moi-même mes objectifs et mes voies, sans consulter Dieu ? Note une situation précise.

2. Repère les œuvres de la chair. Relis la liste de Galates 5:19-21. Note ce que tu reconnais dans ta vie, puis présente-le à Dieu.

3. Cultive un fruit. Parmi le fruit de l'Esprit (Galates 5:22-23), choisis un élément à cultiver cette semaine et note une action concrète.

4. Laisse-toi conduire. Avant chaque décision de ta journée, demande à Dieu de te conduire et de marcher à travers toi.$edm$, $edm$✅ Acquis, je maîtrise bien : ...

⏳ En cours, je comprends mais je dois approfondir : ...

🔄 À travailler, je dois revenir dessus plus tard : ...

(Exemples de points à évaluer : l'orgueil comme premier obstacle · les œuvres de la chair · la nécessité d'être conduit · la chair et le fruit de l'Esprit · ma marche cette semaine.)


==================================================
CONCLUSION
==================================================

C'est donc cela, marcher avec Dieu.$edm$, true, true),
('formation', 26, 6, 6, $edm$Savoir agir et prospérer avec Dieu$edm$, $edm$Les fondements de l'action$edm$, $edm$À la fin de ce module, tu sauras :
- citer les deux sources de l'action, et celle qui est prioritaire ;
- citer les quatre aspects indispensables pour agir avec Dieu, révélés dans Romains 12:1-2 ;
- expliquer ce que chaque aspect apporte, et ce qui manque quand il est absent ;
- appliquer la méthode des quatre questions avant d'agir.$edm$, $edm$L'ACTION ET LA PROSPÉRITÉ AVEC DIEU

LES FONDEMENTS DE L'ACTION

Les deux sources de l'action

L'action dans notre vie ne se déclenche que par deux choses fondamentales :

La première : la vérité - le rêve divin
C'est la vision que Dieu a pour nous, Son plan céleste, ce qu'Il a prévu depuis toujours pour notre destinée. C'est cette dimension spirituelle qui nous inspire et nous pousse à agir selon les desseins divins.

La seconde : la réalité - la nécessité vitale
Ce sont nos besoins concrets, les impératifs de la vie quotidienne, les situations qui exigent une réponse immédiate. C'est la dimension terrestre de notre existence.

Ces deux types d'actions sont d'une importance capitale. C'est pourquoi Christ, le sachant parfaitement, va nous faire comprendre que de ces deux aspects, il y a un aspect prioritaire et l'autre secondaire. C'est ce qu'Il enseigne dans Matthieu 6:33 : "Cherchez premièrement le royaume et la justice de Dieu; et toutes ces choses vous seront données par-dessus."

Notre vie véritable se trouve dans la quête du royaume dans lequel siège le royaume de Dieu. Le spirituel vient avant le matériel, toujours.


LES QUATRE ASPECTS INDISPENSABLES POUR AGIR AVEC DIEU

Pour agir véritablement avec Dieu, il n'y a pas d'action sans ces quatre aspects fondamentaux. Ces quatre aspects sont révélés dans Romains 12:1-2 qui dit : "Je vous exhorte donc, frères, par les compassions de Dieu, à offrir vos corps comme un sacrifice vivant, saint, agréable à Dieu, ce qui sera de votre part un culte raisonnable. Ne vous conformez pas au siècle présent, mais soyez transformés par le renouvellement de l'intelligence, afin que vous discerniez quelle est la volonté de Dieu, ce qui est bon, agréable et parfait."

PREMIER ASPECT : LA VOLONTÉ DE DIEU

"Afin que vous discerniez quelle est la VOLONTÉ de Dieu..."

Qu'est-ce que la volonté de Dieu ?

La volonté de Dieu, c'est Son désir, Son intention, ce qu'Il veut voir s'accomplir. C'est la direction générale qu'Il a établie pour l'humanité et pour chaque individu en particulier.

La volonté de Dieu, nous la connaissons tous en tant qu'enfants de Dieu. Elle est révélée dans Sa Parole :
- Qu'aucun ne périsse, mais que tous viennent à la repentance (2 Pierre 3:9)
- Que nous soyons saints comme Il est saint (1 Pierre 1:16)
- Que nous portions du fruit qui demeure (Jean 15:16)
- Que nous vivions dans la sanctification (1 Thessaloniciens 4:3)
- Que nous rendions grâces en toutes choses (1 Thessaloniciens 5:18)

Mais la volonté de Dieu, c'est aussi Sa volonté spécifique pour ta vie personnelle - ton appel unique, ta mission particulière, ta destinée propre. C'est pourquoi il faut la discerner, c'est-à-dire la découvrir, la percevoir clairement pour ton cas précis.

Sans discerner la volonté de Dieu, on agit dans le vague, sans direction claire. On peut être actif sans être efficace, bouger sans avancer dans le bon sens.

Comment discerner la volonté de Dieu ? Par le renouvellement de l'intelligence mentionné dans le verset. C'est-à-dire en changeant notre façon de penser, en alignant notre pensée sur celle de Dieu à travers Sa Parole, la prière, et la communion avec le Saint-Esprit.

DEUXIÈME ASPECT : CE QUI EST BON

"...ce qui est BON..."

Qu'est-ce qui est bon ?

Nous savons tous ce que nous pouvons poser comme actes. Nous savons qu'il y a des choses bien à faire. Mais ce qui est véritablement BON, ce sont les projets de Dieu, Ses plans spécifiques pour nous.

Il y a une différence entre ce que nous voulons faire et ce qui est bon selon Dieu :
- Nous pouvons avoir nos propres idées, nos propres projets
- Mais ce qui est BON, c'est ce que Dieu recommande, ce qu'Il dit de faire

Exemple concret : Tu peux avoir le projet de lancer une entreprise dans un domaine particulier qui te plaît. Mais quand tu consultes Dieu, Il te dit plutôt de te lancer dans un autre secteur que tu n'avais pas envisagé. Ce que Dieu recommande, c'est ça qui est BON pour toi.

Ou encore : Tu peux penser qu'il est temps de te marier maintenant. Mais Dieu te dit d'attendre encore un peu, de te préparer davantage. Ce que Dieu recommande - attendre - c'est ça qui est BON pour toi à ce moment précis.

Le BON, c'est ce que Dieu recommande comme projet spécifique - pas nos propres idées, mais Ses projets pour nous.

Pourquoi est-ce crucial ? Parce qu'on peut avoir de bonnes intentions, de beaux projets personnels, mais si ce ne sont pas les projets que Dieu recommande, on va s'épuiser sans porter de fruits durables.

Ce qui est BON, ce sont les œuvres que Dieu a préparées d'avance pour que nous les pratiquions (Éphésiens 2:10). C'est ce que Dieu recommande spécifiquement pour toi, pas ce que tu as imaginé toi-même.

Sans identifier ce qui est bon - ce que Dieu recommande - on risque de poursuivre nos propres projets au lieu des Siens.

TROISIÈME ASPECT : CE QUI EST AGRÉABLE

"...ce qui est AGRÉABLE..."

Qu'est-ce qui nous rend agréables à Dieu ? C'est la FOI.

Hébreux 11:6 nous dit clairement : "Or sans la foi il est impossible de lui être agréable; car il faut que celui qui s'approche de Dieu croie que Dieu existe, et qu'il est le rémunérateur de ceux qui le cherchent."

La foi, c'est ce qui plaît à Dieu, ce qui le satisfait, ce qui lui fait plaisir. Pourquoi ? Parce que la foi est la démonstration de notre confiance totale en Lui.

La foi comme aspect indispensable de l'action

Vous pouvez connaître la volonté de Dieu. Vous pouvez identifier les bons projets qu'Il a pour vous. Mais sans la foi, vous ne passerez jamais à l'action.

La foi, c'est :
- Croire que Dieu peut accomplir ce qu'Il a promis
- Croire que vous êtes capable en Lui de faire ce qu'Il vous appelle à faire
- Croire que les ressources viendront quand vous obéirez
- Croire contre toute apparence contraire

La foi rend votre action agréable à Dieu. Même si vous faites des erreurs en chemin, même si vous tâtonnez, si c'est fait avec foi, cela plaît à Dieu parce que vous Lui faites confiance.

Sans la foi, pas d'action véritable. Beaucoup connaissent la volonté de Dieu. Beaucoup ont identifié les bons projets. Mais ils n'agissent pas parce qu'ils manquent de foi. Ils doutent :
- "Est-ce que j'en suis capable ?"
- "Et si j'échoue ?"
- "Les ressources viendront-elles ?"
- "Que vont dire les gens ?"

L'action avec Dieu nécessite la foi - ce qui nous rend agréables à Ses yeux. C'est la foi qui nous fait passer du projet identifié à l'action concrète.

QUATRIÈME ASPECT : CE QUI EST PARFAIT

"...ce qui est PARFAIT."

Qu'est-ce qui nous rend parfaits ? C'est l'AMOUR.

1 Jean 4:18 déclare : "La crainte n'est pas dans l'amour, mais l'amour parfait bannit la crainte."

Colossiens 3:14 ajoute : "Mais par-dessus toutes ces choses revêtez-vous de la charité (l'amour), qui est le lien de la perfection."

L'amour, c'est ce qui nous amène à la perfection, à la maturité complète. Pourquoi ? Parce que l'amour est la nature même de Dieu (1 Jean 4:8), et agir dans l'amour, c'est agir comme Dieu agit.

L'amour comme perfection de l'action

Vous pouvez connaître la volonté de Dieu, identifier les bons projets, agir avec foi - mais si l'amour n'est pas la motivation, l'action sera imparfaite, incomplète.

1 Corinthiens 13:1-3 est clair : "Quand je parlerais les langues des hommes et des anges, si je n'ai pas la charité (l'amour), je suis un airain qui résonne, ou une cymbale qui retentit. Et quand j'aurais le don de prophétie, la science de tous les mystères et toute la connaissance, quand j'aurais même toute la foi jusqu'à transporter des montagnes, si je n'ai pas la charité (l'amour), je ne suis rien. Et quand je distribuerais tous mes biens pour la nourriture des pauvres, quand je livrerais même mon corps pour être brûlé, si je n'ai pas la charité (l'amour), cela ne me sert de rien."

L'amour perfectionne tout :
- Il purifie nos motivations
- Il nous fait persévérer quand c'est difficile
- Il nous garde de l'orgueil quand nous réussissons
- Il nous fait servir sans attendre de retour
- Il nous rend patients avec les autres dans le processus
- Il nous empêche d'écraser les autres pour accomplir nos objectifs

Sans l'amour, même les actions faites avec foi dans les bons projets de Dieu peuvent devenir destructrices. On peut accomplir la volonté de Dieu avec un cœur dur, blesser les gens en chemin, et finir amer.

L'amour, c'est ce qui rend l'action PARFAITE - complète, mature, équilibrée, durable, bénie.

LA SYNTHÈSE DES QUATRE ASPECTS

Sans la VOLONTÉ DE DIEU : Vous ne savez pas où aller, vous n'avez pas de direction.

Sans les BONS PROJETS (ce qui est bon) : Vous pouvez connaître la volonté générale de Dieu sans jamais identifier votre mission spécifique, vos œuvres préparées d'avance.

Sans la FOI (ce qui est agréable) : Vous ne passerez jamais à l'action, vous resterez paralysé par la peur et le doute, même en connaissant la volonté et les projets.

Sans l'AMOUR (ce qui est parfait) : Votre action sera imparfaite, potentiellement destructrice, égoïste, et finalement vaine même si vous accomplissez de grandes choses.

Ces quatre aspects fonctionnent ensemble :
1. DISCERNER LA VOLONTÉ DE DIEU (Direction)
2. IDENTIFIER CE QUI EST BON (Les projets que Dieu recommande)
3. AGIR AVEC FOI (Ce qui est agréable à Dieu)
4. DANS L'AMOUR (Ce qui rend l'action parfaite)$edm$, $edm$- L'action se déclenche par deux sources : la vérité (le rêve divin) et la réalité (la nécessité vitale).
- L'une est prioritaire, l'autre secondaire : « Cherchez premièrement le royaume et la justice de Dieu » (Matthieu 6:33). Le spirituel vient avant le matériel, toujours.
- Il n'y a pas d'action avec Dieu sans les quatre aspects de Romains 12:1-2 : la volonté de Dieu, ce qui est bon, ce qui est agréable, ce qui est parfait.
- La volonté de Dieu : générale, révélée dans la Parole, et spécifique pour chacun. Il faut la discerner par le renouvellement de l'intelligence.
- Ce qui est bon : les projets que Dieu recommande, non nos propres idées.
- Ce qui est agréable : la foi, sans laquelle on ne passe jamais à l'action.
- Ce qui est parfait : l'amour, qui purifie les motivations et rend l'action complète et durable.
- Sans volonté de Dieu : pas de direction. Sans bons projets : pas de mission précise. Sans foi : pas d'action. Sans amour : action imparfaite, potentiellement destructrice.
- La méthode des quatre questions applique ces quatre aspects avant d'agir.$edm$, $edm$APPLICATION PRATIQUE SIMPLE

LA MÉTHODE DES 4 QUESTIONS AVANT D'AGIR

Voici une pratique très simple que tout le monde peut appliquer immédiatement :

Avant de prendre une décision importante ou de lancer un projet, arrête-toi et pose-toi ces 4 questions :

1. Est-ce la volonté de Dieu ?
Prie et demande : "Seigneur, est-ce que tu veux que je fasse ça ?"

2. Est-ce le bon projet que Dieu recommande ?
Demande : "Seigneur, est-ce TOI qui me dis de faire exactement ça, ou c'est juste mon idée ?"

3. Est-ce que j'ai la foi pour le faire ?
Sois honnête : "Est-ce que je crois vraiment que Dieu va m'aider ?"

4. Pourquoi je veux faire ça ? Est-ce par amour ?
Examine ton cœur : "C'est pour ma gloire ou pour la gloire de Dieu et le bien des autres ?"

C'EST TOUT.

Si tu as les 4 réponses positives → Agis avec confiance.

Si une réponse est négative → Attends, prie encore, ou change de direction.$edm$, $edm$✅ Acquis, je maîtrise bien : ...

⏳ En cours, je comprends mais je dois approfondir : ...

🔄 À travailler, je dois revenir dessus plus tard : ...

(Exemples de points à évaluer : les deux sources de l'action · la volonté de Dieu · ce qui est bon · la foi · l'amour · la méthode des 4 questions.)$edm$, false, true),
('formation', 27, 6, 6, $edm$Savoir agir et prospérer avec Dieu$edm$, $edm$La consultation divine$edm$, $edm$À la fin de ce module, tu sauras :
- expliquer ce qu'est le pragmatisme spirituel ;
- expliquer pourquoi la consultation de Dieu est vitale, et non optionnelle ;
- comprendre que la victoire générale ne dispense pas de consulter Dieu pour chaque action particulière ;
- reconnaître l'ennemi de la consultation : nos émotions partiales.$edm$, $edm$LE PRAGMATISME SPIRITUEL : VIVRE LA VÉRITÉ REÇUE

La vie réelle nécessite un pragmatisme de la vérité reçue dans notre vie à travers la volonté de Dieu et Ses projets. Il ne s'agit pas seulement de croire, mais de vivre concrètement ce que Dieu nous révèle.

Il est absolument important d'avoir un cœur entièrement confiant en Dieu afin de communier avec Lui. Pourquoi ? Parce qu'agir avec Dieu nécessite un savoir, un ensemble d'informations sur plusieurs niveaux :
- Ce qui est (la réalité présente)
- Pourquoi cela est ainsi (les raisons divines)
- Ce qui a été (le passé et ses leçons)
- Ce qui adviendra (l'avenir et ses conséquences)


LE PRINCIPE CENTRAL : LA CONSULTATION DIVINE

Pourquoi consulter Dieu ?

L'action nécessite donc impérativement la consultation de Dieu. Ce n'est pas optionnel, c'est vital.

En toute chose à mener, il faut avoir la sensibilité dans le cœur de consulter Dieu. Il faut savoir comment sera la chose, comment mener l'action, quelles seront les portées de l'action, ses effets positifs ou négatifs, et même l'avenir qui se trouve dans ladite action à mener.

Notre position de victoire

En tant qu'enfant de Dieu, nous sommes déjà victorieux - c'est acquis. Mais nous devons avoir l'information confirmant ladite victoire selon l'acte spécifique à poser. La victoire générale ne dispense pas de la consultation pour chaque action particulière.

L'exemple de David : un modèle de consultation

Comme David, qui connaissait parfaitement la destinée de Dieu sur lui, qui savait qu'il était l'oint de Dieu pour être roi, il va marcher dans le sens de l'accomplissement de celle-ci. Mais malgré cette assurance, face aux réalités concrètes qu'il rencontrait, il consultait toujours Dieu.

Qu'il soit faible ou fort dans une situation, David savait qu'il n'y a que Dieu qui soit vraiment fort. C'est pourquoi il faut s'armer de ce que Dieu promet dans notre consultation de Lui.

La maturité dans la consultation

Pour agir et prospérer avec Dieu, il faut absolument le principe de la consultation divine en toutes choses.

Demander à Dieu, c'est bien - mais il y a un niveau supérieur. Dans la maturité de notre intimité avec Dieu, là où on L'entend déjà, il faut apprendre à L'interroger. Il faut apprendre à mettre nos émotions partiales de côté pour connaître la véritable marche à suivre.

L'ennemi de la consultation : nos émotions partiales

L'ennemi de la consultation de Dieu n'est rien d'autre que nos émotions ayant déjà un parti pris. Voilà le vrai obstacle !

Première situation : La chose pourrait déjà te plaire. Tu as déjà ton opinion, ta préférence. Mais la consultation de Dieu nécessite l'effacement de ton émotion afin d'obtenir la véritable vérité de Dieu, cette vérité dans laquelle on retrouve de la sagesse divine.

Deuxième situation : Cela pourrait te faire mal et te faire pleurer à chaude larme. C'est douloureux, c'est difficile émotionnellement. Mais à un moment, il sera judicieux d'essuyer les larmes et de consulter Dieu pour savoir si l'action à poser serait d'une victoire. Et si même c'est possible, savoir la conduite exacte à tenir durant l'action.$edm$, $edm$- La vie réelle nécessite un pragmatisme de la vérité reçue : il ne s'agit pas seulement de croire, mais de vivre concrètement ce que Dieu révèle.
- Agir avec Dieu nécessite un savoir sur plusieurs niveaux : ce qui est, pourquoi cela est ainsi, ce qui a été, ce qui adviendra.
- La consultation de Dieu est vitale, non optionnelle : pour savoir comment mener l'action, ses portées, ses effets et l'avenir qui s'y trouve.
- En tant qu'enfant de Dieu, nous sommes déjà victorieux, mais la victoire générale ne dispense pas de la consultation pour chaque action particulière.
- David connaissait sa destinée d'oint, mais il consultait toujours Dieu face aux réalités concrètes.
- Demander à Dieu est bien, mais il y a un niveau supérieur : apprendre à L'interroger, dans la maturité de l'intimité.
- L'ennemi de la consultation, ce sont nos émotions ayant déjà un parti pris : quand la chose nous plaît déjà, et quand elle nous fait mal.
- Il faut effacer son émotion pour obtenir la véritable vérité de Dieu.$edm$, $edm$Cette semaine, tu consultes Dieu pour une action précise.

1. Choisis une action à poser. Une décision ou un projet que tu as devant toi.

2. Repère tes émotions partiales. Note ce que tu ressens déjà : est-ce que la chose te plaît déjà et tu as ton opinion ? Est-ce que la chose te fait mal ? Mets ces émotions de côté.

3. Consulte Dieu. Pose-Lui la question de façon précise : comment sera cette action, quelles seront ses portées, ses effets, la conduite à tenir ? Puis écoute.

4. Note la réponse. Écris ce que tu as perçu, et vérifie si cette réponse correspond à tes préférences, ou si elle est différente.$edm$, $edm$✅ Acquis, je maîtrise bien : ...

⏳ En cours, je comprends mais je dois approfondir : ...

🔄 À travailler, je dois revenir dessus plus tard : ...

(Exemples de points à évaluer : le pragmatisme spirituel · la consultation vitale · la victoire générale et l'action particulière · l'exemple de David · mes émotions partiales.)$edm$, false, true),
('formation', 28, 6, 6, $edm$Savoir agir et prospérer avec Dieu$edm$, $edm$Le temps et l'état pour agir$edm$, $edm$À la fin de ce module, tu sauras :
- expliquer que l'action avec Dieu s'effectue dans le temps (le kairos) mais à travers un état ;
- comprendre pourquoi il faut d'abord demander la vie ;
- reconnaître comment l'ennemi installe la mort en nous, et ses manifestations ;
- citer les trois conditions non négociables de l'action et de la prospérité avec Dieu.$edm$, $edm$LE TEMPS ET L'ÉTAT POUR AGIR

L'action avec Dieu s'effectue dans le temps (le kairos, le moment opportun) mais à travers un état (notre condition spirituelle, notre disposition intérieure).


DEMANDER LA VIE

Pour agir, il faut d'abord demander la vie. La vie est le moteur de toutes actions, c'est le carburant de l'action.

Le fait est que l'ennemi travaille constamment à planter en nous la mort sous différentes formes :
- La mort physique
- La mort émotionnelle
- La mort spirituelle


COMMENT L'ENNEMI INSTALLE LA MORT EN NOUS

Le royaume des ténèbres ne peut pas te tuer directement, mais il peut intégrer la mort à ton système, l'installer progressivement en toi. Le résultat ? Tu deviens timide dans tous les sens du terme :

Les manifestations de cette mort installée :
- Vaniteux : tu envies tout chez les autres sans pouvoir apprendre, te préparer et travailler pour l'obtenir
- Paresseux : tu n'as plus la force d'agir, de te lever, de faire ce qu'il faut
- Faible : tu n'as plus de résistance spirituelle
- Plein de défauts et de manquements que tu acceptes progressivement, qui deviennent même des excuses pour ne pas avancer
- Distraction : incapacité à rester concentré sur ce qui est important
- Négligence et légèreté : tu prends les choses spirituelles à la légère
- Sans oublier les émotions destructrices : abandon, dépression, tristesse chronique, frustration permanente, et complexité (sentiment d'infériorité)


LE SACRIFICE NÉCESSAIRE

Pour agir avec Dieu, il faut pouvoir sacrifier un minimum de temps et de disposition pour consulter Dieu. Le but ? Être résolu, être établi fermement dans ladite initiative inspirée de Dieu.


LES CONDITIONS NON NÉGOCIABLES

Il n'y a pas d'action et de prospérité avec Dieu sans :

1. L'obéissance à Dieu - faire ce qu'Il dit, même si c'est difficile
2. L'approbation de Dieu - avoir Son feu vert sur nos projets
3. Le revêtement de la Puissance de l'Esprit - sans Lui, nous ne pouvons rien faire de durable

Parce que pour l'action, il faut aussi :
- La mission claire
- Le plan de Dieu accepté et embrassé
- Ce plan doit nous impacter l'âme jusqu'à nous faire voir se déclencher sur nos vies la Toute-Puissance de Dieu$edm$, $edm$- L'action avec Dieu s'effectue dans le temps (le kairos, le moment opportun) mais à travers un état : notre condition spirituelle, notre disposition intérieure.
- Pour agir, il faut d'abord demander la vie : elle est le moteur et le carburant de l'action.
- L'ennemi travaille à planter en nous la mort sous différentes formes : physique, émotionnelle, spirituelle.
- Le royaume des ténèbres ne peut pas nous tuer directement, mais il peut intégrer la mort à notre système, progressivement.
- Manifestations : vaniteux, paresseux, faible, plein de défauts acceptés, distrait, négligent, et des émotions destructrices (abandon, dépression, tristesse chronique, frustration permanente, complexité).
- Il faut sacrifier un minimum de temps et de disposition pour consulter Dieu, afin d'être résolu et établi dans l'initiative inspirée de Dieu.
- Trois conditions non négociables : l'obéissance à Dieu, l'approbation de Dieu, le revêtement de la Puissance de l'Esprit.
- Il faut aussi la mission claire, le plan de Dieu accepté et embrassé, et un plan qui nous impacte l'âme.$edm$, $edm$Cette semaine, tu examines ton état avant d'agir.

1. Repère les signes de la mort installée. Relis la liste des manifestations (vaniteux, paresseux, faible, défauts acceptés, distrait, négligent, émotions destructrices). Note honnêtement ceux que tu reconnais en toi.

2. Demande la vie. Présente à Dieu ce que tu as noté et demande-Lui la vie, le carburant de ton action.

3. Fixe un temps. Décide d'un temps précis cette semaine que tu sacrifies pour consulter Dieu sur ton initiative.

4. Vérifie les trois conditions. Pour ton initiative, demande-toi : suis-je prêt à obéir ? Ai-je l'approbation de Dieu ? Suis-je revêtu de la puissance de l'Esprit ?$edm$, $edm$✅ Acquis, je maîtrise bien : ...

⏳ En cours, je comprends mais je dois approfondir : ...

🔄 À travailler, je dois revenir dessus plus tard : ...

(Exemples de points à évaluer : le temps et l'état · demander la vie · reconnaître la mort installée · le sacrifice nécessaire · les trois conditions non négociables.)$edm$, false, true),
('formation', 29, 6, 6, $edm$Savoir agir et prospérer avec Dieu$edm$, $edm$La prospérité véritable$edm$, $edm$À la fin de ce module, tu sauras :
- expliquer comment l'obéissance produit la prospérité ;
- définir la prospérité : productivité et croissance infinie ;
- citer les quatre dimensions de la vraie prospérité ;
- comprendre la publicité divine et la paix qui accompagne la prospérité véritable.$edm$, $edm$LE FRUIT DE L'OBÉISSANCE : LA PROSPÉRITÉ VÉRITABLE

Quand l'obéissance produit la prospérité

Lorsqu'il y a obéissance dans les actions posées, on parvient à la prospérité. Cette prospérité n'est rien d'autre que la bénédiction conforme à celle qui fut donnée à Christ par l'Esprit.

Comment Christ a-t-il prospéré ? Luc 2:52 nous montre :
- Il grandissait en stature
- Il grandissait en sagesse
- Sa renommée grandissait partout

Lorsqu'il y a action véritable, il y a capacité. Et la capacité, c'est l'onction liée à l'envoi ou à la mission que Dieu nous donne.

Le cercle complet

Passer à l'action nécessite donc tous ces aspects qui ne sont que le résultat de la marche avec Dieu depuis l'invocation (notre appel initial, notre cri vers Dieu au début de notre cheminement).


LA VÉRITÉ QUI FAIT PROSPÉRER

Définissons la prospérité

Prospérité = Productivité

Agir est bien, c'est important. Mais être productif est encore mieux - c'est la véritable marque de la prospérité de Christ en nous.

C'est pourquoi dans Jean 15, Jésus dit que celui qui demeure en Lui porte beaucoup de fruits. Pas juste un peu de fruits - beaucoup de fruits.

La vraie nature de la prospérité

La prospérité véritable, c'est la bénédiction qui n'est suivie d'aucun chagrin. C'est celle qui nous envoie dans le monde en nous rendant impactants, en nous faisant laisser des traces durables partout où nous passons.

Important à comprendre : Elle n'est pas liée au matériel en premier lieu, mais à la croissance indéterminée, sans limite.

Prospérité = Croissance infinie

Comme Jésus qui grandissait continuellement - Luc 2:52 nous montre cette croissance dans quatre dimensions simultanées.

Les quatre dimensions de la vraie prospérité

Si quelqu'un reçoit ces quatre choses, il devient non seulement un instrument de transformation pour sa propre vie, mais aussi pour celle d'autrui :

1. Croissance en sagesse - intelligence spirituelle et naturelle qui se développe sans cesse
2. Croissance en stature - force, maturité, caractère qui se fortifie
3. Grâce devant Dieu - relation de plus en plus profonde, intimité croissante
4. Grâce devant les hommes - faveur, influence, renommée qui augmente

La publicité divine

Le fait est qu'on ne passera jamais inaperçu. On ne pourra jamais passer de vous parce que ce qui parle pour vous et de vous n'est pas naturel mais surnaturel.

C'est la publicité du divin à votre sujet. Ainsi dit : faveur divine activée = faveur des hommes activée automatiquement.

Une renommée qui ne cesse d'évoluer

C'est une renommée qui ne cesse jamais d'évoluer, de grandir, de s'étendre. Elle n'est pas fabriquée par nos efforts humains, elle est le fruit de l'approbation divine sur notre vie.

La paix qui accompagne cette prospérité

Dans cette dimension de prospérité véritable, on ne s'inquiète pas du lendemain. Pourquoi ? Parce que l'approbation divine s'est activée par notre obéissance.

Proverbes 10:22 le confirme : "C'est la bénédiction de l'Éternel qui enrichit, et il ne la fait suivre d'aucun chagrin."

Quand Dieu bénit vraiment, il n'y a pas de stress, pas d'inquiétude maladive, pas de chagrin qui accompagne. C'est une prospérité paisible, stable, croissante.$edm$, $edm$- L'obéissance dans les actions produit la prospérité : la bénédiction conforme à celle qui fut donnée à Christ par l'Esprit.
- Comment Christ a prospéré (Luc 2:52) : il grandissait en stature, en sagesse, et sa renommée grandissait partout.
- Lorsqu'il y a action véritable, il y a capacité : l'onction liée à l'envoi ou à la mission donnée par Dieu.
- Tout cela est le résultat de la marche avec Dieu depuis l'invocation.
- Prospérité = productivité : porter beaucoup de fruits (Jean 15).
- La prospérité véritable est la bénédiction qui n'est suivie d'aucun chagrin. Elle n'est pas liée au matériel en premier lieu, mais à une croissance sans limite : prospérité = croissance infinie.
- Quatre dimensions : croissance en sagesse, croissance en stature, grâce devant Dieu, grâce devant les hommes.
- La publicité divine : faveur divine activée = faveur des hommes activée automatiquement.
- La renommée n'est pas fabriquée par nos efforts, elle est le fruit de l'approbation divine.
- Proverbes 10:22 : la bénédiction de l'Éternel enrichit, sans chagrin. Pas de stress, pas d'inquiétude du lendemain.$edm$, $edm$Cette semaine, tu fais le point sur ta croissance.

1. Évalue tes quatre dimensions. Pour chacune (sagesse, stature, grâce devant Dieu, grâce devant les hommes), note si elle grandit, stagne ou recule dans ta vie.

2. Repère tes fruits. Note les fruits concrets que tu portes aujourd'hui : qu'est-ce qui est productif dans ta vie ?

3. Examine ta paix. Demande-toi : est-ce que je m'inquiète du lendemain ? Si oui, présente-le à Dieu à la lumière de Proverbes 10:22.

4. Choisis une dimension. Choisis celle que tu veux voir grandir cette semaine et note une action concrète d'obéissance qui y conduit.$edm$, $edm$✅ Acquis, je maîtrise bien : ...

⏳ En cours, je comprends mais je dois approfondir : ...

🔄 À travailler, je dois revenir dessus plus tard : ...

(Exemples de points à évaluer : l'obéissance qui produit la prospérité · prospérité = productivité · prospérité = croissance infinie · les quatre dimensions · la publicité divine · la paix.)$edm$, false, true),
('formation', 30, 6, 6, $edm$Savoir agir et prospérer avec Dieu$edm$, $edm$Comment agit-on concrètement avec Dieu ?$edm$, $edm$À la fin de ce module, tu sauras :
- citer les sept manières d'agir avec Dieu au quotidien ;
- expliquer chaque manière par son fondement biblique ;
- reconnaître, pour chacune, la pratique palpable qui lui correspond ;
- choisir la manière d'agir qui convient à ton action.$edm$, $edm$COMMENT AGIT-ON CONCRÈTEMENT AVEC DIEU ?

Maintenant que nous avons compris les fondements, les principes et la nature de la prospérité, voyons concrètement comment on agit avec Dieu au quotidien.

1. AGIR AVEC LA FOLIE DE LA FOI

L'action avec Dieu ne se fait pas avec une logique humaine, mais avec la folie de la foi - ce qui semble fou aux yeux du monde mais qui est sagesse selon Dieu.

Explication biblique : 1 Corinthiens 1:25 - "Car la folie de Dieu est plus sage que les hommes, et la faiblesse de Dieu est plus forte que les hommes."

Pratique palpable : C'est partir sans savoir où l'on va, simplement parce que Dieu a parlé. C'est agir même quand tout semble impossible humainement.

2. AGIR PAR ASSURANCE

Agir ou démontrer par assurance spirituelle, cette certitude intérieure que Dieu a donnée.

Explication biblique : Hébreux 11:1 - "Or la foi est une ferme assurance des choses qu'on espère, une démonstration de celles qu'on ne voit pas."

Pratique palpable : C'est déclarer la guérison avant de la voir. C'est proclamer la victoire avant le combat. C'est annoncer la provision avant qu'elle n'arrive physiquement. Tout cela parce qu'on a l'assurance de Dieu dans le cœur.

3. AGIR PAR L'ESPRIT

Agir selon la parole, la révélation, l'affirmation ou même par simple sensibilité à l'Esprit.

Explication biblique : Actes 13:2 - "Pendant qu'ils servaient le Seigneur dans leur ministère et qu'ils jeûnaient, le Saint-Esprit dit: Mettez-moi à part Barnabas et Saul pour l'œuvre à laquelle je les ai appelés."

Pratique palpable : C'est obéir à une impulsion spirituelle pendant la prière. C'est suivre une direction que l'Esprit met dans notre cœur. C'est agir sur une révélation reçue dans l'intimité avec Dieu, même si personne d'autre ne comprend.

4. AGIR PAR IDENTITÉ

Agir en fonction de qui nous sommes en Christ, pas en fonction de nos sentiments ou circonstances.

Explication biblique avec l'illustration d'Éli : Dans 1 Samuel 3:8-9, Éli reconnaît que c'est l'Éternel qui parle à Samuel et lui dit quoi faire. Il agit selon sa position, son identité de sacrificateur qui connaît les voies de Dieu.

Pratique palpable : C'est se positionner selon notre identité en Christ - enfant de Dieu, héritier, ambassadeur, sacrificateur royal - et agir en conséquence, pas selon nos peurs ou nos doutes, mais selon qui Dieu dit que nous sommes.

5. AGIR SOUS L'INFLUENCE DE L'ESPRIT

Être complètement sous la conduite et l'influence du Saint-Esprit dans nos actions.

Explication biblique avec l'illustration de Jésus-Christ :
- Luc 4:1 - "Jésus, rempli du Saint-Esprit, revint du Jourdain, et il fut conduit par l'Esprit dans le désert"
- Jean 5:19 - Jésus dit qu'Il ne fait rien de Lui-même, mais seulement ce qu'Il voit faire au Père

Pratique palpable : C'est ne rien faire de soi-même. C'est attendre de voir ce que le Père fait avant d'agir. C'est être tellement sensible à l'Esprit qu'on bouge quand Il bouge, qu'on parle quand Il parle, qu'on s'arrête quand Il s'arrête.

6. AGIR PAR MANDAT, MISSION, CAUTION OU AUTORISATION DIVINE

Agir parce qu'on a reçu un ordre de mission clair de Dieu, une autorisation divine pour un domaine spécifique.

Explication biblique avec l'illustration de Jésus-Christ : Matthieu 28:18-19 - "Jésus, s'étant approché, leur parla ainsi: Tout pouvoir m'a été donné dans le ciel et sur la terre. Allez, faites de toutes les nations des disciples..."

Pratique palpable : C'est exercer l'autorité spirituelle dans les domaines précis où Dieu nous a mandatés - que ce soit la délivrance, la guérison, l'enseignement, le leadership, les affaires. On agit avec l'assurance qu'on a reçu l'autorisation divine pour ce territoire spécifique.

7. AGIR PAR FORCE ET PUISSANCE

Agir revêtu de la force et de la puissance de l'Esprit.

Explication biblique : Actes 1:8 - "Mais vous recevrez une puissance, le Saint-Esprit survenant sur vous, et vous serez mes témoins..."

Pratique palpable : Quand on marche dans la vertu de l'Esprit, on n'a pas souvent besoin d'attendre Dieu pour chaque petite chose. Quand on est fort et puissant par la vertu de l'Esprit, on connaît déjà la volonté générale de Dieu et on agit avec autorité. On n'attend pas toujours une permission spécifique pour frapper l'ennemi ou avancer dans le royaume.$edm$, $edm$- Il y a sept manières d'agir concrètement avec Dieu au quotidien.
- 1. La folie de la foi : agir sans logique humaine, partir parce que Dieu a parlé (1 Corinthiens 1:25).
- 2. L'assurance : agir par la certitude intérieure que Dieu a donnée, déclarer avant de voir (Hébreux 11:1).
- 3. Par l'Esprit : agir selon la parole, la révélation, l'affirmation ou la sensibilité à l'Esprit (Actes 13:2).
- 4. Par identité : agir selon qui nous sommes en Christ, non selon nos sentiments ou circonstances (1 Samuel 3:8-9).
- 5. Sous l'influence de l'Esprit : ne rien faire de soi-même, voir ce que le Père fait (Luc 4:1, Jean 5:19).
- 6. Par mandat, mission, caution ou autorisation divine : agir dans les domaines précis où Dieu nous a mandatés (Matthieu 28:18-19).
- 7. Par force et puissance : agir revêtu de la puissance de l'Esprit (Actes 1:8).
- Voilà la vision complète : agir avec Dieu en Le consultant constamment, en appliquant les quatre aspects, en obéissant à Sa voix, ce qui produit la vraie prospérité.$edm$, $edm$Cette semaine, tu choisis comment agir.

1. Repère ta manière habituelle. Parmi les sept manières, laquelle pratiques-tu le plus ? Laquelle pratiques-tu le moins ?

2. Choisis une action en attente. Prends une action que tu as devant toi et passe-la par la méthode des quatre questions (module 1) : est-ce la volonté de Dieu ? Est-ce le bon projet ? Ai-je la foi ? Est-ce par amour ?

3. Choisis la manière d'agir. Si les quatre réponses sont positives, choisis laquelle des sept manières convient à cette action (folie de la foi, assurance, Esprit, identité, influence de l'Esprit, mandat, force et puissance).

4. Pose l'action et note-la. Agis avec confiance, puis note ce que tu observes.$edm$, $edm$✅ Acquis, je maîtrise bien : ...

⏳ En cours, je comprends mais je dois approfondir : ...

🔄 À travailler, je dois revenir dessus plus tard : ...

(Exemples de points à évaluer : agir par la folie de la foi · par assurance · par l'Esprit · par identité · sous l'influence de l'Esprit · par mandat · par force et puissance · ma première action posée.)


==================================================
CONCLUSION DE LA FORMATION
==================================================

Voilà la vision complète - agir avec Dieu en Le consultant constamment, en appliquant les quatre aspects indispensables (volonté, bon projet, foi, amour), en obéissant à Sa voix, ce qui produit la vraie prospérité (croissance infinie dans toutes les dimensions), et tout cela se manifeste concrètement par différentes manières d'agir selon la direction du Saint-Esprit.$edm$, true, true),
('formation', 31, 7, 7, $edm$Savoir offrir à Dieu$edm$, $edm$Qu'est-ce qu'offrir à Dieu ?$edm$, $edm$À la fin de ce module, tu sauras :
- expliquer qu'offrir à Dieu est un acte d'amour profond envers le Seigneur ;
- dire en quoi consiste principalement l'offrande sous l'Évangile ;
- distinguer offrir à Dieu et donner à son prochain ;
- comprendre la dimension sacrée de l'offrande.$edm$, $edm$SAVOIR OFFRIR À DIEU

1. INTRODUCTION : QU'EST-CE QU'OFFRIR À DIEU ?

Offrir à Dieu, c'est bien plus qu'un simple geste de générosité. C'est un acte d'amour profond envers le Seigneur. Lorsqu'on aime Dieu de tout son cœur, on cherche naturellement à lui plaire. Et pour plaire à quelqu'un, on essaie de faire ce qui compte vraiment pour cette personne, ce qui lui tient à cœur. C'est exactement la même logique qui s'applique dans notre relation avec Dieu : plus on l'aime, plus on cherche à découvrir ce qu'il attend de nous, et plus on a envie de le satisfaire.

Sous l'Ancienne Alliance comme sous la Nouvelle Alliance, nous voyons des hommes et des femmes offrir à Dieu. Mais aujourd'hui, sous l'Évangile, offrir à Dieu prend un sens particulier : cela consiste principalement à soutenir la progression de l'Évangile. Ce n'est plus seulement une question de rituel ou de sacrifice comme autrefois, mais une manière concrète de participer à l'avancement du Royaume de Dieu sur la terre.


2. DIFFÉRENCE ENTRE OFFRIR À DIEU ET DONNER À SON PROCHAIN

Il est essentiel de bien faire la distinction entre ces deux réalités, car on a souvent tendance à les confondre.

Donner à son prochain est un acte de bonté naturel, et parfois même surnaturel. C'est simplement faire du bien autour de soi, aider ceux qui sont dans le besoin. La Bible nous rappelle d'ailleurs que celui qui ne fait pas le bien commet un péché. Aider son semblable, c'est en réalité aussi une manière d'honorer Dieu, car Dieu se soucie de la façon dont nous traitons les autres. Cependant, ce type de don reste dans le domaine social, relationnel, humain. Il ne porte pas en lui-même cette dimension sacrée qui caractérise l'offrande.

Offrir à Dieu, en revanche, touche l'aspect spirituel de notre vie. C'est à ce niveau qu'on ne parle plus simplement de "dons" mais d'"offrandes". L'offrande est liée à un rituel, à une dimension sacrée, à quelque chose qui dépasse le cadre purement social. C'est pourquoi le mot "offrande" est presque toujours associé à Dieu ou à une entité spirituelle, et il sous-entend souvent l'idée d'un autel, d'un lieu de consécration. Pour nous chrétiens, l'offrande concerne directement notre relation avec Dieu et porte une connotation spirituelle que le simple don social n'a jamais.$edm$, $edm$- Offrir à Dieu, c'est bien plus qu'un simple geste de générosité : c'est un acte d'amour profond envers le Seigneur.
- Quand on aime Dieu de tout son cœur, on cherche à lui plaire, donc à découvrir ce qu'il attend de nous.
- Sous l'Ancienne comme sous la Nouvelle Alliance, des hommes et des femmes ont offert à Dieu.
- Sous l'Évangile, offrir à Dieu consiste principalement à soutenir la progression de l'Évangile : une manière concrète de participer à l'avancement du Royaume sur la terre.
- Donner à son prochain est un acte de bonté, dans le domaine social, relationnel, humain. C'est aussi une manière d'honorer Dieu.
- Offrir à Dieu touche l'aspect spirituel de notre vie : l'offrande est liée à un rituel, à une dimension sacrée, à l'idée d'un autel, d'un lieu de consécration.
- Pour nous chrétiens, l'offrande concerne directement notre relation avec Dieu.$edm$, $edm$Cette semaine, tu fais la différence dans ta propre vie.

1. Écris ta propre phrase. En une phrase, avec tes mots : « Pour moi, offrir à Dieu, c'est... »

2. Repère la différence. Note un geste récent où tu as donné à ton prochain, et un geste où tu as offert à Dieu. Qu'est-ce qui les distingue ?

3. Examine ton amour. Demande-toi : qu'est-ce que je cherche à plaire à Dieu aujourd'hui ? Qu'est-ce qui lui tient à cœur ?$edm$, $edm$✅ Acquis, je maîtrise bien : ...

⏳ En cours, je comprends mais je dois approfondir : ...

🔄 À travailler, je dois revenir dessus plus tard : ...

(Exemples de points à évaluer : offrir à Dieu comme acte d'amour · l'offrande sous l'Évangile · la différence avec donner à son prochain · la dimension sacrée de l'offrande.)$edm$, false, true),
('formation', 32, 7, 7, $edm$Savoir offrir à Dieu$edm$, $edm$Les trois attitudes face à l'offrande$edm$, $edm$À la fin de ce module, tu sauras :
- reconnaître les trois attitudes face à l'offrande ;
- identifier l'attitude des accusateurs sans amour et ses conséquences ;
- identifier l'attitude de ceux qui donnent avec amour pour Dieu ;
- comprendre pourquoi on offre à Dieu et non à un homme, et pourquoi il vaut mieux ne rien donner que donner avec cupidité.$edm$, $edm$3. LES TROIS ATTITUDES FACE À L'OFFRANDE

Lorsqu'un appel est lancé pour soutenir une œuvre de Dieu, on peut observer trois types de réactions bien distinctes chez les croyants.

LA PREMIÈRE ATTITUDE : LES ACCUSATEURS SANS AMOUR

La première attitude est celle des accusateurs sans amour. Ce sont des personnes qui n'ont pas véritablement l'amour de Dieu ancré dans leur cœur. Quand on leur demande de donner, elles commencent immédiatement à calculer. Par exemple, si cent personnes donnent deux mille francs chacune, elles se disent tout de suite que l'homme de Dieu va s'enrichir personnellement. Résultat : elles ne donnent rien, et pire encore, elles deviennent des critiques, des accusateurs, exactement au même titre que Satan, qui est lui-même appelé "l'accusateur des frères". Cette attitude vient du fait que ces personnes n'ont jamais véritablement offert leur propre vie à Dieu. Leur cœur reste attaché à l'argent, à ce que la Bible appelle Mammon. Et tant qu'on n'a pas cet amour pour Dieu et pour son prochain, cette mentalité de calcul et de suspicion persiste, et elle crée ce qu'on pourrait appeler une malédiction subtile, un blocage spirituel qui empêche la bénédiction de couler dans la vie de la personne. Si Dieu ne t'a pas encore convaincu, en tant que serviteur ou simple chrétien, de participer à une œuvre particulière, il ne faut pas te tourmenter l'esprit pour autant. Avance simplement dans ta marche avec Dieu, mais veille à ne jamais tomber dans cette première catégorie, celle des accusateurs.

LA DEUXIÈME ATTITUDE : CEUX QUI DONNENT AVEC UN CŒUR REMPLI D'AMOUR POUR DIEU

La deuxième attitude est celle de ceux qui donnent avec un cœur rempli d'amour pour Dieu. Ces personnes aiment le Seigneur de tout leur cœur et se sont entièrement données à Jésus-Christ. Elles donnent sans calculer, sans chercher à raisonner ou à justifier leur geste, portées par un amour débordant pour Dieu. Leur cœur n'est pas attaché à l'argent, et elles n'attendent rien d'autre de Dieu que sa bénédiction et sa présence. Ces personnes ont développé une véritable sensibilité spirituelle, et elles donnent selon la conviction qu'elles reçoivent dans leur cœur. C'est exactement l'attitude qu'avait le roi David lorsqu'il disait qu'il ne voulait pas offrir à l'Éternel des sacrifices qui ne lui coûtaient rien. Jésus-Christ lui-même a loué ce genre d'attitude. Il a d'ailleurs sévèrement critiqué les riches qui donnaient de grosses sommes aux yeux des hommes, mais qui, en réalité, ne donnaient rien aux yeux de Dieu, puisque cela ne leur coûtait absolument rien de leur superflu. À l'inverse, la pauvre veuve qui a mis ses deux petites pièces dans le tronc du temple a tout donné, car c'était littéralement tout ce qu'elle possédait pour vivre.

LA TROISIÈME ATTITUDE : LES CHRÉTIENS CUPIDES

La troisième attitude est celle des chrétiens cupides. Comme Ananias et Saphira dans le livre des Actes, ces personnes trouvent qu'il est excessif, voire déraisonnable, de trop donner à Dieu. Elles donnent uniquement ce qui ne leur coûte rien, ce qui est superflu pour elles, tout en essayant de se donner bonne conscience. Elles raisonnent ainsi : "La personne qui va recevoir cet argent en a déjà beaucoup, elle n'a pas vraiment besoin de mon don." Mais il faut bien comprendre une chose essentielle : offrir à Dieu n'est pas la même chose qu'aider son prochain financièrement. La personne à qui l'offrande est remise, que ce soit un serviteur de Dieu ou une œuvre, n'est en réalité qu'un instrument entre les mains de Dieu. C'est à Dieu lui-même que l'on donne, et non simplement à un homme. Les cupides pensent être malins en gardant une partie de ce qu'ils devraient donner, mais il faut retenir ce conseil important : il vaut mieux ne rien donner du tout que de donner de manière superflue, avec un cœur rongé par un esprit de cupidité qui n'est autre que l'esprit de Satan. Mieux vaut s'abstenir plutôt que d'être repris par l'Esprit de Dieu, comme cela est arrivé à Ananias et à Saphira, qui ont perdu la vie pour avoir menti à Dieu concernant leur offrande.$edm$, $edm$- Lorsqu'un appel est lancé pour soutenir une œuvre de Dieu, on observe trois attitudes distinctes chez les croyants.
- Première attitude : les accusateurs sans amour. Ils calculent, ne donnent rien, et deviennent des critiques, comme Satan « l'accusateur des frères ». Leur cœur reste attaché à l'argent (Mammon), ce qui crée un blocage spirituel.
- Si Dieu ne nous a pas encore convaincus de participer à une œuvre, il ne faut pas se tourmenter : on avance dans sa marche avec Dieu, sans tomber dans la catégorie des accusateurs.
- Deuxième attitude : ceux qui donnent avec un cœur rempli d'amour pour Dieu. Ils donnent sans calculer, selon la conviction reçue dans leur cœur, comme David qui ne voulait pas offrir des sacrifices qui ne lui coûtaient rien.
- Jésus a loué cette attitude : la pauvre veuve a tout donné, alors que les riches ne donnaient que leur superflu.
- Troisième attitude : les chrétiens cupides, comme Ananias et Saphira. Ils donnent ce qui ne leur coûte rien, en se donnant bonne conscience.
- Offrir à Dieu n'est pas aider son prochain financièrement : la personne qui reçoit n'est qu'un instrument entre les mains de Dieu. C'est à Dieu qu'on donne.
- Il vaut mieux ne rien donner du tout que de donner de manière superflue avec un cœur rongé par la cupidité.$edm$, $edm$Cette semaine, tu examines ton cœur face à l'offrande.

1. Repère ton attitude habituelle. Quand un appel est lancé, comment réagis-tu : tu calcules, tu donnes par amour, ou tu donnes ce qui ne te coûte rien ? Note-le honnêtement.

2. Examine ton rapport à l'argent. Demande-toi : mon cœur est-il attaché à l'argent (Mammon) ? Qu'est-ce que cela change dans ma manière de donner ?

3. Garde-toi d'accuser. Note une occasion où tu as critiqué, ou pensé critiquer, quelqu'un qui donnait ou qui lançait un appel. Présente-la à Dieu.

4. Souviens-toi de la veuve. Relis son histoire et note ce qu'elle t'enseigne sur ta propre manière de donner.$edm$, $edm$✅ Acquis, je maîtrise bien : ...

⏳ En cours, je comprends mais je dois approfondir : ...

🔄 À travailler, je dois revenir dessus plus tard : ...

(Exemples de points à évaluer : l'attitude des accusateurs · celle de ceux qui donnent avec amour · celle des cupides · on offre à Dieu et non à un homme · ma propre attitude.)$edm$, false, true),
('formation', 33, 7, 7, $edm$Savoir offrir à Dieu$edm$, $edm$Comment offrir à Dieu$edm$, $edm$À la fin de ce module, tu sauras :
- citer les quatre éléments nécessaires pour bien offrir à Dieu ;
- comprendre pourquoi Dieu n'oblige jamais à donner ;
- comprendre l'offrande sous l'ère de la Grâce ;
- citer les trois manières dont une offrande est présentée, et ses bienfaits.$edm$, $edm$4. COMMENT OFFRIR À DIEU ?

Pour véritablement bien offrir à Dieu, plusieurs éléments doivent être présents dans la vie du croyant.

Il faut d'abord avoir une véritable éducation spirituelle. Cela signifie développer une sensibilité profonde à la présence et à la voix de Dieu. Sans cette sensibilité, il est tout simplement impossible d'offrir véritablement à Dieu, car avec Dieu, on ne raisonne pas selon la logique humaine habituelle. Les critères du monde, les calculs d'intérêt personnel, n'ont pas leur place dans ce domaine.

Il faut ensuite la conviction et l'intimité avec Dieu. Il est important de comprendre que Dieu n'oblige jamais personne à donner. C'est la sensibilité spirituelle qui, petit à petit, crée en nous une conviction intérieure, et cette conviction, à son tour, développe une véritable intimité avec Dieu. C'est exactement pour cette raison que ceux qui donnent avec libéralité sont des personnes profondément sensibles à l'Esprit, véritablement convaincues par Dieu lui-même, et qui agissent selon cette conviction malgré le regard ou le jugement des autres.

Il faut aussi s'informer et se rendre disponible. Le croyant doit connaître les différents types d'offrandes bibliques qui existent, et il doit rester attentif aux appels que lancent les porteurs de l'Évangile. Chaque serviteur qui porte l'Évangile est en quelque sorte un autel vivant de Dieu ici sur la terre. C'est d'ailleurs pour cette raison que Jésus a dit à Pierre qu'il bâtirait son Église sur ce roc, faisant référence à cette réalité que les serviteurs de Dieu deviennent des piliers sur lesquels repose l'œuvre de Dieu.

Enfin, il faut apprendre à donner dans le secret. Celui qui a développé une véritable sensibilité à l'Esprit parvient progressivement à une conviction personnelle et développe ainsi une intimité toujours plus profonde avec Dieu. Cette personne peut alors donner dans le secret, sans faire de bruit autour de son geste. Elle peut offrir cinquante mille francs, ou même cent mille francs, simplement parce que Dieu l'a convaincue intérieurement de le faire. Et même si, après avoir donné, elle n'a plus rien, le Dieu que nous servons, celui à qui appartiennent l'or et l'argent, lui permettra d'en avoir davantage encore, afin qu'elle puisse continuer à donner toujours plus. Comme Jésus l'a enseigné, Dieu émonde et taille celui qui porte du fruit, précisément pour qu'il porte encore plus de fruit par la suite.


5. L'OFFRANDE SOUS L'ÈRE DE LA GRÂCE

Sous l'Évangile, dans cette dispensation particulière de la Grâce dans laquelle nous vivons aujourd'hui, notre Seigneur Jésus-Christ désire que nous nous dépouillions complètement de toute forme de cupidité dans notre cœur. Pourquoi cela ? Tout simplement parce que c'est Dieu lui-même qui donne l'argent et les moyens à chacun de nous. Notre cœur ne doit donc jamais être attaché à l'argent en lui-même, mais nous devons apprendre à tout donner, dans la mesure où Dieu nous y conduit, afin que l'Évangile puisse véritablement prospérer et gagner du terrain dans ce monde.

Souvenons-nous de cet homme riche à qui Jésus a demandé de vendre tout ce qu'il possédait et de le partager aux pauvres. Pourquoi une telle exigence ? Parce qu'à un moment donné dans l'histoire de l'Évangile, les disciples ont été amenés à tout partager avec ceux qui avaient faim autour d'eux. C'est ce qu'on appelait alors la communion fraternelle, cette solidarité profonde entre croyants. Il n'existe donc pas de don véritable à Dieu qui ne touche pas d'une manière ou d'une autre notre prochain également. C'est pourquoi, en offrant à Dieu, nous participons toujours, directement ou indirectement, à l'œuvre d'évangélisation. Notre Dieu est un Dieu qui répond à ceux qui lui font confiance. Il fait toujours prospérer celui qui donne, précisément afin qu'il puisse donner encore davantage.


6. LES BIENFAITS DES OFFRANDES

Toutes les offrandes mentionnées dans la Bible sont venues au peuple de Dieu de trois manières différentes : soit par un appel direct venant de Dieu lui-même, soit par une inspiration divine ressentie dans le cœur, soit par une instruction transmise au peuple par l'intermédiaire d'une personne mandatée par Dieu pour cela.

Répondre positivement à un appel d'offrande produit toujours un bienfait spirituel, et même surnaturel, en retour, précisément parce que l'offrande elle-même est de nature spirituelle. Ceci n'est absolument pas à négliger, car seuls ceux qui ont été véritablement convaincus par Dieu peuvent faire l'expérience concrète de ces résultats surnaturels que Dieu accorde à ses enfants généreux.$edm$, $edm$- Quatre éléments pour bien offrir à Dieu : une éducation spirituelle, la conviction et l'intimité avec Dieu, s'informer et se rendre disponible, et apprendre à donner dans le secret.
- L'éducation spirituelle : développer une sensibilité profonde à la présence et à la voix de Dieu. Avec Dieu, on ne raisonne pas selon la logique humaine.
- Dieu n'oblige jamais personne à donner : la sensibilité crée la conviction, qui développe l'intimité avec Dieu.
- Il faut connaître les types d'offrandes bibliques et rester attentif aux appels des porteurs de l'Évangile : chaque serviteur est en quelque sorte un autel vivant de Dieu.
- Donner dans le secret, sans bruit, selon la conviction reçue de Dieu. Dieu, à qui appartiennent l'or et l'argent, permet d'avoir davantage pour donner toujours plus.
- Sous l'ère de la Grâce, Jésus désire que nous nous dépouillions de toute cupidité : c'est Dieu qui donne l'argent et les moyens. Il faut apprendre à tout donner, dans la mesure où Dieu y conduit, afin que l'Évangile prospère.
- Il n'existe pas de don véritable à Dieu qui ne touche pas aussi notre prochain.
- Dieu fait prospérer celui qui donne, afin qu'il puisse donner encore davantage.
- Les offrandes viennent de trois manières : un appel direct de Dieu, une inspiration divine dans le cœur, une instruction transmise par une personne mandatée par Dieu.
- Répondre positivement à un appel produit un bienfait spirituel et même surnaturel.$edm$, $edm$Cette semaine, tu développes ta sensibilité pour offrir.

1. Fais le point sur tes quatre éléments. Pour chacun (éducation spirituelle, conviction et intimité, s'informer et se rendre disponible, donner dans le secret), note si tu le vis, partiellement ou pas encore.

2. Examine ton attachement à l'argent. Demande à Dieu de te montrer si ton cœur est attaché à l'argent en lui-même.

3. Repère une œuvre à connaître. Informe-toi sur une œuvre ou un serviteur de l'Évangile que tu connais, et sur la manière dont il fait avancer l'Évangile.

4. Prie avant de donner. Avant ta prochaine offrande, prends un temps avec Dieu pour demander s'Il te pousse à donner, et quoi.$edm$, $edm$✅ Acquis, je maîtrise bien : ...

⏳ En cours, je comprends mais je dois approfondir : ...

🔄 À travailler, je dois revenir dessus plus tard : ...

(Exemples de points à évaluer : l'éducation spirituelle · la conviction et l'intimité · s'informer et se rendre disponible · donner dans le secret · l'offrande sous l'ère de la Grâce · les trois manières dont l'offrande est présentée.)$edm$, false, true),
('formation', 34, 7, 7, $edm$Savoir offrir à Dieu$edm$, $edm$Les types d'offrandes bibliques et leurs bienfaits$edm$, $edm$À la fin de ce module, tu sauras :
- citer les types d'offrandes de l'Ancienne Alliance : la dîme, les prémices, l'offrande volontaire, les sacrifices ;
- comprendre que Jésus-Christ est l'accomplissement parfait de tous les sacrifices ;
- citer les types d'offrandes du Nouveau Testament ;
- connaître les bienfaits de chaque type d'offrande.$edm$, $edm$7. LES TYPES D'OFFRANDES BIBLIQUES ET LEURS BIENFAITS

DANS L'ANCIENNE ALLIANCE

La première offrande que l'on retrouve dans l'Ancienne Alliance, c'est la dîme. Il s'agit du dixième de tous nos revenus que nous remettons à Dieu, en reconnaissance du fait que tout ce que nous possédons vient de Lui en premier lieu. Le prophète Malachie, au chapitre 3 verset 10, rapporte cette parole de Dieu : "Apportez à la maison du trésor toutes les dîmes, afin qu'il y ait de la nourriture dans ma maison; mettez-moi de la sorte à l'épreuve, dit l'Éternel des armées. Et vous verrez si je n'ouvre pas pour vous les écluses des cieux, si je ne répands pas sur vous la bénédiction en abondance." Celui qui pratique fidèlement la dîme voit donc Dieu ouvrir pour lui les écluses des cieux et répandre sur sa vie une bénédiction abondante. Le verset suivant, Malachie 3:11, ajoute que Dieu protège également celui qui donne la dîme contre le dévastateur, qui ne viendra pas détruire les fruits de son travail. Cette pratique conduit ainsi à une véritable prospérité matérielle, et elle fait même de celui qui la pratique un témoignage pour les nations environnantes, qui finiront par le déclarer heureux, comme le précise Malachie 3:12.

Vient ensuite l'offrande des prémices. Il s'agit des tout premiers fruits de notre travail, de nos revenus, ou de toute nouvelle bénédiction que nous recevons, donnés à Dieu en tout premier, avant même de penser à nous-mêmes. Le livre des Proverbes, au chapitre 3 versets 9 et 10, nous enseigne : "Honore l'Éternel avec tes biens, et avec les prémices de tout ton revenu : alors tes greniers seront abondamment remplis, et tes cuves regorgeront de moût." Celui qui honore Dieu de cette manière, en lui consacrant ses premiers fruits, voit concrètement ses greniers se remplir abondamment et ses cuves déborder. Dieu devient ainsi véritablement la source première de sa vie, et cette consécration attire naturellement la bénédiction sur tout le reste de son existence.

Il y a également l'offrande volontaire, celle que nous donnons par pur amour pour Dieu, spontanément, selon ce que notre propre cœur nous pousse à donner, sans qu'il s'agisse d'une obligation ou d'un calcul quelconque. C'est précisément ce type d'offrande qui a permis, dans l'Ancien Testament, la construction du tabernacle. Le livre de l'Exode, au chapitre 35, raconte que le peuple, dont le cœur était bien disposé, a apporté une telle quantité d'offrandes pour la construction du tabernacle que Moïse a dû finalement demander aux gens d'arrêter de donner, car il y en avait bien plus qu'il n'en fallait pour accomplir l'ouvrage, comme le rapporte Exode 36:5-7. Dieu reconnaît et honore particulièrement ce genre de cœur généreux et spontané.

Enfin, sous l'Ancienne Alliance, il existait tout un système d'offrandes sacrificielles, décrites en détail dans le livre du Lévitique : l'holocauste au chapitre 1, l'offrande de grain au chapitre 2, le sacrifice de paix ou de communion au chapitre 3, le sacrifice pour le péché au chapitre 4, et le sacrifice de culpabilité au chapitre 5. Tous ces différents sacrifices trouvent aujourd'hui leur accomplissement parfait en la personne de Jésus-Christ. L'épître aux Hébreux, au chapitre 10 versets 10 à 14, l'explique clairement : "C'est en vertu de cette volonté que nous sommes sanctifiés, par l'offrande du corps de Jésus-Christ, une fois pour toutes... Car, par une seule offrande, il a amené à la perfection pour toujours ceux qui sont sanctifiés." Jésus-Christ est ainsi devenu notre sacrifice parfait et complet, une fois pour toutes. C'est par lui que nous recevons désormais le pardon complet de nos péchés, par son sang précieux, la réconciliation et la paix véritable avec Dieu, la sanctification de notre vie, et un accès direct à Dieu qui ne nécessite plus aucun sacrifice d'animaux.


DANS LE NOUVEAU TESTAMENT

Sous la Nouvelle Alliance, on retrouve tout d'abord l'offrande volontaire, ou offrande de libéralité, celle que nous donnons librement à Dieu, selon notre propre cœur, sans aucune contrainte extérieure, dans le but de soutenir son œuvre. L'apôtre Paul, dans sa deuxième lettre aux Corinthiens, au chapitre 9 verset 7, écrit : "Que chacun donne comme il l'a résolu en son cœur, sans tristesse ni contrainte; car Dieu aime celui qui donne avec joie." Celui qui donne de cette manière volontaire voit Dieu multiplier concrètement sa semence, comme le précise 2 Corinthiens 9:10, et l'enrichir toujours davantage afin qu'il puisse continuer à donner, selon 2 Corinthiens 9:11. Dieu le comble alors de toutes sortes de grâces, afin qu'il ait constamment de quoi satisfaire à tous ses besoins, comme l'indique 2 Corinthiens 9:8, et son offrande devient une source abondante d'actions de grâces qui montent vers Dieu, selon 2 Corinthiens 9:12.

Il y a aussi l'offrande destinée à soutenir les serviteurs de Dieu et son œuvre, c'est-à-dire le soutien financier apporté aux apôtres, aux pasteurs, aux évangélistes et aux missionnaires, à tous ceux qui consacrent leur temps entièrement à l'œuvre de l'Évangile. L'apôtre Paul, écrivant aux Philippiens au chapitre 4 versets 15 à 19, les remercie chaleureusement pour leur soutien constant et leur fait cette promesse magnifique : "Mon Dieu pourvoira à tous vos besoins selon sa richesse, avec gloire, en Jésus-Christ." Celui qui soutient fidèlement les serviteurs de Dieu voit ainsi Dieu pourvoir concrètement à tous ses propres besoins, et le fruit de son offrande continue d'abonder à son propre compte devant Dieu, comme le dit Paul dans Philippiens 4:17. Cette personne participe directement à l'avancement de l'Évangile et reçoit une véritable récompense pour chaque âme gagnée grâce au ministère qu'elle soutient financièrement.

Il existe également l'offrande collective pour l'œuvre de Dieu, c'est-à-dire la collecte organisée au sein des Églises pour soutenir l'œuvre de Dieu dans son ensemble, les missions, et les besoins spirituels de l'Église locale ou universelle. Dans sa première lettre aux Corinthiens, au chapitre 16 versets 1 et 2, Paul donne cette instruction précise : "Pour ce qui concerne la collecte en faveur des saints... que chacun de vous, le premier jour de la semaine, mette à part chez lui ce qu'il pourra, selon sa prospérité." Ce type d'offrande collective crée une véritable unité au sein du Corps de Christ et engendre une bénédiction mutuelle entre les différentes Églises, comme on le voit dans Romains 15:27. Elle contribue de manière significative à l'avancement global de l'Évangile, et chacun reçoit, en retour, sa propre récompense selon son propre travail et sa propre participation.

Vient ensuite l'offrande donnée au-delà de ses propres moyens, celle qui consiste à donner au-delà de ce qui semble raisonnable, même dans des situations de pauvreté, simplement par la foi. Les Églises de Macédoine en constituent l'exemple le plus frappant : Paul écrit à leur sujet dans 2 Corinthiens 8:1-3 qu'au milieu de beaucoup de tribulations qui les ont éprouvées, leur joie débordante et leur pauvreté profonde ont produit avec abondance de riches libéralités de leur part, et qu'ils ont donné volontairement selon leurs moyens, et même au-delà de leurs moyens. Ce type d'offrande produit une joie débordante qui persiste malgré les épreuves traversées, elle devient un témoignage puissant de foi pour ceux qui l'observent, et elle manifeste concrètement et visiblement la grâce de Dieu à l'œuvre dans une vie. Cette offrande reste volontaire et naît d'une conviction personnelle venant de Dieu, jamais de la pression des hommes. Elle ne consiste pas à donner ce qu'on n'a pas, mais à donner avec foi, de ce qu'on a, au-delà de ce qui semble raisonnable.

L'offrande joyeuse et hilare mérite également d'être développée. Il s'agit simplement de donner avec joie, avec un véritable enthousiasme, porté par un cœur qui déborde d'amour pour Dieu. On retrouve ce même verset de 2 Corinthiens 9:7 déjà cité, où le mot grec traduit par "joie" est "hilaros", d'où vient notre mot "hilare". Le livre des Actes, au chapitre 20 verset 35, rapporte également cette parole de Jésus rapportée par Paul : "Il y a plus de bonheur à donner qu'à recevoir." Dieu aime tout particulièrement celui qui donne de cette manière joyeuse. Cette joie demeure durablement dans le cœur du donateur, qui se retrouve ainsi allégé et libéré de tout attachement excessif à l'argent.

Enfin, il faut mentionner l'offrande proportionnelle, celle qui tient compte de la prospérité réelle de chaque personne. Chacun donne selon ce que Dieu lui a effectivement donné, selon ses propres moyens, et non selon un standard uniforme imposé à tous. Paul l'exprime clairement dans 1 Corinthiens 16:2, en demandant à chacun de mettre à part ce qu'il pourra, selon sa propre prospérité. La valeur d'une offrande aux yeux de Dieu ne se mesure donc jamais à la quantité absolue donnée, mais bien à la proportion de cette offrande par rapport à ce que la personne possède réellement. C'est exactement ce qu'illustre magnifiquement le récit de la veuve rapporté dans Marc 12:41-44 et dans Luc 21:1-4. Jésus, assis en face du tronc des offrandes, observait comment la foule y déposait de l'argent. Plusieurs riches y mettaient de grosses sommes. Puis vint une pauvre veuve qui y déposa deux petites pièces, une somme dérisoire en comparaison. Jésus appela alors ses disciples et leur dit que cette pauvre veuve avait donné plus que tous les autres réunis, car tous les autres avaient donné de leur superflu, tandis qu'elle, dans sa pauvreté, avait donné tout ce qu'elle avait pour vivre, tout son nécessaire. Jésus remarque ainsi personnellement chaque offrande, même la plus modeste en apparence, et lui accorde une valeur immense à ses yeux, même si elle semble insignifiante aux yeux des hommes. Dieu honore véritablement celui qui donne ce qui lui coûte réellement, et non simplement ce qui ne lui coûte rien. Cette forme d'offrande se caractérise par une profonde justice et une réelle équité : Dieu ne demande jamais à quelqu'un ce qu'il n'a pas, comme le précise Paul dans 2 Corinthiens 8:12, et chacun peut ainsi donner en toute liberté, sans aucune culpabilité, selon ce qu'il possède réellement.$edm$, $edm$- Ancienne Alliance, la dîme : le dixième de tous nos revenus, en reconnaissance que tout vient de Dieu (Malachie 3:10-12). Bienfaits : les écluses des cieux ouvertes, la protection contre le dévastateur, un témoignage pour les nations.
- Les prémices : les tout premiers fruits donnés à Dieu en premier (Proverbes 3:9-10). Dieu devient la source première de la vie.
- L'offrande volontaire : donnée par pur amour pour Dieu, comme pour la construction du tabernacle (Exode 35-36).
- Les offrandes sacrificielles (Lévitique 1 à 5) : accomplies une fois pour toutes en Jésus-Christ (Hébreux 10:10-14). Par Lui : le pardon, la réconciliation, la sanctification, l'accès direct à Dieu.
- Nouveau Testament, l'offrande volontaire ou de libéralité (2 Corinthiens 9:7) : Dieu multiplie la semence et comble de grâces.
- L'offrande pour soutenir les serviteurs de Dieu et son œuvre (Philippiens 4:15-19) : Dieu pourvoit à tous les besoins.
- L'offrande collective (1 Corinthiens 16:1-2) : unité du Corps de Christ et bénédiction mutuelle.
- L'offrande donnée au-delà de ses moyens (Églises de Macédoine) : elle reste volontaire, née d'une conviction venant de Dieu, jamais de la pression.
- L'offrande joyeuse (hilaros) : le bonheur de donner (Actes 20:35).
- L'offrande proportionnelle : on donne selon ce que Dieu a effectivement donné. Dieu ne demande jamais ce qu'on n'a pas (2 Corinthiens 8:12). La veuve a donné plus que tous.$edm$, $edm$Cette semaine, tu fais connaissance avec les types d'offrandes.

1. Dresse la liste. Note les types d'offrandes que tu connais (dîme, prémices, volontaire, soutien des serviteurs de Dieu, collective, au-delà de ses moyens, joyeuse, proportionnelle).

2. Repère ceux que tu pratiques. Pour chaque type, note si tu le pratiques, partiellement ou pas encore, et pourquoi.

3. Choisis un type à approfondir. Choisis un type et relis le passage biblique qui s'y rapporte.

4. Examine ta joie. Demande-toi : quand je donne, est-ce que je donne avec joie, ou avec tristesse et contrainte ?$edm$, $edm$✅ Acquis, je maîtrise bien : ...

⏳ En cours, je comprends mais je dois approfondir : ...

🔄 À travailler, je dois revenir dessus plus tard : ...

(Exemples de points à évaluer : la dîme · les prémices · l'offrande volontaire · Jésus-Christ comme accomplissement des sacrifices · les offrandes du Nouveau Testament · l'offrande proportionnelle.)$edm$, false, true),
('formation', 35, 7, 7, $edm$Savoir offrir à Dieu$edm$, $edm$Les points essentiels et la pratique$edm$, $edm$À la fin de ce module, tu sauras :
- expliquer pourquoi les offrandes du Nouveau Testament comportent une exigence plus élevée ;
- citer les trois manières dont une offrande nous est présentée : par un appel, par un enseignement, par une conviction personnelle ;
- répondre spirituellement à un appel, à un enseignement et à une conviction personnelle ;
- offrir dans le secret, avec joie, après avoir éprouvé les esprits.$edm$, $edm$8. POINTS ESSENTIELS À RETENIR

Ce qu'il faut absolument retenir, c'est que les types d'offrandes pratiqués dans le Nouveau Testament comportent une exigence plus élevée que ceux de l'Ancienne Alliance, précisément parce qu'ils concernent directement le soutien de la Grande Commission. L'Ancienne Alliance avait ses propres offrandes, destinées au temple, aux sacrifices, et à tout le système lévitique qui organisait le culte d'Israël. Mais sous la Nouvelle Alliance, nos offrandes servent désormais directement à soutenir ceux qui annoncent l'Évangile, à faire progresser concrètement le Royaume de Dieu sur la terre, à gagner des âmes pour Christ, à établir de nouvelles Églises, et à envoyer des missionnaires vers les nations. C'est précisément pour cette raison que l'exigence est aujourd'hui plus grande qu'auparavant : nous participons directement, à travers nos offrandes, à l'accomplissement de la Grande Commission que Jésus a confiée à son Église.

Il faut aussi comprendre que toute offrande, qu'elle relève du Nouveau ou de l'Ancien Testament, peut nous être présentée de trois manières différentes. Elle peut nous parvenir par un appel, lorsqu'un serviteur de Dieu lance un appel précis pour un besoin spécifique de l'œuvre. Elle peut aussi nous parvenir par un enseignement, lorsque la Parole de Dieu nous instruit directement sur le sujet de l'offrande. Ou encore, elle peut nous parvenir par une conviction personnelle venant de Dieu lui-même, lorsque le Saint-Esprit nous pousse intérieurement, de manière individuelle, à donner pour une cause particulière. Ces trois moyens sont tous également valables et pleinement bibliques. Que ce soit à travers un appel public lancé lors d'un rassemblement, à travers l'enseignement de la Parole reçu au cours d'une prédication, ou à travers une conviction personnelle reçue dans le secret de la prière, Dieu peut nous conduire, de l'une ou l'autre de ces manières, à offrir concrètement pour son œuvre.$edm$, $edm$- Les offrandes du Nouveau Testament comportent une exigence plus élevée que celles de l'Ancienne Alliance, car elles soutiennent directement la Grande Commission.
- L'Ancienne Alliance avait ses offrandes pour le temple, les sacrifices et le système lévitique. Sous la Nouvelle Alliance, les offrandes soutiennent ceux qui annoncent l'Évangile, font progresser le Royaume, gagnent des âmes, établissent de nouvelles Églises et envoient des missionnaires.
- Toute offrande peut nous être présentée de trois manières : par un appel, par un enseignement, par une conviction personnelle venant de Dieu.
- Ces trois moyens sont tous également valables et pleinement bibliques.
- Face à un appel : prier d'abord, attendre la conviction qui vient de Dieu, donner avec joie si l'on est convaincu, ne pas donner si l'on ne l'est pas, ne jamais devenir un accusateur.
- Face à un enseignement : il crée une révélation, accompagnée d'une promesse de Dieu. On prie, puis on offre comme une réponse personnelle.
- Face à une conviction personnelle : discuter avec Dieu dans le secret, vérifier que l'offrande fait avancer le royaume, éprouver les esprits, puis donner dans le secret avec joie.
- Dans tous les cas, l'offrande est un acte spirituel, jamais charnel.$edm$, $edm$9. LA PRATIQUE : COMMENT OFFRIR SELON L'ENSEIGNEMENT

Peu importe le type d'offrande dont il est question, ce qui compte véritablement, c'est la manière dont nous répondons spirituellement lorsque l'occasion d'offrir se présente à nous. Cette réponse s'inscrit toujours dans l'un des trois moyens que nous venons d'évoquer.

PAR UN APPEL

Lorsqu'un appel est lancé par un serviteur de Dieu, il convient d'abord de parler à Dieu, de prier, plutôt que de donner de manière impulsive ou, à l'inverse, de se mettre à calculer comme le font les accusateurs. On peut simplement dire au Seigneur que cet appel a été lancé, et lui demander sincèrement si c'est bien lui qui nous pousse à y répondre, quelle est sa volonté précise pour nous dans cette situation, et combien il désire que nous donnions concrètement. Il faut ensuite attendre patiemment la conviction, qui vient uniquement de Dieu, et jamais de la pression exercée par les autres ou par les circonstances. Lorsque Dieu convainc réellement quelqu'un, cette personne ressent une paix intérieure profonde, un amour débordant qui la pousse à vouloir participer, une clarté véritable sur le montant précis à donner, et une joie sincère à l'idée de pouvoir contribuer. Si l'on est effectivement convaincu, alors on donne avec joie, sans se soucier de ce que les autres donnent, en plus ou en moins, en se rappelant simplement l'exemple de la veuve qui, avec ses deux petites pièces, a donné aux yeux de Dieu bien plus que tous les riches réunis. Mais si l'on n'est pas convaincu, alors on ne donne tout simplement pas, et il faut bien comprendre que cela ne constitue en aucun cas une obligation. Il vaut largement mieux ne pas donner du tout que de donner avec un cœur rempli de doutes, de calculs mesquins, ou d'une cupidité cachée, car Dieu regarde toujours le cœur de celui qui donne, bien plus que le montant lui-même. Il faut également veiller à ne jamais devenir un accusateur : ne pas critiquer ceux qui donnent, et ne pas non plus critiquer le serviteur de Dieu qui a lancé l'appel. Si Dieu ne nous a pas personnellement convaincus cette fois-ci, il suffit simplement d'avancer dans notre marche avec lui, sans tomber dans cette première catégorie d'attitude que nous avons évoquée plus haut.

PAR UN ENSEIGNEMENT

Lorsqu'un enseignement est reçu, le processus se déroule un peu différemment. L'enseignement, lorsqu'il touche véritablement notre cœur, crée en nous une révélation. Il apporte une clarté nouvelle qui, à son tour, produit cette révélation intérieure. Et derrière toute révélation authentique de ce genre, il y a toujours une promesse de Dieu qui l'accompagne. On peut alors prier en tenant compte de cette révélation et de cette promesse reçue, en disant au Seigneur qu'il nous a montré, à travers sa Parole, l'importance véritable d'offrir pour son œuvre, et en lui demandant de nous guider précisément sur ce que nous devons faire concrètement. On procède ensuite à son offrande selon la conviction ainsi reçue, non pas comme une obligation imposée depuis l'extérieur, mais véritablement comme une réponse personnelle à la révélation que Dieu nous a lui-même donnée. Il faut d'ailleurs souligner qu'à chaque fois que l'on souhaite faire une offrande, il est absolument nécessaire d'être spirituel dans cette démarche, car l'offrande n'est jamais un acte charnel, mais toujours un acte profondément spirituel. Cela ne constitue pas non plus une obligation en soi, mais c'est véritablement le fruit de l'Esprit qui, en nous, nous pousse naturellement à devenir de plus en plus spirituels dans notre manière de donner : prier avant de donner, chercher sincèrement la face de Dieu, rester sensible à la voix du Saint-Esprit, et donner avec une joie authentique plutôt que par une quelconque forme de contrainte.

PAR UNE CONVICTION PERSONNELLE

Le dernier aspect, celui que l'on pourrait qualifier de niveau de perfection dans cette démarche, c'est lorsque Dieu lui-même nous parle directement, dans le cadre d'une conviction toute personnelle. On se trouve alors simplement dans notre quotidien, et Dieu se lève, pour ainsi dire, pour nous dire clairement qu'il faut donner pour telle œuvre précise ou pour tel serviteur en particulier. Avant même de donner quoi que ce soit, il convient de discuter avec Dieu dans le secret, sans se précipiter d'aucune manière. Il faut également prendre le temps de vérifier si cette offrande va véritablement faire avancer le royaume de Dieu, si elle va réellement contribuer à faire progresser l'Évangile de manière concrète. Il est essentiel, à ce stade, d'éprouver les esprits, car la Bible nous enseigne clairement que les brebis de Dieu reconnaissent sa voix parmi toutes les autres. C'est précisément la paix intérieure ressentie, la confirmation reçue à travers la Parole de Dieu, et le témoignage intime du Saint-Esprit dans notre cœur qui confirment ensemble que c'est bel et bien Dieu qui nous parle en cet instant. Une fois cette conviction pleinement établie, il ne reste plus qu'à agir en conséquence : donner dans le secret, sans faire aucun bruit autour de ce geste, avec une joie sincère, sachant pertinemment que Dieu voit tout ce que nous faisons dans le secret, et qu'il nous récompensera lui-même en retour.$edm$, $edm$✅ Acquis, je maîtrise bien : ...

⏳ En cours, je comprends mais je dois approfondir : ...

🔄 À travailler, je dois revenir dessus plus tard : ...

(Exemples de points à évaluer : l'exigence du Nouveau Testament · les trois manières dont l'offrande est présentée · répondre à un appel · répondre à un enseignement · répondre à une conviction personnelle · donner dans le secret.)$edm$, true, true);

-- 6. Les 210 questions (6 par module)
INSERT INTO public.formation_questions (module_id, ordre, question, option_a, option_b, option_c, option_d, bonne_reponse, explication)
SELECT m.id, v.ordre, v.question, v.a, v.b, v.c, v.d, v.rep, v.expl
FROM (VALUES
(1, 1, $edm$La Bible est :$edm$, $edm$Un texte dicté mot à mot par un ange$edm$, $edm$Un ouvrage tombé du ciel tout fait$edm$, $edm$L'histoire d'un peuple réel, Israël, à qui Dieu s'est révélé$edm$, $edm$Un recueil de légendes sans lien avec l'histoire$edm$, 'c', $edm$La Bible est l'histoire d'un peuple réel, Israël, que Dieu a choisi pour transmettre ses préceptes, ses promesses et son plan pour sauver l'humanité.$edm$),
(1, 2, $edm$Que signifie « Parole de Dieu » ?$edm$, $edm$Un texte écrit par Dieu lui-même$edm$, $edm$La révélation de Dieu à travers une histoire humaine documentée$edm$, $edm$Un livre magique$edm$, $edm$Un livre réservé aux prêtres$edm$, 'b', $edm$« Parole de Dieu » signifie que Dieu a parlé dans une histoire réelle, par des témoins humains. Ce n'est pas « écrit par Dieu ».$edm$),
(1, 3, $edm$Quel exemple montre que la Bible n'a pas été dictée mot à mot ?$edm$, $edm$Luc dit qu'il a fait des recherches$edm$, $edm$Les anges ont tout écrit$edm$, $edm$Moïse a écrit sans comprendre$edm$, $edm$Les prophètes ne parlaient jamais avec leurs mots$edm$, 'a', $edm$Luc dit « J'ai fait des recherches » (Luc 1:3). Ce sont des hommes qui écrivent, avec leur style et leur personnalité.$edm$),
(1, 4, $edm$Combien de livres compte la Bible ?$edm$, $edm$66 : 39 pour l'Ancien Testament et 27 pour le Nouveau$edm$, $edm$66 : 27 pour l'Ancien Testament et 39 pour le Nouveau$edm$, $edm$72 livres$edm$, $edm$40 livres, comme le nombre de ses auteurs$edm$, 'a', $edm$66 livres : 39 pour l'Ancien Testament, 27 pour le Nouveau.$edm$),
(1, 5, $edm$Que représentent l'Ancien et le Nouveau Testament ?$edm$, $edm$L'Ancien annule le Nouveau$edm$, $edm$Le Nouveau annule l'Ancien$edm$, $edm$L'Ancien est la promesse, le Nouveau est l'accomplissement$edm$, $edm$Ce sont deux livres sans lien entre eux$edm$, 'c', $edm$L'Ancien Testament annonce et prépare le Messie, le Nouveau révèle son accomplissement en Jésus. La seconde alliance n'annule pas la première, elle l'accomplit.$edm$),
(1, 6, $edm$Comment Jésus a-t-il répondu aux tentations dans le désert ?$edm$, $edm$En ignorant le tentateur$edm$, $edm$En répondant « Il est écrit... »$edm$, $edm$En s'enfuyant$edm$, $edm$En discutant longuement$edm$, 'b', $edm$Comme Jésus dans le désert, nous pouvons répondre « Il est écrit... »$edm$),
(2, 1, $edm$Quels sont les quatre fondements nécessaires pour méditer efficacement ?$edm$, $edm$Lire, écrire, chanter, jeûner$edm$, $edm$Croire en Dieu, croire en Christ, aimer Jésus et son prochain, désirer connaître Jésus$edm$, $edm$Étudier, débattre, enseigner, convaincre$edm$, $edm$Prier, jeûner, donner, servir$edm$, 'b', $edm$Croire en Dieu, croire en Christ, aimer Jésus et son prochain, désirer connaître Jésus.$edm$),
(2, 2, $edm$D'où vient l'intention de méditer la Parole de Dieu ?$edm$, $edm$D'une technique ou d'une discipline extérieure$edm$, $edm$De l'obligation de la communauté$edm$, $edm$Du cœur, de l'amour qu'on porte pour Dieu$edm$, $edm$Du désir d'impressionner les autres$edm$, 'c', $edm$L'intention ne provient pas d'une technique mais du cœur : je médite parce que je veux connaître celui que j'aime.$edm$),
(2, 3, $edm$Laquelle de ces intentions est une mauvaise intention à rejeter ?$edm$, $edm$Lire la Bible pour la sagesse pratique$edm$, $edm$Lire la Bible pour chercher des contradictions et attaquer Dieu$edm$, $edm$Lire la Bible pour l'inspiration$edm$, $edm$Lire la Bible pour la moralité et le bon sens$edm$, 'b', $edm$Attaquer ou contredire Dieu, chercher des contradictions, rejeter Dieu, combattre la chrétienté : ces intentions sont à l'opposé de la vraie méditation. Les autres propositions sont des intentions secondaires, bonnes mais pas ultimes.$edm$),
(2, 4, $edm$Quelle est l'intention ultime de la méditation ?$edm$, $edm$Accumuler des connaissances sur la Bible$edm$, $edm$Développer sa religion$edm$, $edm$Connaître Jésus, dans le but de plaire à Dieu$edm$, $edm$Trouver des stratégies de vie$edm$, 'c', $edm$L'intention parfaite est de méditer dans le but de connaître Jésus, la pierre angulaire, et de plaire à Dieu.$edm$),
(2, 5, $edm$Que veut dire « on peut être religieux sans aimer Jésus-Christ » ?$edm$, $edm$La religion est toujours mauvaise$edm$, $edm$On peut pratiquer et appartenir à une communauté sans avoir un amour profond pour Jésus-Christ$edm$, $edm$Il faut quitter sa communauté pour aimer Jésus$edm$, $edm$Aimer Jésus est interdit dans la religion$edm$, 'b', $edm$On peut être religieux, pratiquer et appartenir à une communauté sans développer un amour profond pour Jésus-Christ.$edm$),
(2, 6, $edm$Quelle est la différence entre la religion et l'amour pour Jésus-Christ ?$edm$, $edm$L'amour pour Jésus dépend de la congrégation à laquelle on appartient$edm$, $edm$La religion et l'amour pour Jésus sont exactement la même chose$edm$, $edm$L'amour pour Jésus ne dépend d'aucune appartenance communautaire : il vient directement du cœur$edm$, $edm$La religion est plus importante que l'amour pour Jésus$edm$, 'c', $edm$L'amour pour Jésus n'est lié à aucune appartenance communautaire. On l'aime parce que notre cœur l'aime, personnellement.$edm$),
(3, 1, $edm$Quels sont les trois rôles de l'Esprit dans la méditation ?$edm$, $edm$Il révèle Jésus, il nous rappelle les versets, il enseigne$edm$, $edm$Il punit, il juge, il corrige$edm$, $edm$Il impressionne, il distrait, il divertit$edm$, $edm$Il écrit, il traduit, il publie$edm$, 'a', $edm$L'Esprit révèle Jésus (il ouvre nos yeux spirituels pour voir Christ dans toute la Bible), il nous rappelle les versets au bon moment, et il enseigne (il illumine notre intelligence).$edm$),
(3, 2, $edm$Que devient la méditation sans l'Esprit ?$edm$, $edm$Une étude littéraire ou intellectuelle$edm$, $edm$Une prière plus puissante$edm$, $edm$Une méditation plus rapide$edm$, $edm$Une méditation qui n'a aucun problème$edm$, 'a', $edm$Sans l'Esprit, la méditation devient une simple étude littéraire ou intellectuelle.$edm$),
(3, 3, $edm$Pourquoi les pharisiens sont-ils donnés en exemple ?$edm$, $edm$Ils ne connaissaient pas les Écritures$edm$, $edm$Ils connaissaient les Écritures par cœur, mais lisaient sans l'Esprit et ont crucifié le Messie qu'elles annonçaient$edm$, $edm$Ils méditaient avec l'Esprit$edm$, $edm$Ils ont refusé de lire la Bible$edm$, 'b', $edm$Les pharisiens connaissaient les Écritures par cœur, mais ils lisaient sans l'Esprit et ont crucifié le Messie qu'elles annonçaient.$edm$),
(3, 4, $edm$Quel est le critère de mesure pour savoir si l'Esprit guide ma méditation ?$edm$, $edm$Le temps que j'y passe$edm$, $edm$Le nombre de versets lus$edm$, $edm$Est-ce que ma méditation me rapproche de Jésus ?$edm$, $edm$La quantité de choses que je retiens$edm$, 'c', $edm$Si ma méditation me rapproche de Jésus, c'est l'œuvre de l'Esprit. Si elle produit orgueil, critique, sécheresse ou division, ce n'est pas l'Esprit qui guide.$edm$),
(3, 5, $edm$Quel est le fruit de l'Esprit dans la méditation ?$edm$, $edm$Orgueil, critique, sécheresse, division$edm$, $edm$Amour croissant, foi fortifiée, humilité, obéissance joyeuse$edm$, $edm$Confusion, doute, colère, indifférence$edm$, $edm$Connaissance sans transformation$edm$, 'b', $edm$Le fruit de l'Esprit : amour croissant, foi fortifiée, humilité, obéissance joyeuse.$edm$),
(3, 6, $edm$Que faire pour inviter l'Esprit avant de lire ?$edm$, $edm$Lire plus vite$edm$, $edm$Compter sur sa seule intelligence$edm$, $edm$Prier : « Esprit Saint, enseigne-moi », rester humble, confesser ses péchés, être disposé à obéir$edm$, $edm$Éviter de prier pour ne pas se laisser distraire$edm$, 'c', $edm$Prier avant de lire, rester humble, confesser ses péchés, être disposé à obéir à ce qu'il révèle, et dépendre de lui plutôt que de sa seule intelligence.$edm$),
(4, 1, $edm$Que vaut-il mieux faire pour bien méditer ?$edm$, $edm$Survoler plusieurs chapitres par jour$edm$, $edm$Lire lentement quelques versets bien compris$edm$, $edm$Lire le plus vite possible$edm$, $edm$Lire seulement les versets célèbres$edm$, 'b', $edm$Quelques versets bien compris valent mieux que des chapitres survolés.$edm$),
(4, 2, $edm$Pourquoi faut-il comprendre le contexte d'un passage ?$edm$, $edm$Pour savoir ce qui se passe avant et après, qui écrit, à qui et pourquoi$edm$, $edm$Pour impressionner les autres$edm$, $edm$Pour éviter de prier$edm$, $edm$Parce que le contexte n'est pas important$edm$, 'a', $edm$Il faut savoir ce qui se passe avant et après le passage, qui écrit, à qui et pourquoi.$edm$),
(4, 3, $edm$Quand un verset te frappe particulièrement, que dois-tu faire ?$edm$, $edm$L'ignorer et continuer à lire$edm$, $edm$T'arrêter, car c'est souvent Dieu qui parle$edm$, $edm$Le noter pour l'oublier ensuite$edm$, $edm$Lire plus vite pour terminer le chapitre$edm$, 'b', $edm$Quand un verset frappe particulièrement, il faut s'arrêter : c'est souvent Dieu qui parle.$edm$),
(4, 4, $edm$Comment appliquer concrètement un passage ?$edm$, $edm$Rester dans des idées générales$edm$, $edm$Se demander quelle décision prendre, quelle attitude corriger, quel péché abandonner, quelle action poser aujourd'hui, de façon spécifique$edm$, $edm$Attendre que les autres l'appliquent d'abord$edm$, $edm$Se contenter de comprendre le texte$edm$, 'b', $edm$Il faut être spécifique : quelle décision prendre, quelle attitude corriger, quel péché abandonner, quelle action poser aujourd'hui.$edm$),
(4, 5, $edm$Quelle est la vraie preuve d'une méditation authentique ?$edm$, $edm$Le nombre de versets mémorisés$edm$, $edm$La durée de la lecture$edm$, $edm$L'obéissance$edm$, $edm$La beauté des paroles$edm$, 'c', $edm$L'obéissance est la vraie preuve d'une méditation authentique.$edm$),
(4, 6, $edm$Que contient un journal spirituel ?$edm$, $edm$La date, le passage, les découvertes, l'application et la prière$edm$, $edm$Seulement les versets copiés$edm$, $edm$Les erreurs des autres$edm$, $edm$Des débats théologiques$edm$, 'a', $edm$Un journal spirituel contient la date, le passage, les découvertes, l'application et la prière.$edm$),
(5, 1, $edm$Où conduit le fait de méditer la Bible pour impressionner les autres ?$edm$, $edm$À une foi plus profonde$edm$, $edm$À l'orgueil spirituel, au mépris des autres croyants et à la division$edm$, $edm$À une meilleure compréhension de Dieu$edm$, $edm$À plus d'humilité$edm$, 'b', $edm$Méditer pour impressionner conduit à l'orgueil spirituel, au mépris des autres croyants, à la division dans l'Église et à l'inefficacité spirituelle.$edm$),
(5, 2, $edm$Qu'est-ce que méditer de façon égoïste ?$edm$, $edm$Lire la Bible avec amour$edm$, $edm$Lire la Bible seulement pour résoudre ses problèmes, comme une formule magique, sans chercher Dieu lui-même$edm$, $edm$Lire la Bible en groupe$edm$, $edm$Lire la Bible chaque jour$edm$, 'b', $edm$Méditer de façon égoïste, c'est lire la Bible comme une formule magique, uniquement pour résoudre ses problèmes, sans chercher Dieu lui-même, sans désir de transformation et sans souci d'obéissance.$edm$),
(5, 3, $edm$Que révèle le fait de lire la Bible pour chercher des contradictions et contredire Dieu ?$edm$, $edm$Un cœur humble$edm$, $edm$Un cœur curieux$edm$, $edm$Un cœur rebelle, qui veut rester maître de sa propre vie$edm$, $edm$Un cœur sincère qui cherche la vérité$edm$, 'c', $edm$Un esprit critique destructeur révèle un cœur rebelle, qui ne cherche pas vraiment la vérité mais qui veut rester maître de sa propre vie.$edm$),
(5, 4, $edm$Quelle est l'erreur « particulièrement subtile et dangereuse » ?$edm$, $edm$Lire la Bible trop lentement$edm$, $edm$Se servir de la Parole pour justifier son péché au lieu de se laisser corriger$edm$, $edm$Méditer à voix haute$edm$, $edm$Méditer le matin$edm$, 'b', $edm$Prendre la Parole de Dieu non pas pour se laisser corriger par elle, mais pour justifier son péché, est l'erreur la plus subtile et la plus dangereuse.$edm$),
(5, 5, $edm$Que doit toujours rester la Parole de Dieu ?$edm$, $edm$Un outil pour justifier nos idées$edm$, $edm$Un outil pour contrôler les autres$edm$, $edm$Ce qui nous corrige, une boussole, jamais ce qui nous couvre$edm$, $edm$Un livre qu'on consulte seulement quand on en a besoin$edm$, 'c', $edm$La Parole doit toujours rester ce qui nous corrige, une boussole et un baromètre, jamais ce qui nous couvre.$edm$),
(5, 6, $edm$Lequel de ces comportements est un piège courant de la méditation ?$edm$, $edm$Lire en priant$edm$, $edm$Appliquer ce qu'on lit$edm$, $edm$Éviter les passages dérangeants$edm$, $edm$Partager avec d'autres croyants$edm$, 'c', $edm$Parmi les autres pièges : lire sans prier, ignorer le contexte, ne jamais appliquer, être irrégulier, éviter les passages dérangeants, s'isoler.$edm$),
(6, 1, $edm$Invoquer Dieu, c'est :$edm$, $edm$Prouver que Dieu existe en parlant de Lui$edm$, $edm$Faire un exercice religieux pour montrer sa foi$edm$, $edm$Appeler Dieu pour qu'Il réponde et se manifeste$edm$, $edm$Reconnaître simplement que Dieu est partout$edm$, 'c', $edm$Invoquer, c'est appeler Dieu pour qu'Il réponde et se manifeste. Ce n'est ni une preuve de l'existence de Dieu (A), ni un exercice religieux (B), ni une simple reconnaissance intellectuelle (D).$edm$),
(6, 2, $edm$Celui qui invoque Dieu doit s'attendre à :$edm$, $edm$Ce que Dieu exauce exactement tout ce qu'il demande$edm$, $edm$Ce que Dieu réponde$edm$, $edm$Ce qu'il doive attendre longtemps en silence$edm$, $edm$Ce qu'il ressente une émotion forte$edm$, 'b', $edm$Celui qui invoque s'attend à une seule chose : que Dieu réponde.$edm$),
(6, 3, $edm$Quelle est la différence entre prier et invoquer ?$edm$, $edm$Prier, c'est appeler ; invoquer, c'est demander$edm$, $edm$Prier, c'est demander et attendre l'exaucement ; invoquer, c'est appeler jusqu'à ce que Dieu réponde$edm$, $edm$Il n'y a aucune différence$edm$, $edm$La prière est courte, l'invocation est longue$edm$, 'b', $edm$La prière demande et attend l'exaucement. L'invocation appelle et exige une réponse.$edm$),
(6, 4, $edm$Pourquoi répéter l'appel n'est-il pas une « vaine parole » ?$edm$, $edm$Parce que c'est une technique pour persuader Dieu$edm$, $edm$Parce que Dieu n'entend qu'à la centième fois$edm$, $edm$Parce que c'est l'insistance de celui qui réclame une présence, jusqu'à ce qu'elle réponde$edm$, $edm$Parce que cela montre aux autres qu'on a la foi$edm$, 'c', $edm$La répétition n'est pas une technique pour persuader Dieu : c'est l'insistance de celui qui réclame une présence, jusqu'à ce que la personne réponde.$edm$),
(6, 5, $edm$Quelle affirmation est vraie ?$edm$, $edm$Dieu exauce toujours toute prière$edm$, $edm$Dieu peut dire non à une prière, mais Il ne peut pas ne pas répondre à une invocation faite correctement$edm$, $edm$Dieu ne répond qu'à celui qui prie longtemps$edm$, $edm$Dieu ne répond que dans les lieux de culte$edm$, 'b', $edm$Dieu peut ne pas exaucer une prière qui n'est pas dans Sa volonté, mais Il ne peut pas ne pas répondre à l'invocation.$edm$),
(6, 6, $edm$Quels sont les trois buts de Dieu quand Il répond à l'invocation ?$edm$, $edm$Résoudre nos problèmes, nous enrichir, nous protéger$edm$, $edm$Manifester Sa présence réelle, révéler les choses cachées, transmettre la connaissance$edm$, $edm$Nous punir, nous éprouver, nous corriger$edm$, $edm$Nous faire plaisir, nous consoler, nous distraire$edm$, 'b', $edm$Manifester Sa présence réelle, révéler les choses cachées, transmettre la connaissance. Ces buts vont bien au-delà de la simple résolution de nos problèmes.$edm$),
(7, 1, $edm$Pourquoi faut-il connaître les noms de Dieu avant de L'invoquer ?$edm$, $edm$Pour impressionner les autres par ses connaissances$edm$, $edm$Parce qu'on n'appelle pas quelqu'un qu'on ne connaît pas, et qu'un nom révèle ce que Dieu est$edm$, $edm$Parce que Dieu n'écoute que ceux qui connaissent tous ses noms$edm$, $edm$Parce que c'est une obligation religieuse sans importance pour l'invocation$edm$, 'b', $edm$On n'appelle pas un inconnu. Un nom révèle ce que Dieu est : le connaître, c'est connaître son caractère.$edm$),
(7, 2, $edm$Jéhovah et Yahweh sont :$edm$, $edm$Deux dieux différents$edm$, $edm$Le même nom (YHWH), transcrit de deux façons$edm$, $edm$Deux noms du Fils$edm$, $edm$Deux noms du Saint-Esprit$edm$, 'b', $edm$C'est le même nom, celui que les Hébreux écrivaient YHWH. « Jéhovah » est la forme traditionnelle en français, « Yahweh » la transcription la plus courante des spécialistes.$edm$),
(7, 3, $edm$Quel est le rôle du poème dans ce cours ?$edm$, $edm$Il sert de formule pour invoquer Dieu$edm$, $edm$Il sert de formule magique qui force Dieu à répondre$edm$, $edm$Il sert à mémoriser les noms de Dieu et leur sens, comme un chant aide les enfants à retenir leurs leçons$edm$, $edm$Il remplace l'invocation$edm$, 'c', $edm$Le poème sert à mémoriser les noms de Dieu et leur sens. Ce n'est ni une formule pour invoquer, ni une formule magique, et il ne remplace pas l'invocation.$edm$),
(7, 4, $edm$Que veut dire Jéhovah Jiré ?$edm$, $edm$L'Éternel qui guérit$edm$, $edm$L'Éternel est là$edm$, $edm$L'Éternel pourvoira$edm$, $edm$L'Éternel ma bannière$edm$, 'c', $edm$Jéhovah Jiré : l'Éternel pourvoira.$edm$),
(7, 5, $edm$Parmi ces propositions, laquelle est un nom qui dit ce que Dieu est (il commence par « Il est ») ?$edm$, $edm$Jéhovah Nissi$edm$, $edm$Il est l'Alpha et l'Oméga$edm$, $edm$El Olam$edm$, $edm$Elohim$edm$, 'b', $edm$« Il est l'Alpha et l'Oméga » dit ce que Dieu est. Jéhovah Nissi, El Olam et Elohim sont des noms hébreux que l'on traduit.$edm$),
(7, 6, $edm$Quelle est la bonne manière de dire un nom de Dieu pour que la connaissance devienne une relation ?$edm$, $edm$Le réciter sans y penser, comme une liste$edm$, $edm$Le lire seulement dans sa tête$edm$, $edm$Le dire pour soi : « l'Éternel est ma paix », « il est mon Berger »$edm$, $edm$Le garder pour soi sans jamais le dire à voix haute$edm$, 'c', $edm$On dit chaque nom pour soi, à voix haute : c'est ce qui transforme un savoir en relation.$edm$),
(8, 1, $edm$Que se passe-t-il si tu cries « Monsieur ! » dans un lieu public bondé ?$edm$, $edm$La personne concernée répond aussitôt$edm$, $edm$Personne ne répond, ou tout le monde se retourne sans savoir qui est concerné$edm$, $edm$La foule s'écarte$edm$, $edm$La personne que tu cherches vient vers toi$edm$, 'b', $edm$L'appel est dilué : il manque de cible, il n'a pas de puissance. Appelé par un nom précis, la personne concernée réagit aussitôt.$edm$),
(8, 2, $edm$Que signifie « JE SUIS », le nom sous lequel Dieu s'est révélé ?$edm$, $edm$Un nom statique, figé$edm$, $edm$Une identité en mouvement : la réponse immédiate et exacte à la réalité que tu traverses$edm$, $edm$Un nom réservé à une seule époque$edm$, $edm$Un titre sans lien avec nos besoins$edm$, 'b', $edm$Dieu n'est pas un nom figé : Il est la réponse immédiate et exacte à la réalité que tu traverses au moment où tu L'appelles.$edm$),
(8, 3, $edm$Quelle est l'erreur fatale dans l'invocation ?$edm$, $edm$Invoquer trop longtemps$edm$, $edm$Invoquer n'importe comment, avec des termes vagues et généraux$edm$, $edm$Invoquer à voix haute$edm$, $edm$Invoquer en groupe$edm$, 'b', $edm$Invoquer « n'importe comment », avec des termes vagues, est une erreur de connaissance qui paralyse la réponse.$edm$),
(8, 4, $edm$Où réside la puissance de l'invocation ?$edm$, $edm$Dans la force de la voix$edm$, $edm$Dans la durée de l'appel$edm$, $edm$Dans la précision : savoir qui on appelle$edm$, $edm$Dans la beauté des paroles$edm$, 'c', $edm$La puissance réside dans la précision : c'est la connaissance précise de ses noms et de ses attributs qui rend l'invocation irrésistible.$edm$),
(8, 5, $edm$Si tu es malade, quel attribut de Dieu invoques-tu ?$edm$, $edm$Le Pourvoyeur, Jéhovah Jiré$edm$, $edm$Le Guérisseur, Jéhovah Rapha$edm$, $edm$La Lumière$edm$, $edm$Le Guerrier$edm$, 'b', $edm$Le Guérisseur, Jéhovah Rapha : « Je suis l'Éternel qui te guérit ».$edm$),
(8, 6, $edm$Si tu te sens seul et abandonné, quel attribut de Dieu invoques-tu ?$edm$, $edm$L'Ami, le Compagnon, Celui qui ne t'abandonne jamais$edm$, $edm$Le Pourvoyeur$edm$, $edm$Le Guérisseur$edm$, $edm$Le Guerrier$edm$, 'a', $edm$L'Ami, le Compagnon, Celui qui ne t'abandonne jamais.$edm$),
(9, 1, $edm$Quelles sont les trois choses pratiques pour se mettre en position avant d'invoquer ?$edm$, $edm$Crier, pleurer, attendre$edm$, $edm$Poser, entrer, se disposer$edm$, $edm$Lire, chanter, jeûner$edm$, $edm$Demander, supplier, remercier$edm$, 'b', $edm$Poser, entrer, se disposer : poser ce qui t'entoure, entrer dans le règne de l'esprit au nom de Jésus, te disposer à appeler Dieu.$edm$),
(9, 2, $edm$Peut-on se déconnecter du monde par ses seules forces avant d'invoquer ?$edm$, $edm$Oui, d'un seul coup, par la volonté$edm$, $edm$Non : on décide de poser, et c'est l'invocation incessante qui réalise la déconnexion$edm$, $edm$Oui, mais seulement en groupe$edm$, $edm$Il n'est pas nécessaire de se déconnecter$edm$, 'b', $edm$Humainement, on ne peut pas se déconnecter seul. On décide de poser, et c'est l'invocation incessante qui réalise la déconnexion.$edm$),
(9, 3, $edm$Pendant les cinq premières minutes, tu ne sens rien. Que fais-tu ?$edm$, $edm$Tu t'arrêtes, car Dieu ne répond pas$edm$, $edm$Tu changes de nom$edm$, $edm$Tu continues quand même, car c'est le début du vidage$edm$, $edm$Tu attends en silence$edm$, 'c', $edm$C'est normal de ne rien sentir au début. Continue : tu es en train de commencer le processus de vidage.$edm$),
(9, 4, $edm$Pourquoi le « mieux » n'est-il pas l'objectif de l'invocation ?$edm$, $edm$Parce que se sentir mieux est mauvais$edm$, $edm$Parce que l'objectif est la réponse de Dieu, et non seulement un apaisement$edm$, $edm$Parce qu'il faut souffrir pour être entendu$edm$, $edm$Parce que le calme ne dure jamais$edm$, 'b', $edm$L'objectif est la réponse de Dieu. Beaucoup abandonnent quand ils se sentent mieux, alors que la réponse n'est pas encore venue.$edm$),
(9, 5, $edm$Comment reconnaître la voix du Saint-Esprit ?$edm$, $edm$Elle crie fort et provoque la peur$edm$, $edm$Elle apporte la paix, est alignée avec la Parole de Dieu et porte une autorité qui n'est pas la tienne$edm$, $edm$Elle ressemble à tes propres pensées qui vagabondent$edm$, $edm$Elle est toujours une voix audible comme celle d'un homme$edm$, 'b', $edm$La voix du Saint-Esprit apporte la paix, même quand elle corrige, elle est alignée avec la Parole de Dieu, et elle porte une autorité qui n'est pas la tienne.$edm$),
(9, 6, $edm$Combien de temps dois-tu invoquer ?$edm$, $edm$Deux ou trois minutes suffisent$edm$, $edm$Toujours exactement une heure$edm$, $edm$Jusqu'à ce que Dieu réponde par son Saint-Esprit$edm$, $edm$Jusqu'à ce que tu te sentes mieux$edm$, 'c', $edm$Jusqu'à ce que Dieu réponde : 5 minutes, une heure, plusieurs heures, ou plusieurs jours.$edm$),
(10, 1, $edm$Quel est l'objectif de l'invocation pour la communion ?$edm$, $edm$Régler un problème précis$edm$, $edm$Obtenir un miracle$edm$, $edm$Habiter avec la Vie elle-même, être avec Dieu$edm$, $edm$Prouver sa foi aux autres$edm$, 'c', $edm$Dans la communion, l'objectif n'est plus de régler un problème ni d'obtenir quelque chose : c'est d'habiter avec la Vie elle-même.$edm$),
(10, 2, $edm$Faut-il être dans la détresse pour invoquer Dieu ?$edm$, $edm$Oui, sinon Dieu n'écoute pas$edm$, $edm$Non : on peut L'invoquer simplement pour être avec Lui$edm$, $edm$Oui, mais seulement le matin$edm$, $edm$Non, mais seulement dans un lieu de culte$edm$, 'b', $edm$On n'a pas besoin d'être dans la détresse. Appeler Dieu parce qu'on désire Sa présence est même la dimension la plus élevée de l'invocation.$edm$),
(10, 3, $edm$Quand tu invoques Dieu pour la communion et qu'Il répond, qui se manifeste ?$edm$, $edm$Un ange$edm$, $edm$Le Saint-Esprit$edm$, $edm$Une émotion passagère$edm$, $edm$Une voix extérieure$edm$, 'b', $edm$C'est le Saint-Esprit qui se manifeste : Dieu présent avec toi, en toi, maintenant.$edm$),
(10, 4, $edm$Quelles sont les trois missions du Saint-Esprit quand Il vient ?$edm$, $edm$Punir, juger, corriger$edm$, $edm$T'enseigner, te conduire, te consoler$edm$, $edm$T'enrichir, te protéger, te distraire$edm$, $edm$Te surprendre, te tester, te cacher la vérité$edm$, 'b', $edm$Le Saint-Esprit vient t'enseigner, te conduire et te consoler.$edm$),
(10, 5, $edm$Que signifie Parakletos ?$edm$, $edm$Celui qui punit$edm$, $edm$Celui qui est appelé aux côtés, le Consolateur$edm$, $edm$Celui qui juge$edm$, $edm$Celui qui reste caché$edm$, 'b', $edm$Parakletos veut dire « celui qui est appelé aux côtés » : c'est le Consolateur.$edm$),
(10, 6, $edm$Que produit la connaissance intime de Dieu dans l'invocation ?$edm$, $edm$Du doute et du tremblement$edm$, $edm$Une invocation au hasard$edm$, $edm$De l'autorité et une assurance totale : on sait que Dieu répond$edm$, $edm$Une dépendance aux émotions spirituelles$edm$, 'c', $edm$La connaissance intime de Dieu permet d'invoquer avec autorité et assurance : tu ne t'attends plus à ce qu'Il réponde, tu sais qu'Il répond.$edm$),
(11, 1, $edm$Que signifie le latin precaria, d'où vient le mot « prière » ?$edm$, $edm$Obtenu par la prière, par la demande$edm$, $edm$Parler à voix basse$edm$, $edm$Chanter pour Dieu$edm$, $edm$Attendre en silence$edm$, 'a', $edm$Le mot prière vient du latin precaria, qui signifie obtenu par la prière, par la demande.$edm$),
(11, 2, $edm$Que signifie proseuché, en grec biblique ?$edm$, $edm$Une requête spécifique pour un besoin particulier$edm$, $edm$Prière adressée à Dieu, avec l'idée de s'approcher de Dieu pour Lui parler$edm$, $edm$Des supplications$edm$, $edm$Une promesse de Dieu$edm$, 'b', $edm$Proseuché signifie prière adressée à Dieu, s'approcher de Dieu pour Lui parler. Déesis désigne une requête spécifique.$edm$),
(11, 3, $edm$Comment peut-on définir la prière ?$edm$, $edm$Une simple récitation de mots$edm$, $edm$Une communication multidimensionnelle avec Dieu, qui engage l'esprit, l'âme et le corps$edm$, $edm$Une demande qui ne s'adresse qu'à soi-même$edm$, $edm$Un moment réservé aux lieux de culte$edm$, 'b', $edm$La prière est une communication multidimensionnelle avec Dieu : elle engage l'esprit, l'âme et le corps, et transcende le temps et l'espace.$edm$),
(11, 4, $edm$Quel type de prière est fondamental et prioritaire ?$edm$, $edm$La prière de demande$edm$, $edm$La prière d'invocation : toute prière doit commencer par elle$edm$, $edm$La prière d'intercession$edm$, $edm$Aucune : elles se valent toutes$edm$, 'b', $edm$L'invocation est un type de prière fondamental et prioritaire. Toute prière doit commencer par l'invocation divine.$edm$),
(11, 5, $edm$D'où vient la foi, selon la Bible ?$edm$, $edm$De ce qu'on entend, et ce qu'on entend vient des paroles de Christ$edm$, $edm$De l'effort personnel$edm$, $edm$De la quantité de prières dites$edm$, $edm$De la tradition familiale$edm$, 'a', $edm$La foi vient de ce qu'on entend, et ce qu'on entend vient des paroles de Christ.$edm$),
(11, 6, $edm$Pourquoi ne faut-il pas « demander pour demander » ?$edm$, $edm$Parce que Dieu n'aime pas les demandes$edm$, $edm$Parce qu'il faut demander selon une foi éduquée aux valeurs du royaume, sinon il n'y aura pas d'exaucement$edm$, $edm$Parce qu'il vaut mieux se taire$edm$, $edm$Parce que Dieu connaît déjà tout$edm$, 'b', $edm$Il faut demander selon une foi éduquée aux valeurs du royaume. Sinon, il n'y aura aucunement un exaucement.$edm$),
(12, 1, $edm$Comment faut-il demander, selon Jacques 1:6 ?$edm$, $edm$En espérant peut-être recevoir$edm$, $edm$Avec foi, sans douter$edm$, $edm$En répétant longtemps$edm$, $edm$Avec des mots recherchés$edm$, 'b', $edm$Il faut demander avec foi, sans douter : celui qui doute est semblable au flot de la mer, agité par le vent et poussé de côté et d'autre.$edm$),
(12, 2, $edm$Que dit Jésus en Marc 11:24 ?$edm$, $edm$Demandez et attendez longtemps$edm$, $edm$Croyez que vous avez déjà reçu, et vous le verrez s'accomplir$edm$, $edm$Demandez seulement ce qui est facile$edm$, $edm$Ne demandez que le dimanche$edm$, 'b', $edm$Jésus nous enseigne à croire que nous avons déjà reçu au moment même où nous prions.$edm$),
(12, 3, $edm$Que signifie le mot grec symphoneo, d'où vient « s'accorder » ?$edm$, $edm$Chanter ensemble$edm$, $edm$Être en harmonie, en symphonie : avoir la même foi, la même vision, le même esprit$edm$, $edm$Prier en silence$edm$, $edm$Être d'accord seulement en paroles$edm$, 'b', $edm$Symphoneo veut dire être en harmonie, en symphonie. C'est plus qu'être d'accord intellectuellement.$edm$),
(12, 4, $edm$Qu'est-ce qui porte la prière d'accord ?$edm$, $edm$La mesure de foi de chacun$edm$, $edm$Le nombre de personnes présentes$edm$, $edm$L'unité : deux personnes qui veulent réellement la même chose devant Dieu$edm$, $edm$La durée de la prière$edm$, 'c', $edm$Ce n'est pas la mesure de foi de chacun qui porte la prière, mais l'unité : deux personnes qui veulent réellement la même chose devant Dieu, avec le même cœur et la même attente.$edm$),
(12, 5, $edm$Quelle est la première condition de Jean 15:7 ?$edm$, $edm$Connaître beaucoup de versets$edm$, $edm$Demeurer en Christ, avant que ses paroles demeurent en nous$edm$, $edm$Prier très longtemps$edm$, $edm$Jeûner$edm$, 'b', $edm$La première condition n'est pas la parole, c'est la demeure : « si vous demeurez en moi », puis seulement « et que mes paroles demeurent en vous ».$edm$),
(12, 6, $edm$Pourquoi faut-il discerner les paroles que Dieu a laissées pour sa vie ?$edm$, $edm$Pour que ses prières restent vaines$edm$, $edm$Pour ne pas réclamer sur une parole qui n'a pas été donnée$edm$, $edm$Parce que la Bible ne contient aucune parole pour nous$edm$, $edm$Parce que Dieu parle rarement$edm$, 'b', $edm$Si on ne connaît pas les paroles que Dieu a laissées pour sa vie, ses prières sont vaines : on réclame sur une parole qui n'a pas été donnée.$edm$),
(13, 1, $edm$Que cherche la prière « pour chercher Dieu » ?$edm$, $edm$Une délivrance précise$edm$, $edm$La face de Dieu Lui-même, sans rien demander$edm$, $edm$Un miracle$edm$, $edm$La réponse à une décision à prendre$edm$, 'b', $edm$Cette prière vise la face de Dieu Lui-même. Ce n'est pas une question de délivrance ou de réaliser quelque chose de spécifique.$edm$),
(13, 2, $edm$Comment chercher Dieu ?$edm$, $edm$En se mettant à l'écart, en abandonnant toute demande et en chérissant Sa présence$edm$, $edm$En présentant une longue liste de demandes$edm$, $edm$En parlant le plus possible$edm$, $edm$En ne cherchant que dans un lieu de culte$edm$, 'a', $edm$Chercher Dieu nécessite de se mettre à l'écart de toutes pensées qui pourraient remplir nos cœurs, d'abandonner toute demande, et de chérir Sa présence sans fin.$edm$),
(13, 3, $edm$Comment parler à Dieu ?$edm$, $edm$Comme à un étranger, avec des formules froides$edm$, $edm$Comme à un ami proche, en partageant ses joies, ses peines et ses questions, et en étant attentif$edm$, $edm$Seulement en cas d'urgence$edm$, $edm$Sans attendre de réponse$edm$, 'b', $edm$On parle à Dieu comme à un ami proche. Cela demande d'être attentif, avec une sensibilité à l'Esprit.$edm$),
(13, 4, $edm$Que montre l'exemple de David face aux Philistins (2 Samuel 5) ?$edm$, $edm$Il a utilisé la même stratégie à chaque fois$edm$, $edm$Même adversaire, stratégie différente : ce que Dieu a dit hier ne dispense pas de Le consulter aujourd'hui$edm$, $edm$Il n'a pas eu besoin de consulter Dieu$edm$, $edm$Il a suivi l'avis des hommes$edm$, 'b', $edm$David consulte l'Éternel deux fois face au même ennemi, et la stratégie est différente. Ce que Dieu a dit hier ne dispense pas de Le consulter aujourd'hui.$edm$),
(13, 5, $edm$Pourquoi Josué a-t-il été trompé par les Gabaonites ?$edm$, $edm$Parce qu'il a consulté Dieu trop longtemps$edm$, $edm$Parce qu'il n'a pas consulté l'Éternel$edm$, $edm$Parce qu'il n'avait pas de provisions$edm$, $edm$Parce qu'il a obéi à Dieu$edm$, 'b', $edm$Ils prirent de leurs provisions, et ne consultèrent point l'Éternel. Josué a agi sur ses propres conclusions.$edm$),
(13, 6, $edm$Comment Dieu peut-Il répondre à celui qui Le consulte ?$edm$, $edm$Seulement par une voix forte et audible$edm$, $edm$Par une pensée qui s'impose, un passage de la Parole, la paix intérieure, des circonstances ou le conseil de frères matures$edm$, $edm$Jamais$edm$, $edm$Seulement par les songes$edm$, 'b', $edm$Dieu peut répondre par une pensée qui n'est pas la nôtre et qui revient, par un passage de la Parole, par la paix intérieure, par les circonstances, ou par le conseil de frères matures.$edm$),
(14, 1, $edm$Quel est le principe fondamental de la prière pour se bâtir ?$edm$, $edm$On se rattache la Parole d'abord par la situation$edm$, $edm$On se rattache la Parole d'abord par la vie : la vie se bâtit, car elle est permanente, la situation se règle, car elle est temporaire$edm$, $edm$On prie seulement pour régler des problèmes$edm$, $edm$On évite de prier par l'Esprit$edm$, 'b', $edm$La vie se bâtit, car elle est permanente. La situation se règle, car elle est temporaire. On prie d'abord pour devenir une personne établie dans la Parole et dans l'Esprit.$edm$),
(14, 2, $edm$En quoi consiste la prière pour se bâtir ?$edm$, $edm$À prier par l'Esprit et par la Parole$edm$, $edm$À prier seulement par la Parole$edm$, $edm$À prier seulement en groupe$edm$, $edm$À prier sans l'Esprit$edm$, 'a', $edm$Prier pour se bâtir consiste à prier par l'Esprit et par la Parole.$edm$),
(14, 3, $edm$À quoi sert d'abord la prière en langues ?$edm$, $edm$À impressionner les autres$edm$, $edm$À l'édification personnelle du croyant : c'est l'esprit qui prie, dirigé par le Saint-Esprit$edm$, $edm$À remplacer la lecture de la Bible$edm$, $edm$À éviter de prier$edm$, 'b', $edm$Le parler en langues est donné pour l'édification personnelle du croyant. C'est l'esprit qui prie, dirigé par le Saint-Esprit, contournant notre intelligence limitée.$edm$),
(14, 4, $edm$Comment décrit-on la prière par sensibilité à l'Esprit ?$edm$, $edm$Une prière intellectuelle et planifiée$edm$, $edm$Une prière spontanée et dirigée par l'Esprit, qui permet de prier avec précision$edm$, $edm$Une prière toujours silencieuse$edm$, $edm$Une prière réservée à certaines personnes$edm$, 'b', $edm$Cette prière n'est pas intellectuelle ou planifiée, mais spontanée et dirigée par l'Esprit. Elle permet de prier avec précision, même pour des situations dont on ignore les détails.$edm$),
(14, 5, $edm$Que signifie stenagmos alaletos ?$edm$, $edm$Des chants de louange$edm$, $edm$Des soupirs inexprimables : des gémissements qui ne peuvent être articulés en mots humains$edm$, $edm$Des paroles prophétiques$edm$, $edm$Des promesses de Dieu$edm$, 'b', $edm$Stenagmos alaletos désigne des gémissements qui ne peuvent être articulés en mots humains, une intercession qui vient des profondeurs de l'esprit.$edm$),
(14, 6, $edm$Que faire quand une personne te vient fortement à l'esprit, avec un poids ou une urgence ?$edm$, $edm$L'ignorer$edm$, $edm$S'arrêter si possible et prier, en laissant l'Esprit prier à travers soi, jusqu'à ce que le fardeau se lève$edm$, $edm$Attendre que la personne t'appelle$edm$, $edm$En parler à tout le monde$edm$, 'b', $edm$C'est l'Esprit Saint qui appelle à intercéder. On s'arrête si possible, on prie, on se laisse guider, jusqu'à ce que le fardeau se lève et qu'une paix vienne.$edm$),
(15, 1, $edm$Que signifie prier par la Parole ?$edm$, $edm$Réciter la Bible sans la comprendre$edm$, $edm$Prier pour se construire spirituellement, en reliant la Parole de Dieu à sa vie concrète$edm$, $edm$Lire la Bible à voix haute$edm$, $edm$Prier seulement pour une situation précise$edm$, 'b', $edm$Prier par la Parole, c'est prier pour se construire spirituellement, en reliant la Parole de Dieu à notre vie concrète pour que ce que nous lisons devienne une réalité pour nous.$edm$),
(15, 2, $edm$Quelles sont les quatre étapes de la prière avec un psaume ?$edm$, $edm$La lecture, l'expression selon le psaume, la personnalisation, les proclamations$edm$, $edm$Le jeûne, la veille, la louange, le silence$edm$, $edm$La demande, l'attente, le doute, l'oubli$edm$, $edm$La mémorisation, la récitation, la copie, la traduction$edm$, 'a', $edm$La lecture (on découvre le texte), l'expression selon le psaume, la personnalisation à notre situation, puis les proclamations.$edm$),
(15, 3, $edm$À quoi sert d'abord la prière avec les psaumes ?$edm$, $edm$À répondre immédiatement à une situation précise$edm$, $edm$À éduquer l'âme, l'aiguiser à la présence de Dieu et bâtir l'esprit comme une forteresse vivante$edm$, $edm$À impressionner les autres$edm$, $edm$À remplacer les autres types de prière$edm$, 'b', $edm$Prier avec les psaumes ne vise pas immédiatement à répondre à une situation précise : cela éduque l'âme, l'aiguise à la présence de Dieu et bâtit l'esprit comme une forteresse vivante.$edm$),
(15, 4, $edm$Que veut dire prier par information historique ?$edm$, $edm$Prier à partir de ce que Dieu a fait dans le passé, qui révèle qui Il est aujourd'hui$edm$, $edm$Raconter l'histoire de sa propre vie$edm$, $edm$Étudier l'histoire des peuples$edm$, $edm$Prier uniquement pour le passé$edm$, 'a', $edm$Les récits bibliques sont des témoignages vivants de la nature immuable de Dieu. Ce que Dieu a fait hier révèle qui Il est aujourd'hui.$edm$),
(15, 5, $edm$Quelles sont les deux catégories principales de promesses ?$edm$, $edm$La promesse de devenir et la promesse d'avenir$edm$, $edm$La promesse de colère et la promesse de pardon$edm$, $edm$La promesse ancienne et la promesse nouvelle$edm$, $edm$La promesse de richesse et la promesse de santé$edm$, 'a', $edm$La promesse de devenir (ce que vous deviendrez) et la promesse d'avenir (ce que Dieu prépare pour vous).$edm$),
(15, 6, $edm$Que déclare Jérémie 29:11 ?$edm$, $edm$Des projets de malheur$edm$, $edm$Des projets de paix et non de malheur, pour donner un avenir et de l'espérance$edm$, $edm$Des projets cachés$edm$, $edm$Des projets sans lien avec nous$edm$, 'b', $edm$Des projets de paix et non de malheur, afin de donner un avenir et de l'espérance.$edm$),
(16, 1, $edm$Qu'est-ce que l'intercession ?$edm$, $edm$Prier uniquement pour soi-même$edm$, $edm$L'acte de se tenir entre Dieu et une autre personne, une situation ou une nation, pour plaider en sa faveur$edm$, $edm$Une technique de prière réservée à quelques-uns$edm$, $edm$Une prière qui n'engage pas le cœur$edm$, 'b', $edm$L'intercession est l'acte de se tenir entre Dieu et une autre personne, ou une situation, ou une nation, pour plaider en sa faveur.$edm$),
(16, 2, $edm$Quel est le fondement de l'intercession ?$edm$, $edm$L'obligation religieuse$edm$, $edm$L'amour du prochain$edm$, $edm$Le désir d'impressionner$edm$, $edm$La peur de Dieu$edm$, 'b', $edm$Intercéder est l'expression naturelle du commandement d'aimer son prochain comme soi-même.$edm$),
(16, 3, $edm$Comment prier pour créer ?$edm$, $edm$Décrire longuement ce qui manque$edm$, $edm$Proclamer au présent, sans regarder le visible, et y revenir$edm$, $edm$Demander seulement pour l'avenir$edm$, $edm$Attendre que la situation change$edm$, 'b', $edm$Trois choses à surveiller : parler au présent, ne pas regarder le visible, y revenir jusqu'à ce que sa propre conscience change.$edm$),
(16, 4, $edm$Dans la prière pour détruire, que détruit-on ?$edm$, $edm$Les personnes qui nous blessent$edm$, $edm$Les œuvres de l'ennemi, jamais les personnes$edm$, $edm$Tout ce qui nous dérange$edm$, $edm$Les opinions des autres$edm$, 'b', $edm$On détruit des œuvres, jamais des personnes. L'adversaire est spirituel. Celui qui blesse humainement, on le bénit.$edm$),
(16, 5, $edm$Comment frapper dans la prière pour détruire ?$edm$, $edm$Avec peur, en criant fort$edm$, $edm$Avec autorité, calmement, depuis sa position en Christ$edm$, $edm$Sans jamais nommer ce qu'on détruit$edm$, $edm$En abandonnant dès le premier jour$edm$, 'b', $edm$Celui qui crie fort parce qu'il a peur ne détruit rien. Celui qui parle calmement depuis sa position en Christ renverse des murailles.$edm$),
(16, 6, $edm$Que signifie la prière comme mode de vie ?$edm$, $edm$Prier seulement en cas de besoin$edm$, $edm$Prier sans cesse : ordonner et structurer sa vie de prière, car elle est la respiration de l'âme$edm$, $edm$Prier seulement le dimanche$edm$, $edm$Prier uniquement en groupe$edm$, 'b', $edm$Priez sans cesse. La prière n'est pas une option, c'est la respiration de l'âme.$edm$),
(17, 1, $edm$Qu'est-ce qu'adorer, simplement dit ?$edm$, $edm$Chanter des cantiques$edm$, $edm$Suraimer : aimer plus que tout, malgré tout, et au-delà de tout$edm$, $edm$Réciter des prières$edm$, $edm$Se rendre dans un lieu de culte$edm$, 'b', $edm$Adorer, c'est suraimer : aimer plus que tout, malgré tout, et au-delà de tout.$edm$),
(17, 2, $edm$Que veut dire littéralement le latin adorare ?$edm$, $edm$Chanter fort$edm$, $edm$Porter sa bouche vers, comme dans le baiser de respect$edm$, $edm$Se tenir debout$edm$, $edm$Lever les mains$edm$, 'b', $edm$Adorare veut dire littéralement « porter sa bouche vers », un geste qui représentait autrefois le baiser de respect.$edm$),
(17, 3, $edm$Que signifie le mot hébreu shachah ?$edm$, $edm$Louer avec éclat$edm$, $edm$Se prosterner profondément$edm$, $edm$Chanter en chœur$edm$, $edm$Offrir un sacrifice$edm$, 'b', $edm$Shachah signifie se prosterner profondément. Halal signifie louer avec éclat.$edm$),
(17, 4, $edm$Que vient en premier dans l'adoration ?$edm$, $edm$L'expression extérieure$edm$, $edm$L'explosion intérieure : un état d'amour qui a explosé dans le cœur$edm$, $edm$Le chant$edm$, $edm$Le lieu$edm$, 'b', $edm$L'adoration est d'abord un état d'amour qui a explosé dans le cœur, bien avant de trouver un point de sortie qu'on appelle l'expression.$edm$),
(17, 5, $edm$Qu'est-ce que l'adoration au milieu des circonstances ?$edm$, $edm$Adorer seulement quand tout va bien$edm$, $edm$L'expression pleine de l'amour pour Dieu même quand Dieu a fait quelque chose ou non, au milieu des réalités$edm$, $edm$Se résigner à la souffrance$edm$, $edm$Éviter de parler de ses difficultés$edm$, 'b', $edm$C'est l'expression pleine de l'amour pour Dieu au milieu des circonstances : on L'aime de tout, malgré tout.$edm$),
(17, 6, $edm$Que montre la déclaration de Job : « L'Éternel a donné, et l'Éternel a ôté ; que le nom de l'Éternel soit béni ! » ?$edm$, $edm$De la résignation$edm$, $edm$De l'adoration pure : un amour qui refuse de dépendre des bénédictions pour exister$edm$, $edm$De la colère contenue$edm$, $edm$De l'indifférence$edm$, 'b', $edm$Ce n'était pas de la résignation, mais de l'adoration pure : un amour qui refuse de dépendre des bénédictions pour exister.$edm$),
(18, 1, $edm$À qui Jésus a-t-Il révélé que Dieu cherche ceux qui L'adorent en esprit et en vérité ?$edm$, $edm$Aux pharisiens$edm$, $edm$À la femme samaritaine$edm$, $edm$À Pierre$edm$, $edm$À Nicodème$edm$, 'b', $edm$Jésus a révélé à la femme samaritaine que Dieu cherche ceux qui L'adorent en esprit et en vérité.$edm$),
(18, 2, $edm$Que veut dire adorer « en vérité » ?$edm$, $edm$Réciter des paroles parfaites$edm$, $edm$Être vrai avec soi-même devant Dieu, sans cacher sa douleur, sa joie ou ses doutes$edm$, $edm$Adorer dans un lieu précis$edm$, $edm$Adorer seulement quand on est joyeux$edm$, 'b', $edm$Adorer en vérité, c'est être vrai avec soi-même devant Dieu : ne pas cacher sa douleur, sa joie ou ses doutes, mais tout apporter à Ses pieds.$edm$),
(18, 3, $edm$Que veut dire adorer « en esprit » ?$edm$, $edm$Utiliser son intelligence et ses mots réfléchis$edm$, $edm$Laisser son esprit communiquer avec l'Esprit de Dieu, par une connexion spirituelle$edm$, $edm$Réciter un texte appris par cœur$edm$, $edm$Adorer en groupe$edm$, 'b', $edm$Adorer en esprit, c'est laisser son esprit communiquer avec l'Esprit de Dieu. Ce n'est plus l'intelligence ni les mots réfléchis, mais une connexion spirituelle.$edm$),
(18, 4, $edm$Que cherche Dieu, selon ce texte ?$edm$, $edm$Des acteurs$edm$, $edm$Des cœurs qui se livrent sans fard$edm$, $edm$Des pratiquants ponctuels$edm$, $edm$Des experts en doctrine$edm$, 'b', $edm$Dieu ne cherche pas des acteurs, Il cherche des cœurs qui se livrent sans fard.$edm$),
(18, 5, $edm$Que représente le cœur qui adore ?$edm$, $edm$L'intelligence$edm$, $edm$Les émotions seulement$edm$, $edm$L'esprit vivifié en nous$edm$, $edm$Le corps$edm$, 'c', $edm$Le cœur qui adore n'est rien d'autre que l'esprit vivifié en nous.$edm$),
(18, 6, $edm$Que signifie l'image du parfum et du flacon ?$edm$, $edm$La vérité est le flacon qui contient le parfum de l'adoration : sans vérité, le parfum se perd ; sans esprit, il n'a pas d'odeur pour Dieu$edm$, $edm$Le parfum est plus important que le flacon$edm$, $edm$Le flacon n'a aucune valeur$edm$, $edm$Le parfum et le flacon sont sans rapport$edm$, 'a', $edm$Si l'adoration est un parfum, la vérité est le flacon qui le contient. Sans vérité, le parfum se perd. Sans esprit, il n'a pas d'odeur pour Dieu.$edm$),
(19, 1, $edm$Quelle est la différence entre l'adoration et le chant ?$edm$, $edm$Ils sont exactement la même chose$edm$, $edm$Le chant est un canal d'expression de l'adoration, mais l'adoration n'est pas le chant$edm$, $edm$Le chant est plus important que l'adoration$edm$, $edm$L'adoration n'existe que par le chant$edm$, 'b', $edm$L'adoration n'est pas le chant. Le chant est un canal d'expression de l'adoration.$edm$),
(19, 2, $edm$Par quoi peut-on adorer sans chanter ?$edm$, $edm$Par un regard, par un soupir, par un silence$edm$, $edm$Par la lecture d'un livre seulement$edm$, $edm$Par un discours long$edm$, $edm$On ne peut pas adorer sans chanter$edm$, 'a', $edm$On peut adorer par un regard, par un soupir, par un silence, parce que le cœur est en train d'exhaler un parfum vers Dieu.$edm$),
(19, 3, $edm$Comment Marie de Béthanie a-t-elle adoré ?$edm$, $edm$En chantant dans la prison$edm$, $edm$En cassant un vase de parfum de grand prix aux pieds de Jésus, sans dire un mot$edm$, $edm$En levant le couteau au-dessus d'Isaac$edm$, $edm$En construisant un autel$edm$, 'b', $edm$Marie de Béthanie a adoré en cassant un vase de parfum de grand prix aux pieds de Jésus, sans dire un mot. Abraham a adoré en levant le couteau au-dessus d'Isaac, Paul et Silas en chantant dans la prison à minuit.$edm$),
(19, 4, $edm$Que produit l'adoration en celui qui adore ?$edm$, $edm$Elle le transforme à l'image de ce qu'il adore$edm$, $edm$Elle ne le change pas$edm$, $edm$Elle le rend orgueilleux$edm$, $edm$Elle l'éloigne de Dieu$edm$, 'a', $edm$L'adoration nous transforme à l'image de ce qu'on adore. C'est une loi spirituelle : on devient semblable à ce sur quoi on fixe nos regards avec admiration et amour.$edm$),
(19, 5, $edm$Que veut dire « partout où un cœur s'exprime en vérité, cet endroit devient le parvis de Dieu » ?$edm$, $edm$L'adoration n'est possible que dans un lieu précis$edm$, $edm$L'adoration n'est pas une question de lieu géographique, mais de disposition de cœur$edm$, $edm$Il faut construire un temple$edm$, $edm$Les lieux n'ont aucune importance pour personne$edm$, 'b', $edm$Ce n'est plus une question de lieu géographique, comme le disait Jésus à la femme samaritaine, mais une question de disposition de cœur.$edm$),
(19, 6, $edm$Qu'est-ce qui brise les chaînes dans l'adoration ?$edm$, $edm$Le transfert de regard : on sort de ses problèmes pour fixer ses regards sur la grandeur de Dieu$edm$, $edm$Le fait de parler de ses problèmes$edm$, $edm$Le fait d'attendre$edm$, $edm$Le fait de chanter fort$edm$, 'a', $edm$C'est ce transfert de regard qui brise les chaînes. Quand Dieu devient plus grand dans ta vision, tes montagnes reprennent leur vraie taille.$edm$),
(20, 1, $edm$Pourquoi l'expression du cœur doit-elle être nourrie ?$edm$, $edm$Parce qu'elle surgit du vide$edm$, $edm$Parce que pour que le cœur déborde vraiment, il doit d'abord être rempli$edm$, $edm$Parce qu'elle n'a pas d'importance$edm$, $edm$Parce qu'elle vient seulement des autres$edm$, 'b', $edm$L'expression du cœur ne surgit pas du vide. Pour que ton cœur déborde vraiment, il doit être rempli.$edm$),
(20, 2, $edm$Quels sont les trois aspects qui nourrissent l'expression du cœur ?$edm$, $edm$Le jeûne, la veille, le silence$edm$, $edm$Le plus grand commandement, la Parole de Dieu, les témoignages vécus avec Dieu$edm$, $edm$La musique, la danse, l'écriture$edm$, $edm$L'argent, le temps, l'énergie$edm$, 'b', $edm$Le plus grand commandement, la Parole de Dieu qui exalte Sa personnalité et Sa toute-puissance, et les témoignages vécus avec Dieu.$edm$),
(20, 3, $edm$Que représente « de toute ton âme », dans le plus grand commandement ?$edm$, $edm$Ton énergie et tes capacités$edm$, $edm$Ta volonté, ton identité profonde, ce que tu es vraiment$edm$, $edm$Ton intelligence$edm$, $edm$Tes émotions$edm$, 'b', $edm$De toute ton âme : ta volonté, ton identité profonde, ce que tu es vraiment. Le cœur est le siège des émotions, la pensée l'intelligence, la force l'énergie et les actions.$edm$),
(20, 4, $edm$Comment faut-il lire la Parole pour nourrir l'adoration ?$edm$, $edm$En cherchant seulement des instructions$edm$, $edm$En découvrant qui Dieu est : la Parole est une révélation de Dieu Lui-même$edm$, $edm$En lisant le plus vite possible$edm$, $edm$En évitant les passages difficiles$edm$, 'b', $edm$Les Écritures ne sont pas seulement un manuel de conduite ou un recueil de promesses : elles sont une révélation de qui Dieu est.$edm$),
(20, 5, $edm$Que sont les témoignages vécus avec Dieu, dans ce texte ?$edm$, $edm$Des histoires d'autres personnes$edm$, $edm$Des moments où tu L'as rencontré, où Il t'a parlé, où Il est intervenu dans ta vie, qui peuvent aussi Lui donner des noms$edm$, $edm$Des souvenirs sans importance$edm$, $edm$Des rêves$edm$, 'b', $edm$Ce sont des moments où tu L'as rencontré personnellement. Ils peuvent aussi qualifier Dieu, Lui donner des noms issus de ton histoire avec Lui.$edm$),
(20, 6, $edm$Que produit un cœur mal nourri, et un cœur bien nourri ?$edm$, $edm$Mal nourri : des expressions pauvres, répétitives, vides. Bien nourri : mille manières de dire « Je T'aime » à Dieu$edm$, $edm$Les deux produisent la même chose$edm$, $edm$Mal nourri : des expressions riches. Bien nourri : le silence$edm$, $edm$Aucune des deux ne produit d'expression$edm$, 'a', $edm$Un cœur mal nourri produit des expressions pauvres, répétitives, vides. Un cœur bien nourri déborde de mille manières de dire « Je T'aime » à Dieu.$edm$),
(21, 1, $edm$Quelles sont les trois étapes de la pratique de l'adoration ?$edm$, $edm$Nourrir le cœur, exprimer le cœur, adorer en esprit et en vérité$edm$, $edm$Jeûner, veiller, chanter$edm$, $edm$Demander, attendre, recevoir$edm$, $edm$Lire, écrire, mémoriser$edm$, 'a', $edm$Première étape : nourrir le cœur. Deuxième : exprimer le cœur. Troisième : adorer en esprit et en vérité.$edm$),
(21, 2, $edm$Pourquoi faut-il d'abord nourrir le cœur ?$edm$, $edm$Parce qu'un cœur vide ne peut pas déborder$edm$, $edm$Parce que c'est une règle sans raison$edm$, $edm$Parce qu'il faut éviter de s'exprimer$edm$, $edm$Parce que l'expression est inutile$edm$, 'a', $edm$Avant de pouvoir adorer avec profondeur, il faut remplir le cœur. Un cœur vide ne peut pas déborder.$edm$),
(21, 3, $edm$Comment lire la Parole pour nourrir l'adoration ?$edm$, $edm$En cherchant seulement des promesses$edm$, $edm$En se demandant : qu'est-ce que ce texte me révèle sur la personnalité et la puissance de Dieu ?$edm$, $edm$En lisant le plus vite possible$edm$, $edm$En évitant les passages difficiles$edm$, 'b', $edm$On plonge dans les Écritures non pas pour chercher des promesses ou des instructions, mais pour découvrir qui Dieu est.$edm$),
(21, 4, $edm$Que faire quand quelque chose de difficile arrive, selon la deuxième étape ?$edm$, $edm$Nier la douleur et prétendre que tout va bien$edm$, $edm$Ne pas adorer tant que la douleur est là$edm$, $edm$Choisir consciemment d'adorer malgré tout, sans nier la douleur, en déclarant qui Dieu est$edm$, $edm$Se plaindre sans rien déclarer$edm$, 'c', $edm$On ne nie pas la douleur et on ne prétend pas que tout va bien, mais au milieu de la réalité on déclare quand même qui Dieu est. C'est cette adoration-là qui a de l'impact.$edm$),
(21, 5, $edm$Comment l'esprit peut-il s'exprimer dans l'adoration en esprit ?$edm$, $edm$Seulement par le chant$edm$, $edm$Par le silence, le parler en langues, le soupir, le gémissement, sans rien forcer$edm$, $edm$Seulement par des mots réfléchis$edm$, $edm$Seulement en groupe$edm$, 'b', $edm$L'important est de laisser son esprit libre de s'exprimer comme il veut : tantôt le silence, tantôt les langues, tantôt un soupir, tantôt un gémissement, parfois un mélange de tout cela.$edm$),
(21, 6, $edm$Que veut dire « l'honnêteté radicale » dans l'adoration en vérité ?$edm$, $edm$Cacher ce qu'on ressent$edm$, $edm$Refuser le mensonge de la performance spirituelle : dire sa fatigue, sa colère, ses doutes ou sa joie$edm$, $edm$Réciter des prières parfaites$edm$, $edm$Ne parler que de ses joies$edm$, 'b', $edm$Refuser le mensonge de la performance spirituelle : si on est fatigué, on le dit ; en colère, on l'exprime ; si on doute, on le partage ; si on est joyeux, on le manifeste.$edm$),
(22, 1, $edm$Qu'est-ce qui différencie la marche avec Dieu des simples actions que nous posons ?$edm$, $edm$La marche concerne avant tout notre manière d'être, liée à notre comportement$edm$, $edm$La marche est plus rapide$edm$, $edm$La marche se fait seul$edm$, $edm$Il n'y a aucune différence$edm$, 'a', $edm$La marche avec Dieu est bien différente des simples actions que nous posons pour réaliser notre destinée : elle concerne avant tout notre manière d'être, directement liée à notre comportement.$edm$),
(22, 2, $edm$Marcher avec Dieu, c'est marcher par quoi ?$edm$, $edm$Par ses propres forces$edm$, $edm$Par Sa Parole et par Son Esprit$edm$, $edm$Par la tradition$edm$, $edm$Par l'avis des hommes$edm$, 'b', $edm$Dieu est esprit et parole : marcher avec Lui, c'est marcher par Sa Parole et par Son Esprit.$edm$),
(22, 3, $edm$Que montre l'image de la marche, avec Énoch ?$edm$, $edm$Un seul pas suffit$edm$, $edm$Il y a un mouvement, un rythme, plusieurs pas, un objectif : un seul pas n'est pas encore une marche$edm$, $edm$La marche n'a pas de but$edm$, $edm$La marche se fait sans direction$edm$, 'b', $edm$Dans la marche, il y a le déplacement, le rythme, un objectif. On ne parle de marche que lorsqu'il y a plusieurs pas.$edm$),
(22, 4, $edm$Que demande l'Éternel, selon Michée 6:8 ?$edm$, $edm$De pratiquer la justice, d'aimer la miséricorde et de marcher humblement avec son Dieu$edm$, $edm$De bâtir des temples$edm$, $edm$D'offrir des sacrifices$edm$, $edm$De parler beaucoup$edm$, 'a', $edm$Michée 6:8 : pratiquer la justice, aimer la miséricorde, marcher humblement avec son Dieu.$edm$),
(22, 5, $edm$Quels sont les trois aspects fondamentaux de la marche avec Dieu ?$edm$, $edm$L'information et la direction, marcher par Sa Parole, marcher par Son Esprit$edm$, $edm$Le jeûne, la veille, le silence$edm$, $edm$Le temps, l'argent, la force$edm$, $edm$La parole, le silence, l'attente$edm$, 'a', $edm$Première chose : l'information et la direction. Deuxième : marcher selon Sa Parole. Troisième : marcher par Son Esprit.$edm$),
(22, 6, $edm$Dans la marche avec Dieu, qui pose les pas ?$edm$, $edm$Nous seuls$edm$, $edm$L'Esprit, qui pose des pas à travers nous : « Ce n'est plus moi qui vis, c'est Christ qui vit en moi »$edm$, $edm$Les circonstances$edm$, $edm$Les autres$edm$, 'b', $edm$Même dans la marche, ce n'est pas nous qui marchons : c'est l'Esprit qui pose des pas à travers nous, comme Paul l'a écrit en Galates 2:20.$edm$),
(23, 1, $edm$Quelle est la première condition pour marcher avec Dieu ?$edm$, $edm$La force physique$edm$, $edm$La soumission totale et entière à Dieu$edm$, $edm$Les connaissances$edm$, $edm$Le temps libre$edm$, 'b', $edm$Pour marcher avec Dieu, il faut une soumission totale et entière. « Soumettez-vous donc à Dieu ; résistez au diable, et il fuira loin de vous. »$edm$),
(23, 2, $edm$Que signifie « apprendre à dominer » ?$edm$, $edm$Dominer les autres$edm$, $edm$Refuser la place de celui qui est influencé et prendre la place de celui qui influence$edm$, $edm$Éviter toute influence$edm$, $edm$Ne jamais décider$edm$, 'b', $edm$Nous devons refuser la place de celui qui est influencé et prendre la place de celui qui influence.$edm$),
(23, 3, $edm$Quelle est la première chose à dominer, selon Romains 8:13 ?$edm$, $edm$Les autres$edm$, $edm$Notre chair$edm$, $edm$Nos circonstances$edm$, $edm$Notre famille$edm$, 'b', $edm$La première chose que nous devons dominer, c'est d'abord notre chair.$edm$),
(23, 4, $edm$Que faire face à l'influence des ténèbres ?$edm$, $edm$L'accepter$edm$, $edm$Faire parler sa voix, et celle de Dieu, plus fort que la voix des ténèbres, car « celui qui est en vous est plus grand que celui qui est dans le monde »$edm$, $edm$Se taire$edm$, $edm$Fuir$edm$, 'b', $edm$Ta voix doit parler plus fort que la voix des ténèbres. La voix de Dieu doit parler encore plus fort que la voix de ce qui t'influence.$edm$),
(23, 5, $edm$Que veut dire « dominer sur tes circonstances » ?$edm$, $edm$Nier ses difficultés$edm$, $edm$Refuser d'être l'objet de sa situation et en faire un objet de gloire, comme David face à Goliath$edm$, $edm$Éviter les épreuves$edm$, $edm$Attendre que les circonstances changent$edm$, 'b', $edm$Refuse d'être l'objet de ta situation, mais fais plutôt de ta situation un objet de gloire. David a vu à travers Goliath une opportunité.$edm$),
(23, 6, $edm$Que se passe-t-il si l'on ne met pas ce fonctionnement dans sa foi ?$edm$, $edm$On vit sa foi pleinement$edm$, $edm$On ne vit pas sa foi, on subit sa situation$edm$, $edm$Il ne se passe rien$edm$, $edm$On devient plus fort$edm$, 'b', $edm$Tant que tu ne mets pas ce fonctionnement dans ta foi, tu ne vas pas vivre ta foi, mais tu vas subir ta situation.$edm$),
(24, 1, $edm$Que demande la troisième condition pour marcher avec Dieu ?$edm$, $edm$Dominer son prochain$edm$, $edm$Développer l'amour pour son prochain : on ne domine pas sur son prochain, on l'aime comme soi-même$edm$, $edm$Éviter les autres$edm$, $edm$Rester seul$edm$, 'b', $edm$Lorsqu'on se place au-dessus de ses circonstances, il faut développer l'amour au milieu des hommes : on ne domine pas sur son prochain, on l'aime comme soi-même.$edm$),
(24, 2, $edm$Que se passe-t-il quand on n'est pas sensible à l'Esprit ?$edm$, $edm$On devient plus patient$edm$, $edm$On devient égocentrique, orgueilleux, sans patience, et le fruit de l'Esprit n'a pas de place en nous$edm$, $edm$Il ne se passe rien$edm$, $edm$On devient plus fort$edm$, 'b', $edm$Lorsqu'on n'est pas sensible, on devient égocentrique, orgueilleux, sans patience, et le fruit de l'Esprit n'a pas de place en nous.$edm$),
(24, 3, $edm$Que dire à Dieu pour rester sensible à l'Esprit ?$edm$, $edm$« Seigneur, je garde le contrôle »$edm$, $edm$« Seigneur, je te laisse toute la place. Pose tes pas à travers moi. »$edm$, $edm$« Seigneur, laisse-moi seul »$edm$, $edm$Rien$edm$, 'b', $edm$Il faut prendre la peine de s'asseoir et de dire à Dieu : « Seigneur, je te laisse toute la place. Pose tes pas à travers moi. »$edm$),
(24, 4, $edm$Que signifie « donner toutes les commandes de sa vie à Dieu » ?$edm$, $edm$Garder le contrôle sur certains domaines$edm$, $edm$Donner place au Saint-Esprit, sinon on vit sous l'influence d'esprits que nous commandons$edm$, $edm$Ne plus prendre de décisions$edm$, $edm$Se désintéresser de sa vie$edm$, 'b', $edm$Marcher avec Dieu, c'est donner place au Saint-Esprit et lui donner toutes les commandes. Sinon on vit sous l'influence d'esprits que nous commandons, qui injectent des systèmes de pensées égarées.$edm$),
(24, 5, $edm$Qu'est-ce que l'intelligence spirituelle que Dieu communique ?$edm$, $edm$Un savoir purement intellectuel$edm$, $edm$La connaissance, le discernement et la réflexion, avec toutes ses actions faites avec la sagesse de l'Esprit$edm$, $edm$Un don réservé à quelques-uns$edm$, $edm$Une forme de ruse$edm$, 'b', $edm$Dieu te donne la connaissance, le discernement et la réflexion. Toutes les actions sont alors faites avec la sagesse de l'Esprit.$edm$),
(24, 6, $edm$Que devient la peur dans la marche avec Dieu ?$edm$, $edm$Elle grandit$edm$, $edm$Elle n'a plus de place, ainsi que la timidité, l'inquiétude et le doute$edm$, $edm$Elle reste identique$edm$, $edm$Elle est nécessaire$edm$, 'b', $edm$La timidité, la peur, l'inquiétude et le doute n'ont plus de place. « Je puis tout par celui qui me fortifie. »$edm$),
(25, 1, $edm$Quel est le premier obstacle à la marche avec Dieu ?$edm$, $edm$Le manque de temps$edm$, $edm$L'orgueil : tracer soi-même un objectif propre et ses propres voies$edm$, $edm$Le manque d'argent$edm$, $edm$Les circonstances$edm$, 'b', $edm$Ce qui peut d'abord nous empêcher de marcher avec Dieu, c'est lorsque nous traçons nous-mêmes un objectif propre et nos propres voies : c'est de l'orgueil.$edm$),
(25, 2, $edm$Que dit Jacques 4:6 ?$edm$, $edm$Dieu aime les orgueilleux$edm$, $edm$Dieu résiste aux orgueilleux, mais il fait grâce aux humbles$edm$, $edm$Dieu ne se soucie pas de l'attitude$edm$, $edm$Dieu récompense la force$edm$, 'b', $edm$« Dieu résiste aux orgueilleux, mais il fait grâce aux humbles » (Jacques 4:6).$edm$),
(25, 3, $edm$Que sont les « autres obstacles » à la marche avec Dieu ?$edm$, $edm$Les œuvres de la chair : l'arrogance, la cupidité, la vanité, les envies, et celles de Galates 5:19-21$edm$, $edm$Le froid$edm$, $edm$La distance$edm$, $edm$La fatigue$edm$, 'a', $edm$Les œuvres de la chair ne nous permettront pas de marcher avec Dieu : arrogance, cupidité, vanité, envies, et celles que Galates 5:19-21 énumère.$edm$),
(25, 4, $edm$Que signifie « être conduit » par l'Esprit ?$edm$, $edm$Se diriger soi-même$edm$, $edm$C'est Dieu qui te conduit : l'Esprit marche à travers toi, comme un chauffeur conduit un véhicule$edm$, $edm$Suivre les autres$edm$, $edm$Attendre sans bouger$edm$, 'b', $edm$Être conduit, c'est Dieu qui te conduit. L'Esprit marche à travers toi.$edm$),
(25, 5, $edm$Que se passe-t-il tant qu'on veut se diriger soi-même ?$edm$, $edm$On marche mieux avec Dieu$edm$, $edm$On n'est pas capable de marcher avec Dieu$edm$, $edm$On devient plus fort$edm$, $edm$Il ne se passe rien$edm$, 'b', $edm$Tant que nous voulons nous diriger nous-mêmes, nous ne sommes pas capables de marcher avec Dieu.$edm$),
(25, 6, $edm$Quelle est l'opposition entre ce qui empêche et ce qui permet de marcher avec Dieu ?$edm$, $edm$La chair empêche ; le fruit de l'Esprit permet$edm$, $edm$Le fruit de l'Esprit empêche ; la chair permet$edm$, $edm$Les deux sont identiques$edm$, $edm$Aucun lien$edm$, 'a', $edm$Ce qui nous empêche de marcher avec Dieu est en rapport avec la chair. Ce qui nous permet de marcher avec Dieu est en rapport avec le fruit de l'Esprit.$edm$),
(26, 1, $edm$Quelles sont les deux sources de l'action ?$edm$, $edm$La vérité (le rêve divin) et la réalité (la nécessité vitale)$edm$, $edm$La peur et le désir$edm$, $edm$La tradition et la loi$edm$, $edm$Le hasard et la chance$edm$, 'a', $edm$La vérité (le rêve divin : la vision que Dieu a pour nous) et la réalité (la nécessité vitale : nos besoins concrets).$edm$),
(26, 2, $edm$Quelle source est prioritaire, selon Matthieu 6:33 ?$edm$, $edm$La réalité, car elle est urgente$edm$, $edm$Le spirituel, qui vient avant le matériel, toujours$edm$, $edm$Les deux sont égales$edm$, $edm$Aucune des deux$edm$, 'b', $edm$Christ enseigne qu'il y a un aspect prioritaire et un aspect secondaire : « Cherchez premièrement le royaume et la justice de Dieu ». Le spirituel vient avant le matériel, toujours.$edm$),
(26, 3, $edm$Quels sont les quatre aspects indispensables pour agir avec Dieu, selon Romains 12:1-2 ?$edm$, $edm$La volonté de Dieu, ce qui est bon, ce qui est agréable, ce qui est parfait$edm$, $edm$Le temps, l'argent, la force, la chance$edm$, $edm$Le jeûne, la veille, la prière, le don$edm$, $edm$La parole, le silence, l'attente, la patience$edm$, 'a', $edm$Afin que vous discerniez quelle est la volonté de Dieu, ce qui est bon, agréable et parfait.$edm$),
(26, 4, $edm$Qu'est-ce qui nous rend agréables à Dieu, et fait passer du projet à l'action ?$edm$, $edm$L'argent$edm$, $edm$La foi$edm$, $edm$Le succès$edm$, $edm$Les connaissances$edm$, 'b', $edm$Sans la foi, il est impossible de Lui être agréable (Hébreux 11:6). C'est la foi qui fait passer du projet identifié à l'action concrète.$edm$),
(26, 5, $edm$Qu'est-ce qui rend l'action parfaite ?$edm$, $edm$Le talent$edm$, $edm$L'amour : il purifie les motivations, fait persévérer, garde de l'orgueil$edm$, $edm$La rapidité$edm$, $edm$Le nombre de projets$edm$, 'b', $edm$L'amour rend l'action parfaite : complète, mature, équilibrée, durable, bénie. Sans l'amour, même les actions faites avec foi peuvent devenir destructrices.$edm$),
(26, 6, $edm$Selon la méthode des quatre questions, que faire si une réponse est négative ?$edm$, $edm$Agir quand même$edm$, $edm$Attendre, prier encore, ou changer de direction$edm$, $edm$Abandonner définitivement$edm$, $edm$Ignorer la question$edm$, 'b', $edm$Si une réponse est négative : attendre, prier encore, ou changer de direction. Si les quatre réponses sont positives, on agit avec confiance.$edm$),
(27, 1, $edm$Que signifie le pragmatisme spirituel ?$edm$, $edm$Croire sans agir$edm$, $edm$Vivre concrètement la vérité reçue dans notre vie à travers la volonté de Dieu et Ses projets$edm$, $edm$Agir sans consulter Dieu$edm$, $edm$Se contenter de bonnes intentions$edm$, 'b', $edm$Il ne s'agit pas seulement de croire, mais de vivre concrètement ce que Dieu nous révèle.$edm$),
(27, 2, $edm$La consultation de Dieu est-elle optionnelle ?$edm$, $edm$Oui, seulement pour les décisions importantes$edm$, $edm$Non : elle est vitale, impérative pour toute action$edm$, $edm$Oui, pour les croyants matures$edm$, $edm$Oui, si l'on connaît déjà la volonté de Dieu$edm$, 'b', $edm$La consultation n'est pas optionnelle, c'est vital : il faut savoir comment sera la chose, comment mener l'action, ses portées, ses effets positifs ou négatifs, et l'avenir qui s'y trouve.$edm$),
(27, 3, $edm$Que veut dire « la victoire générale ne dispense pas de la consultation pour chaque action particulière » ?$edm$, $edm$Parce que nous sommes déjà victorieux, il n'y a plus rien à demander$edm$, $edm$Nous sommes victorieux, mais nous devons avoir l'information confirmant la victoire selon l'acte spécifique à poser$edm$, $edm$La victoire dépend de nos efforts$edm$, $edm$La consultation remplace la victoire$edm$, 'b', $edm$Nous sommes déjà victorieux, mais nous devons avoir l'information confirmant ladite victoire selon l'acte spécifique à poser.$edm$),
(27, 4, $edm$Que montre l'exemple de David ?$edm$, $edm$Il ne consultait Dieu qu'en cas de faiblesse$edm$, $edm$Malgré sa certitude d'être l'oint de Dieu, il consultait toujours Dieu face aux réalités concrètes$edm$, $edm$Il n'avait pas besoin de Dieu$edm$, $edm$Il évitait les décisions$edm$, 'b', $edm$David connaissait parfaitement sa destinée, mais face aux réalités concrètes qu'il rencontrait, il consultait toujours Dieu.$edm$),
(27, 5, $edm$Quel est l'ennemi de la consultation de Dieu ?$edm$, $edm$Le manque de temps$edm$, $edm$Nos émotions ayant déjà un parti pris$edm$, $edm$Les circonstances$edm$, $edm$Le silence de Dieu$edm$, 'b', $edm$L'ennemi de la consultation de Dieu n'est rien d'autre que nos émotions ayant déjà un parti pris.$edm$),
(27, 6, $edm$Que faire quand l'action à poser nous fait pleurer à chaudes larmes ?$edm$, $edm$Agir immédiatement sans réfléchir$edm$, $edm$Essuyer les larmes et consulter Dieu pour savoir si l'action serait une victoire et la conduite à tenir$edm$, $edm$Reculer$edm$, $edm$Attendre que la douleur passe, sans consulter Dieu$edm$, 'b', $edm$Il sera judicieux d'essuyer les larmes et de consulter Dieu pour savoir si l'action à poser serait d'une victoire, et la conduite exacte à tenir durant l'action.$edm$),
(28, 1, $edm$Comment s'effectue l'action avec Dieu ?$edm$, $edm$Dans le temps (le kairos, le moment opportun) mais à travers un état : notre condition spirituelle$edm$, $edm$Sans tenir compte du temps$edm$, $edm$Seulement par l'effort humain$edm$, $edm$Toujours immédiatement$edm$, 'a', $edm$L'action s'effectue dans le temps (le kairos) mais à travers un état : notre condition spirituelle, notre disposition intérieure.$edm$),
(28, 2, $edm$Que faut-il demander d'abord pour agir ?$edm$, $edm$La richesse$edm$, $edm$La vie : le moteur et le carburant de toute action$edm$, $edm$La reconnaissance$edm$, $edm$Le succès$edm$, 'b', $edm$La vie est le moteur de toutes actions, c'est le carburant de l'action.$edm$),
(28, 3, $edm$Sous quelles formes l'ennemi cherche-t-il à planter la mort en nous ?$edm$, $edm$Physique, émotionnelle, spirituelle$edm$, $edm$Financière, sociale, politique$edm$, $edm$Familiale, amicale, professionnelle$edm$, $edm$Aucune$edm$, 'a', $edm$La mort physique, la mort émotionnelle, la mort spirituelle.$edm$),
(28, 4, $edm$Comment l'ennemi installe-t-il la mort en nous ?$edm$, $edm$Il nous tue directement$edm$, $edm$Il l'intègre progressivement à notre système : on devient vaniteux, paresseux, faible, distrait, négligent$edm$, $edm$Il ne peut rien faire$edm$, $edm$Il agit seulement de l'extérieur$edm$, 'b', $edm$Le royaume des ténèbres ne peut pas nous tuer directement, mais il peut intégrer la mort à notre système, l'installer progressivement en nous.$edm$),
(28, 5, $edm$Quel sacrifice est nécessaire pour agir avec Dieu ?$edm$, $edm$Un minimum de temps et de disposition pour consulter Dieu$edm$, $edm$Tous ses biens$edm$, $edm$Toute sa famille$edm$, $edm$Aucun$edm$, 'a', $edm$Il faut sacrifier un minimum de temps et de disposition pour consulter Dieu, afin d'être résolu et établi fermement dans l'initiative inspirée de Dieu.$edm$),
(28, 6, $edm$Quelles sont les trois conditions non négociables de l'action et de la prospérité avec Dieu ?$edm$, $edm$L'obéissance à Dieu, l'approbation de Dieu, le revêtement de la Puissance de l'Esprit$edm$, $edm$La richesse, le talent, la chance$edm$, $edm$Le jeûne, la veille, le silence$edm$, $edm$La force, la vitesse, la discipline$edm$, 'a', $edm$Il n'y a pas d'action et de prospérité avec Dieu sans l'obéissance à Dieu, l'approbation de Dieu et le revêtement de la Puissance de l'Esprit.$edm$),
(29, 1, $edm$Qu'est-ce que l'obéissance dans les actions produit ?$edm$, $edm$La prospérité : la bénédiction conforme à celle donnée à Christ par l'Esprit$edm$, $edm$La fatigue$edm$, $edm$L'orgueil$edm$, $edm$Rien de particulier$edm$, 'a', $edm$Lorsqu'il y a obéissance dans les actions posées, on parvient à la prospérité, la bénédiction conforme à celle qui fut donnée à Christ par l'Esprit.$edm$),
(29, 2, $edm$Comment Christ a-t-Il prospéré, selon Luc 2:52 ?$edm$, $edm$Il grandissait en stature, en sagesse, et sa renommée grandissait partout$edm$, $edm$Il est resté inconnu$edm$, $edm$Il s'est enrichi$edm$, $edm$Il a évité les foules$edm$, 'a', $edm$Luc 2:52 : il grandissait en stature, en sagesse, et sa renommée grandissait partout.$edm$),
(29, 3, $edm$Comment définit-on la prospérité dans ce texte ?$edm$, $edm$Posséder beaucoup$edm$, $edm$Productivité : porter beaucoup de fruits$edm$, $edm$Être célèbre$edm$, $edm$Être sans épreuves$edm$, 'b', $edm$Prospérité = productivité. Être productif est la véritable marque de la prospérité de Christ en nous : porter beaucoup de fruits.$edm$),
(29, 4, $edm$Quelle est la vraie nature de la prospérité ?$edm$, $edm$Une accumulation matérielle$edm$, $edm$Une bénédiction qui n'est suivie d'aucun chagrin, liée à une croissance infinie, sans limite$edm$, $edm$Un gain rapide$edm$, $edm$Une réussite temporaire$edm$, 'b', $edm$La prospérité véritable est la bénédiction qui n'est suivie d'aucun chagrin. Elle n'est pas liée au matériel en premier lieu, mais à la croissance indéterminée, sans limite.$edm$),
(29, 5, $edm$Quelles sont les quatre dimensions de la vraie prospérité ?$edm$, $edm$Sagesse, stature, grâce devant Dieu, grâce devant les hommes$edm$, $edm$Argent, pouvoir, renommée, santé$edm$, $edm$Famille, travail, loisirs, repos$edm$, $edm$Force, vitesse, adresse, chance$edm$, 'a', $edm$Croissance en sagesse, croissance en stature, grâce devant Dieu, grâce devant les hommes.$edm$),
(29, 6, $edm$Que signifie « faveur divine activée = faveur des hommes activée automatiquement » ?$edm$, $edm$La renommée est fabriquée par nos efforts$edm$, $edm$Ce qui parle de nous n'est pas naturel mais surnaturel : c'est la publicité du divin à notre sujet$edm$, $edm$Il faut faire sa propre publicité$edm$, $edm$Les hommes n'ont aucune importance$edm$, 'b', $edm$On ne passe jamais inaperçu, parce que ce qui parle pour nous et de nous n'est pas naturel mais surnaturel : c'est la publicité du divin à notre sujet.$edm$),
(30, 1, $edm$Que signifie « agir avec la folie de la foi » ?$edm$, $edm$Agir sans réfléchir$edm$, $edm$Partir sans savoir où l'on va, simplement parce que Dieu a parlé, même quand tout semble impossible humainement$edm$, $edm$Éviter toute prise de risque$edm$, $edm$Suivre uniquement la logique humaine$edm$, 'b', $edm$C'est partir sans savoir où l'on va, simplement parce que Dieu a parlé. Ce qui semble fou aux yeux du monde est sagesse selon Dieu (1 Corinthiens 1:25).$edm$),
(30, 2, $edm$Que signifie « agir par assurance » (Hébreux 11:1) ?$edm$, $edm$Attendre de tout voir$edm$, $edm$Déclarer la guérison avant de la voir, proclamer la victoire avant le combat, parce qu'on a l'assurance de Dieu dans le cœur$edm$, $edm$Douter en silence$edm$, $edm$Agir par peur$edm$, 'b', $edm$C'est déclarer la guérison avant de la voir, proclamer la victoire avant le combat, annoncer la provision avant qu'elle n'arrive, parce qu'on a l'assurance de Dieu dans le cœur.$edm$),
(30, 3, $edm$Que signifie « agir par l'Esprit » (Actes 13:2) ?$edm$, $edm$Agir selon ses propres idées$edm$, $edm$Obéir à une impulsion spirituelle pendant la prière, suivre une direction que l'Esprit met dans le cœur$edm$, $edm$Attendre l'avis de tous$edm$, $edm$Agir sans prier$edm$, 'b', $edm$C'est obéir à une impulsion spirituelle pendant la prière, suivre une direction que l'Esprit met dans notre cœur, ou agir sur une révélation reçue dans l'intimité avec Dieu.$edm$),
(30, 4, $edm$Sur quoi repose « agir par identité » ?$edm$, $edm$Sur nos sentiments$edm$, $edm$Sur qui nous sommes en Christ : enfant de Dieu, héritier, ambassadeur, sacrificateur royal$edm$, $edm$Sur nos circonstances$edm$, $edm$Sur l'opinion des autres$edm$, 'b', $edm$C'est se positionner selon notre identité en Christ et agir en conséquence, pas selon nos peurs ou nos doutes, mais selon qui Dieu dit que nous sommes.$edm$),
(30, 5, $edm$Que veut dire « agir sous l'influence de l'Esprit » (Jean 5:19) ?$edm$, $edm$Agir seul$edm$, $edm$Ne rien faire de soi-même, attendre de voir ce que le Père fait, bouger quand l'Esprit bouge$edm$, $edm$Faire plusieurs choses en même temps$edm$, $edm$Ne jamais agir$edm$, 'b', $edm$Jésus ne fait rien de Lui-même, mais seulement ce qu'Il voit faire au Père. C'est être tellement sensible à l'Esprit qu'on bouge quand Il bouge, qu'on parle quand Il parle, qu'on s'arrête quand Il s'arrête.$edm$),
(30, 6, $edm$Que dit le texte à propos d'agir par force et puissance ?$edm$, $edm$Il faut attendre une permission spécifique pour chaque petite chose$edm$, $edm$En marchant dans la vertu de l'Esprit, on connaît déjà la volonté générale de Dieu et on agit avec autorité, sans toujours attendre une permission spécifique pour chaque petite chose$edm$, $edm$Il ne faut jamais agir avec autorité$edm$, $edm$La puissance de l'Esprit n'est pas nécessaire$edm$, 'b', $edm$Quand on est fort et puissant par la vertu de l'Esprit, on connaît déjà la volonté générale de Dieu et on agit avec autorité. On n'attend pas toujours une permission spécifique pour frapper l'ennemi ou avancer dans le royaume.$edm$),
(31, 1, $edm$Qu'est-ce qu'offrir à Dieu ?$edm$, $edm$Un simple geste de générosité$edm$, $edm$Un acte d'amour profond envers le Seigneur$edm$, $edm$Une obligation légale$edm$, $edm$Un échange commercial$edm$, 'b', $edm$Offrir à Dieu, c'est bien plus qu'un simple geste de générosité : c'est un acte d'amour profond envers le Seigneur.$edm$),
(31, 2, $edm$En quoi consiste principalement l'offrande sous l'Évangile ?$edm$, $edm$En un rituel d'animaux$edm$, $edm$À soutenir la progression de l'Évangile$edm$, $edm$À construire des bâtiments$edm$, $edm$À enrichir les leaders$edm$, 'b', $edm$Sous l'Évangile, offrir à Dieu consiste principalement à soutenir la progression de l'Évangile, une manière concrète de participer à l'avancement du Royaume de Dieu sur la terre.$edm$),
(31, 3, $edm$Qu'est-ce que donner à son prochain ?$edm$, $edm$Un acte de bonté qui reste dans le domaine social, relationnel, humain$edm$, $edm$Une offrande à Dieu$edm$, $edm$Un sacrifice sacré$edm$, $edm$Une obligation religieuse$edm$, 'a', $edm$Donner à son prochain est un acte de bonté, naturel et parfois surnaturel, qui reste dans le domaine social, relationnel, humain.$edm$),
(31, 4, $edm$À quoi l'offrande est-elle liée ?$edm$, $edm$À un rituel, à une dimension sacrée, à l'idée d'un autel, d'un lieu de consécration$edm$, $edm$À un simple échange$edm$, $edm$À la politique$edm$, $edm$À l'amusement$edm$, 'a', $edm$L'offrande est liée à un rituel, à une dimension sacrée, à quelque chose qui dépasse le cadre purement social.$edm$),
(31, 5, $edm$Pourquoi cherche-t-on à plaire à Dieu par l'offrande ?$edm$, $edm$Par peur$edm$, $edm$Parce que lorsqu'on aime Dieu de tout son cœur, on cherche à lui plaire et à faire ce qui lui tient à cœur$edm$, $edm$Pour obtenir un avantage$edm$, $edm$Par habitude$edm$, 'b', $edm$Plus on aime Dieu, plus on cherche à découvrir ce qu'il attend de nous, et plus on a envie de le satisfaire.$edm$),
(31, 6, $edm$Que dit le texte à propos d'aider son semblable ?$edm$, $edm$C'est inutile$edm$, $edm$C'est aussi une manière d'honorer Dieu, mais cela reste dans le domaine social$edm$, $edm$C'est interdit$edm$, $edm$C'est une offrande sacrée$edm$, 'b', $edm$Aider son semblable est une manière d'honorer Dieu, car Dieu se soucie de la façon dont nous traitons les autres. Mais ce don ne porte pas la dimension sacrée de l'offrande.$edm$),
(32, 1, $edm$Comment réagissent les accusateurs sans amour quand on leur demande de donner ?$edm$, $edm$Ils donnent avec joie$edm$, $edm$Ils calculent, ne donnent rien et deviennent des critiques$edm$, $edm$Ils donnent en secret$edm$, $edm$Ils donnent plus que les autres$edm$, 'b', $edm$Ils calculent, ne donnent rien, et deviennent des critiques, des accusateurs, exactement comme Satan, « l'accusateur des frères ».$edm$),
(32, 2, $edm$Comment donnent ceux qui ont un cœur rempli d'amour pour Dieu ?$edm$, $edm$En calculant$edm$, $edm$Sans calculer, selon la conviction reçue dans leur cœur, sans attachement à l'argent$edm$, $edm$Par obligation$edm$, $edm$Pour être vus$edm$, 'b', $edm$Ils donnent sans calculer, sans chercher à justifier leur geste, portées par un amour débordant pour Dieu, et selon la conviction reçue dans leur cœur.$edm$),
(32, 3, $edm$Que montre l'exemple de la pauvre veuve ?$edm$, $edm$Qu'il faut donner peu$edm$, $edm$Qu'elle a tout donné, car c'était tout ce qu'elle possédait pour vivre, alors que les riches ne donnaient que leur superflu$edm$, $edm$Qu'il vaut mieux donner beaucoup$edm$, $edm$Que le montant n'a aucune importance pour personne$edm$, 'b', $edm$La pauvre veuve a tout donné, car c'était littéralement tout ce qu'elle possédait pour vivre. Les riches ne donnaient que leur superflu.$edm$),
(32, 4, $edm$Qui sont les chrétiens cupides, selon le texte ?$edm$, $edm$Ceux qui donnent tout$edm$, $edm$Ceux qui, comme Ananias et Saphira, donnent uniquement ce qui ne leur coûte rien$edm$, $edm$Ceux qui ne vont jamais à l'église$edm$, $edm$Ceux qui donnent en secret$edm$, 'b', $edm$Comme Ananias et Saphira, ils trouvent excessif de trop donner à Dieu. Ils donnent ce qui ne leur coûte rien, tout en essayant de se donner bonne conscience.$edm$),
(32, 5, $edm$À qui donne-t-on réellement quand on fait une offrande ?$edm$, $edm$À un homme$edm$, $edm$À Dieu lui-même : la personne qui reçoit n'est qu'un instrument entre Ses mains$edm$, $edm$À une institution$edm$, $edm$À soi-même$edm$, 'b', $edm$C'est à Dieu lui-même que l'on donne, et non simplement à un homme. Le serviteur ou l'œuvre n'est qu'un instrument entre les mains de Dieu.$edm$),
(32, 6, $edm$Quel est le conseil important du texte aux cupides ?$edm$, $edm$Donner un peu pour se donner bonne conscience$edm$, $edm$Il vaut mieux ne rien donner du tout que de donner de manière superflue avec un cœur de cupidité$edm$, $edm$Donner plus tard$edm$, $edm$Donner à n'importe qui$edm$, 'b', $edm$Mieux vaut s'abstenir plutôt que d'être repris par l'Esprit de Dieu, comme Ananias et Saphira, qui ont perdu la vie pour avoir menti à Dieu concernant leur offrande.$edm$),
(33, 1, $edm$Quels sont les éléments nécessaires pour bien offrir à Dieu ?$edm$, $edm$L'éducation spirituelle, la conviction et l'intimité avec Dieu, s'informer et se rendre disponible, donner dans le secret$edm$, $edm$La richesse, la renommée, le pouvoir, la rapidité$edm$, $edm$La peur, l'obligation, la pression, le calcul$edm$, $edm$Le jeûne, la veille, le silence, la lecture$edm$, 'a', $edm$Une véritable éducation spirituelle, la conviction et l'intimité avec Dieu, s'informer et se rendre disponible, et apprendre à donner dans le secret.$edm$),
(33, 2, $edm$Dieu oblige-t-Il à donner ?$edm$, $edm$Oui, toujours$edm$, $edm$Non : Dieu n'oblige jamais personne. C'est la sensibilité spirituelle qui crée la conviction intérieure$edm$, $edm$Oui, aux riches$edm$, $edm$Oui, dans les églises$edm$, 'b', $edm$Dieu n'oblige jamais personne à donner. C'est la sensibilité spirituelle qui, petit à petit, crée en nous une conviction intérieure.$edm$),
(33, 3, $edm$Que représente chaque serviteur qui porte l'Évangile ?$edm$, $edm$Un simple homme$edm$, $edm$En quelque sorte un autel vivant de Dieu ici sur la terre$edm$, $edm$Un employé$edm$, $edm$Un étranger$edm$, 'b', $edm$Chaque serviteur qui porte l'Évangile est en quelque sorte un autel vivant de Dieu ici sur la terre.$edm$),
(33, 4, $edm$Que désire Jésus sous l'ère de la Grâce ?$edm$, $edm$Que nous accumulions des biens$edm$, $edm$Que nous nous dépouillions de toute cupidité, que notre cœur ne soit jamais attaché à l'argent, et que nous apprenions à tout donner dans la mesure où Dieu nous y conduit$edm$, $edm$Que nous évitions de donner$edm$, $edm$Que nous donnions sous la contrainte$edm$, 'b', $edm$Notre cœur ne doit jamais être attaché à l'argent en lui-même, mais nous devons apprendre à tout donner, dans la mesure où Dieu nous y conduit, afin que l'Évangile prospère.$edm$),
(33, 5, $edm$Qu'est-ce qui n'existe pas, selon le texte ?$edm$, $edm$Un don véritable à Dieu qui ne touche pas d'une manière ou d'une autre notre prochain$edm$, $edm$L'offrande$edm$, $edm$La générosité$edm$, $edm$La grâce$edm$, 'a', $edm$Il n'existe pas de don véritable à Dieu qui ne touche pas d'une manière ou d'une autre notre prochain.$edm$),
(33, 6, $edm$De quelles trois manières les offrandes sont-elles venues au peuple de Dieu ?$edm$, $edm$Un appel direct de Dieu, une inspiration divine dans le cœur, une instruction transmise par une personne mandatée$edm$, $edm$Par la loi, la tradition, la coutume$edm$, $edm$Par la contrainte, la peur, la honte$edm$, $edm$Par le hasard$edm$, 'a', $edm$Soit par un appel direct venant de Dieu, soit par une inspiration divine ressentie dans le cœur, soit par une instruction transmise par une personne mandatée par Dieu.$edm$),
(34, 1, $edm$Qu'est-ce que la dîme ?$edm$, $edm$Un cinquième de nos revenus$edm$, $edm$Le dixième de tous nos revenus remis à Dieu, en reconnaissance que tout vient de Lui$edm$, $edm$Une taxe$edm$, $edm$Un don occasionnel$edm$, 'b', $edm$La dîme est le dixième de tous nos revenus que nous remettons à Dieu, en reconnaissance du fait que tout ce que nous possédons vient de Lui en premier lieu.$edm$),
(34, 2, $edm$Que sont les prémices ?$edm$, $edm$Les derniers fruits de notre travail$edm$, $edm$Les tout premiers fruits de notre travail, de nos revenus ou de toute nouvelle bénédiction, donnés à Dieu en premier$edm$, $edm$Les restes$edm$, $edm$Un impôt$edm$, 'b', $edm$Les prémices sont les tout premiers fruits de notre travail, de nos revenus, ou de toute nouvelle bénédiction, donnés à Dieu en tout premier, avant même de penser à nous-mêmes.$edm$),
(34, 3, $edm$Qu'a permis l'offrande volontaire dans l'Ancien Testament ?$edm$, $edm$La construction du tabernacle$edm$, $edm$La construction de murailles$edm$, $edm$L'achat de terres$edm$, $edm$La guerre$edm$, 'a', $edm$L'offrande volontaire a permis la construction du tabernacle : le peuple a apporté tant d'offrandes que Moïse a dû demander d'arrêter (Exode 35-36).$edm$),
(34, 4, $edm$Qui est l'accomplissement parfait des sacrifices de l'Ancienne Alliance ?$edm$, $edm$Moïse$edm$, $edm$Jésus-Christ, par une seule offrande, une fois pour toutes$edm$, $edm$Les prêtres$edm$, $edm$Les anges$edm$, 'b', $edm$Tous les sacrifices trouvent leur accomplissement parfait en Jésus-Christ, par une seule offrande, une fois pour toutes (Hébreux 10:10-14).$edm$),
(34, 5, $edm$Que signifie « hilaros » (2 Corinthiens 9:7) ?$edm$, $edm$La tristesse$edm$, $edm$La joie : Dieu aime celui qui donne avec joie$edm$, $edm$La contrainte$edm$, $edm$Le calcul$edm$, 'b', $edm$Le mot grec traduit par « joie » est hilaros, d'où vient « hilare » : Dieu aime tout particulièrement celui qui donne avec joie.$edm$),
(34, 6, $edm$Comment la valeur d'une offrande est-elle mesurée aux yeux de Dieu ?$edm$, $edm$À la quantité absolue donnée$edm$, $edm$À la proportion de l'offrande par rapport à ce que la personne possède réellement, comme l'illustre la veuve$edm$, $edm$À la visibilité du geste$edm$, $edm$À la fréquence$edm$, 'b', $edm$La valeur d'une offrande ne se mesure jamais à la quantité absolue donnée, mais à la proportion par rapport à ce que la personne possède réellement. La veuve a donné plus que tous les autres.$edm$),
(35, 1, $edm$Pourquoi les offrandes du Nouveau Testament comportent-elles une exigence plus élevée ?$edm$, $edm$Parce qu'elles sont obligatoires$edm$, $edm$Parce qu'elles soutiennent directement la Grande Commission$edm$, $edm$Parce qu'elles sont plus coûteuses$edm$, $edm$Parce qu'elles sont plus visibles$edm$, 'b', $edm$Les offrandes du Nouveau Testament servent directement à soutenir la Grande Commission : annoncer l'Évangile, gagner des âmes, établir de nouvelles Églises, envoyer des missionnaires.$edm$),
(35, 2, $edm$De quelles trois manières une offrande peut-elle nous être présentée ?$edm$, $edm$Par un appel, par un enseignement, par une conviction personnelle venant de Dieu$edm$, $edm$Par la peur, par la honte, par la pression$edm$, $edm$Par un impôt, une loi, une coutume$edm$, $edm$Par le hasard$edm$, 'a', $edm$Par un appel lancé par un serviteur de Dieu, par un enseignement de la Parole, ou par une conviction personnelle venant du Saint-Esprit. Ces trois moyens sont tous également valables et pleinement bibliques.$edm$),
(35, 3, $edm$Que faire d'abord quand un appel est lancé ?$edm$, $edm$Donner immédiatement$edm$, $edm$Calculer ce que les autres donnent$edm$, $edm$Parler à Dieu, prier, et attendre la conviction qui vient de Lui$edm$, $edm$Critiquer l'appel$edm$, 'c', $edm$Il convient d'abord de parler à Dieu, de prier, plutôt que de donner de manière impulsive ou de calculer. La conviction vient uniquement de Dieu, jamais de la pression des autres ou des circonstances.$edm$),
(35, 4, $edm$Quels sont les signes d'une conviction qui vient réellement de Dieu ?$edm$, $edm$Une paix intérieure profonde, un amour qui pousse à participer, une clarté sur le montant, une joie sincère$edm$, $edm$La peur et l'angoisse$edm$, $edm$La pression des autres$edm$, $edm$La culpabilité$edm$, 'a', $edm$Quand Dieu convainc réellement, on ressent une paix intérieure profonde, un amour débordant, une clarté sur le montant précis à donner, et une joie sincère à contribuer.$edm$),
(35, 5, $edm$Que faire si l'on n'est pas convaincu par Dieu ?$edm$, $edm$Donner quand même par obligation$edm$, $edm$Ne pas donner : ce n'est pas une obligation, et il ne faut jamais devenir un accusateur$edm$, $edm$Critiquer ceux qui donnent$edm$, $edm$Critiquer le serviteur de Dieu$edm$, 'b', $edm$Si l'on n'est pas convaincu, on ne donne pas : ce n'est pas une obligation. Il vaut mieux ne pas donner que de donner avec doute, calcul ou cupidité cachée. Et on ne critique ni ceux qui donnent, ni le serviteur de Dieu.$edm$),
(35, 6, $edm$Que faire face à une conviction personnelle reçue dans le quotidien ?$edm$, $edm$Donner tout de suite sans réfléchir$edm$, $edm$Discuter avec Dieu dans le secret, vérifier que l'offrande fera avancer le royaume, éprouver les esprits, puis donner dans le secret avec joie$edm$, $edm$En parler à tout le monde$edm$, $edm$Ne rien faire$edm$, 'b', $edm$Avant de donner, il convient de discuter avec Dieu dans le secret, de vérifier que l'offrande va faire avancer le royaume, d'éprouver les esprits, puis de donner dans le secret, avec joie.$edm$)
) AS v(numero, ordre, question, a, b, c, d, rep, expl)
JOIN public.formation_modules m ON m.formation = 'formation' AND m.numero = v.numero;

COMMIT;

-- Vérification : doit afficher 35 modules et 210 questions
SELECT (SELECT count(*) FROM public.formation_modules WHERE formation = 'formation') AS modules,
       (SELECT count(*) FROM public.formation_questions fq JOIN public.formation_modules fm ON fm.id = fq.module_id WHERE fm.formation = 'formation') AS questions;
