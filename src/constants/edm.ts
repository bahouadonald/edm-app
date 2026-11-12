export const EDM = {
  red: '#C8102E',
  redDark: '#8B0000',
  gold: '#C9920A',
  goldLight: '#F5DFA0',
  cream: '#FDF8F0',
  creamDark: '#F5EDD8',
  creamDeep: '#EFE4C8',
  white: '#FFFFFF',
  text: '#2C1A0E',
  textSecondary: '#5C3D20',
  textMuted: '#9A7A5A',
  border: '#E8D8B8',
  borderStrong: '#D4C090',
  green: '#2E7D32',
} as const;

export const FORMATION_WEEKS = [
  'Savoir méditer la Parole de Dieu',
  'Savoir invoquer Dieu',
  'Savoir prier Dieu',
  'Savoir adorer Dieu',
  'Savoir marcher avec Dieu',
  'Savoir agir et prospérer avec Dieu',
  'Savoir offrir à Dieu',
] as const;

export const FORMATION_CARDS = [
  {
    key: 'formation',
    title: 'Une semaine pour savoir avec Dieu',
    subtitle: '7 semaines de formation',
    color: EDM.red,
  },
  {
    key: 'saison',
    title: 'Connaître les saisons, les discerner et les activer',
    subtitle: 'Formation 2',
    color: EDM.gold,
  },
  {
    key: 'spirituel',
    title: 'Devenir spirituel en Christ',
    subtitle: 'Formation 3',
    color: EDM.redDark,
  },
] as const;

export const DEPARTMENTS = [
  { id: 'hallel', title: 'Élite Hallel', description: 'Louange, adoration et danse', icon: 'music_note' },
  { id: 'hatafa', title: 'Élite Hatafa', description: 'Conquête et guérison', icon: 'bolt' },
  { id: 'hafaka', title: 'Élite Hafaka', description: 'Production, acteurs et vidéastes', icon: 'movie' },
  { id: 'mimsad', title: 'Élite Mimsad', description: 'Organisation et logistique', icon: 'event_note' },
] as const;

export function departmentName(id: string | null | undefined) {
  return DEPARTMENTS.find((department) => department.id === id)?.title ?? id ?? '';
}
