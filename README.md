# EDM Mobile

Application React Native avec Expo Router, conçue pour Expo Go (SDK 58) et connectée au projet Supabase du site EDM.

## Configuration

Le fichier `.env` local contient les variables publiques de connexion au même projet Supabase :

```env
EXPO_PUBLIC_SUPABASE_URL=
EXPO_PUBLIC_SUPABASE_ANON_KEY=
```

Utiliser uniquement l’URL du projet et la clé anon publique. Ne jamais placer de clé `service_role` dans l’application. `.env` est ignoré par Git.

## Lancer sur Android

```bash
npm install
npm start
```

Scanner le QR code avec Expo Go sur le téléphone. Le téléphone et l’ordinateur doivent pouvoir joindre le serveur Expo sur le réseau local.

## Vérifications

```bash
npm run lint
npx tsc --noEmit
```

## Parcours disponibles

- Accueil et annonces publiées par EDM.
- Connexion et inscription par téléphone, compatibles avec les comptes du site (`téléphone sans espaces` + `@edm.app`).
- Trois parcours de formation, questionnaires et progression partagée avec le site.
- Inscription aux sept semaines de la Formation 1 et demande de département pour le parcours Cadres.
- Soutenir EDM, sans traitement de paiement dans l’application.

Les données, tables, politiques RLS et fichiers Supabase sont utilisés tels quels ; cette application ne modifie pas le schéma.

- [Expo on GitHub](https://github.com/expo/expo): View our open source platform and contribute.
- [Discord community](https://chat.expo.dev): Chat with Expo users and ask questions.
