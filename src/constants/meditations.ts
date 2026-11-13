// Méditation du jour — 49 versets (Louis Segond 1910), validés pour la vision EDM.
// Utilisés si la table Supabase « meditations_du_jour » est vide ou inaccessible.
export type Meditation = { jour: number; theme: string; reference: string; texte: string };

export const MEDITATIONS: Meditation[] = [
  {
    "jour": 1,
    "theme": "Identité — qui je suis en Christ",
    "reference": "1 Pierre 2:9",
    "texte": "Vous, au contraire, vous êtes une race élue, un sacerdoce royal, une nation sainte, un peuple acquis, afin que vous annonciez les vertus de celui qui vous a appelés des ténèbres à son admirable lumière,"
  },
  {
    "jour": 2,
    "theme": "Identité — qui je suis en Christ",
    "reference": "2 Corinthiens 5:17",
    "texte": "Si quelqu’un est en Christ, il est une nouvelle créature. Les choses anciennes sont passées; voici, toutes choses sont devenues nouvelles."
  },
  {
    "jour": 3,
    "theme": "Identité — qui je suis en Christ",
    "reference": "Éphésiens 2:10",
    "texte": "Car nous sommes son ouvrage, ayant été créés en Jésus-Christ pour de bonnes œuvres, que Dieu a préparées d’avance, afin que nous les pratiquions."
  },
  {
    "jour": 4,
    "theme": "Identité — qui je suis en Christ",
    "reference": "Romains 8:37",
    "texte": "Mais dans toutes ces choses nous sommes plus que vainqueurs par celui qui nous a aimés."
  },
  {
    "jour": 5,
    "theme": "Identité — qui je suis en Christ",
    "reference": "1 Jean 4:4",
    "texte": "Vous, petits enfants, vous êtes de Dieu, et vous les avez vaincus, parce que celui qui est en vous est plus grand que celui qui est dans le monde."
  },
  {
    "jour": 6,
    "theme": "Identité — qui je suis en Christ",
    "reference": "Galates 2:20",
    "texte": "J’ai été crucifié avec Christ; et si je vis, ce n’est plus moi qui vis, c’est Christ qui vit en moi; si je vis maintenant dans la chair, je vis dans la foi au Fils de Dieu, qui m’a aimé et qui s’est livré lui-même pour moi."
  },
  {
    "jour": 7,
    "theme": "Identité — qui je suis en Christ",
    "reference": "Apocalypse 5:10",
    "texte": "tu as fait d’eux un royaume et des sacrificateurs pour notre Dieu, et ils régneront sur la terre."
  },
  {
    "jour": 8,
    "theme": "Force — fortifié par le Tout-Puissant",
    "reference": "Éphésiens 6:10",
    "texte": "Au reste, fortifiez-vous dans le Seigneur, et par sa force toute-puissante."
  },
  {
    "jour": 9,
    "theme": "Force — fortifié par le Tout-Puissant",
    "reference": "Ésaïe 40:31",
    "texte": "Mais ceux qui se confient en l’Éternel renouvellent leur force. Ils prennent le vol comme les aigles; Ils courent, et ne se lassent point, Ils marchent, et ne se fatiguent point."
  },
  {
    "jour": 10,
    "theme": "Force — fortifié par le Tout-Puissant",
    "reference": "Ésaïe 41:10",
    "texte": "Ne crains rien, car je suis avec toi; Ne promène pas des regards inquiets, car je suis ton Dieu; Je te fortifie, je viens à ton secours, Je te soutiens de ma droite triomphante."
  },
  {
    "jour": 11,
    "theme": "Force — fortifié par le Tout-Puissant",
    "reference": "Philippiens 4:13",
    "texte": "Je puis tout par celui qui me fortifie."
  },
  {
    "jour": 12,
    "theme": "Force — fortifié par le Tout-Puissant",
    "reference": "2 Timothée 1:7",
    "texte": "Car ce n’est pas un esprit de timidité que Dieu nous a donné, mais un esprit de force, d’amour et de sagesse."
  },
  {
    "jour": 13,
    "theme": "Force — fortifié par le Tout-Puissant",
    "reference": "Ésaïe 40:29",
    "texte": "Il donne de la force à celui qui est fatigué, Et il augmente la vigueur de celui qui tombe en défaillance."
  },
  {
    "jour": 14,
    "theme": "Force — fortifié par le Tout-Puissant",
    "reference": "Psaumes 18:33",
    "texte": "C’est Dieu qui me ceint de force, Et qui me conduit dans la voie droite."
  },
  {
    "jour": 15,
    "theme": "Puissance — l'onction du Saint-Esprit",
    "reference": "Actes 1:8",
    "texte": "Mais vous recevrez une puissance, le Saint-Esprit survenant sur vous, et vous serez mes témoins à Jérusalem, dans toute la Judée, dans la Samarie, et jusqu’aux extrémités de la terre."
  },
  {
    "jour": 16,
    "theme": "Puissance — l'onction du Saint-Esprit",
    "reference": "Zacharie 4:6",
    "texte": "Alors il reprit et me dit: C’est ici la parole que l’Éternel adresse à Zorobabel: Ce n’est ni par la puissance ni par la force, mais c’est par mon esprit, dit l’Éternel des armées."
  },
  {
    "jour": 17,
    "theme": "Puissance — l'onction du Saint-Esprit",
    "reference": "Luc 24:49",
    "texte": "Et voici, j’enverrai sur vous ce que mon Père a promis; mais vous, restez dans la ville jusqu’à ce que vous soyez revêtus de la puissance d’en haut."
  },
  {
    "jour": 18,
    "theme": "Puissance — l'onction du Saint-Esprit",
    "reference": "Romains 8:11",
    "texte": "Et si l’Esprit de celui qui a ressuscité Jésus d’entre les morts habite en vous, celui qui a ressuscité Christ d’entre les morts rendra aussi la vie à vos corps mortels par son Esprit qui habite en vous."
  },
  {
    "jour": 19,
    "theme": "Puissance — l'onction du Saint-Esprit",
    "reference": "Marc 16:17",
    "texte": "Voici les miracles qui accompagneront ceux qui auront cru: en mon nom, ils chasseront les démons; ils parleront de nouvelles langues;"
  },
  {
    "jour": 20,
    "theme": "Puissance — l'onction du Saint-Esprit",
    "reference": "1 Corinthiens 12:7",
    "texte": "Or, à chacun la manifestation de l’Esprit est donnée pour l’utilité commune."
  },
  {
    "jour": 21,
    "theme": "Puissance — l'onction du Saint-Esprit",
    "reference": "Actes 4:33",
    "texte": "Les apôtres rendaient avec beaucoup de force témoignage de la résurrection du Seigneur Jésus. Et une grande grâce reposait sur eux tous."
  },
  {
    "jour": 22,
    "theme": "Excellence — sagesse et esprit supérieur",
    "reference": "Proverbes 22:29",
    "texte": "Si tu vois un homme habile dans son ouvrage, Il se tient auprès des rois; Il ne se tient pas auprès des gens obscurs."
  },
  {
    "jour": 23,
    "theme": "Excellence — sagesse et esprit supérieur",
    "reference": "Jacques 1:5",
    "texte": "Si quelqu’un d’entre vous manque de sagesse, qu’il la demande à Dieu, qui donne à tous simplement et sans reproche, et elle lui sera donnée."
  },
  {
    "jour": 24,
    "theme": "Excellence — sagesse et esprit supérieur",
    "reference": "Colossiens 3:23",
    "texte": "Tout ce que vous faites, faites-le de bon cœur, comme pour le Seigneur et non pour des hommes,"
  },
  {
    "jour": 25,
    "theme": "Excellence — sagesse et esprit supérieur",
    "reference": "Daniel 12:3",
    "texte": "Ceux qui auront été intelligents brilleront comme la splendeur du ciel, et ceux qui auront enseigné la justice, à la multitude brilleront comme les étoiles, à toujours et à perpétuité."
  },
  {
    "jour": 26,
    "theme": "Excellence — sagesse et esprit supérieur",
    "reference": "Proverbes 4:7",
    "texte": "Voici le commencement de la sagesse: Acquiers la sagesse, Et avec tout ce que tu possèdes acquiers l’intelligence."
  },
  {
    "jour": 27,
    "theme": "Excellence — sagesse et esprit supérieur",
    "reference": "2 Pierre 1:3",
    "texte": "Comme sa divine puissance nous a donné tout ce qui contribue à la vie et à la piété, au moyen de la connaissance de celui qui nous a appelés par sa propre gloire et par sa vertu,"
  },
  {
    "jour": 28,
    "theme": "Excellence — sagesse et esprit supérieur",
    "reference": "Exode 31:3",
    "texte": "Je l’ai rempli de l’Esprit de Dieu, de sagesse, d’intelligence, et de savoir pour toutes sortes d’ouvrages,"
  },
  {
    "jour": 29,
    "theme": "Autorité — régner dans la vie",
    "reference": "Luc 10:19",
    "texte": "Voici, je vous ai donné le pouvoir de marcher sur les serpents et les scorpions, et sur toute la puissance de l’ennemi; et rien ne pourra vous nuire."
  },
  {
    "jour": 30,
    "theme": "Autorité — régner dans la vie",
    "reference": "Matthieu 16:19",
    "texte": "Je te donnerai les clefs du royaume des cieux: ce que tu lieras sur la terre sera lié dans les cieux, et ce que tu délieras sur la terre sera délié dans les cieux."
  },
  {
    "jour": 31,
    "theme": "Autorité — régner dans la vie",
    "reference": "Genèse 1:28",
    "texte": "Dieu les bénit, et Dieu leur dit: Soyez féconds, multipliez, remplissez la terre, et l’assujettissez; et dominez sur les poissons de la mer, sur les oiseaux du ciel, et sur tout animal qui se meut sur la terre."
  },
  {
    "jour": 32,
    "theme": "Autorité — régner dans la vie",
    "reference": "Romains 5:17",
    "texte": "Si par l’offense d’un seul la mort a régné par lui seul, à plus forte raison ceux qui reçoivent l’abondance de la grâce et du don de la justice régneront-ils dans la vie par Jésus-Christ lui seul."
  },
  {
    "jour": 33,
    "theme": "Autorité — régner dans la vie",
    "reference": "Matthieu 28:18",
    "texte": "Jésus, s’étant approché, leur parla ainsi: Tout pouvoir m’a été donné dans le ciel et sur la terre."
  },
  {
    "jour": 34,
    "theme": "Autorité — régner dans la vie",
    "reference": "Deutéronome 28:13",
    "texte": "L’Éternel fera de toi la tête et non la queue, tu seras toujours en haut et tu ne seras jamais en bas, lorsque tu obéiras aux commandements de l’Éternel, ton Dieu, que je te prescris aujourd’hui, lorsque tu les observeras et les mettras en pratique,"
  },
  {
    "jour": 35,
    "theme": "Autorité — régner dans la vie",
    "reference": "2 Corinthiens 10:4",
    "texte": "Car les armes avec lesquelles nous combattons ne sont pas charnelles; mais elles sont puissantes, par la vertu de Dieu, pour renverser des forteresses."
  },
  {
    "jour": 36,
    "theme": "Impact — lumière du monde",
    "reference": "Matthieu 5:14",
    "texte": "Vous êtes la lumière du monde. Une ville située sur une montagne ne peut être cachée;"
  },
  {
    "jour": 37,
    "theme": "Impact — lumière du monde",
    "reference": "Matthieu 5:16",
    "texte": "Que votre lumière luise ainsi devant les hommes, afin qu’ils voient vos bonnes œuvres, et qu’ils glorifient votre Père qui est dans les cieux."
  },
  {
    "jour": 38,
    "theme": "Impact — lumière du monde",
    "reference": "Jean 14:12",
    "texte": "En vérité, en vérité, je vous le dis, celui qui croit en moi fera aussi les œuvres que je fais, et il en fera de plus grandes, parce que je m’en vais au Père;"
  },
  {
    "jour": 39,
    "theme": "Impact — lumière du monde",
    "reference": "Proverbes 4:18",
    "texte": "Le sentier des justes est comme la lumière resplendissante, Dont l’éclat va croissant jusqu’au milieu du jour."
  },
  {
    "jour": 40,
    "theme": "Impact — lumière du monde",
    "reference": "Matthieu 28:19",
    "texte": "Allez, faites de toutes les nations des disciples, les baptisant au nom du Père, du Fils et du Saint-Esprit,"
  },
  {
    "jour": 41,
    "theme": "Impact — lumière du monde",
    "reference": "Ésaïe 60:1",
    "texte": "Lève-toi, sois éclairée, car ta lumière arrive, Et la gloire de l’Éternel se lève sur toi."
  },
  {
    "jour": 42,
    "theme": "Impact — lumière du monde",
    "reference": "2 Corinthiens 2:14",
    "texte": "Grâces soient rendues à Dieu, qui nous fait toujours triompher en Christ, et qui répand par nous en tout lieu l’odeur de sa connaissance!"
  },
  {
    "jour": 43,
    "theme": "Présence — demeurer en Lui",
    "reference": "Jean 15:4",
    "texte": "Demeurez en moi, et je demeurerai en vous. Comme le sarment ne peut de lui-même porter du fruit, s’il ne demeure attaché au cep, ainsi vous ne le pouvez non plus, si vous ne demeurez en moi."
  },
  {
    "jour": 44,
    "theme": "Présence — demeurer en Lui",
    "reference": "Jean 15:5",
    "texte": "Je suis le cep, vous êtes les sarments. Celui qui demeure en moi et en qui je demeure porte beaucoup de fruit, car sans moi vous ne pouvez rien faire."
  },
  {
    "jour": 45,
    "theme": "Présence — demeurer en Lui",
    "reference": "Jean 15:7",
    "texte": "Si vous demeurez en moi, et que mes paroles demeurent en vous, demandez ce que vous voudrez, et cela vous sera accordé."
  },
  {
    "jour": 46,
    "theme": "Présence — demeurer en Lui",
    "reference": "Jean 15:16",
    "texte": "Ce n’est pas vous qui m’avez choisi; mais moi, je vous ai choisis, et je vous ai établis, afin que vous alliez, et que vous portiez du fruit, et que votre fruit demeure, afin que ce que vous demanderez au Père en mon nom, il vous le donne."
  },
  {
    "jour": 47,
    "theme": "Présence — demeurer en Lui",
    "reference": "Psaumes 91:1",
    "texte": "Celui qui demeure sous l’abri du Très-Haut Repose à l’ombre du Tout Puissant."
  },
  {
    "jour": 48,
    "theme": "Présence — demeurer en Lui",
    "reference": "Exode 33:14",
    "texte": "L’Éternel répondit: Je marcherai moi-même avec toi, et je te donnerai du repos."
  },
  {
    "jour": 49,
    "theme": "Présence — demeurer en Lui",
    "reference": "Psaumes 16:11",
    "texte": "Tu me feras connaître le sentier de la vie; Il y a d’abondantes joies devant ta face, Des délices éternelles à ta droite."
  }
];

/** Verset du jour : change chaque jour, tourne sur la liste. */
export function meditationOfTheDay(list: Meditation[] = MEDITATIONS, date = new Date()): Meditation {
  const source = list.length ? list : MEDITATIONS;
  const start = Date.UTC(date.getFullYear(), 0, 1);
  const today = Date.UTC(date.getFullYear(), date.getMonth(), date.getDate());
  const dayOfYear = Math.floor((today - start) / 86400000);
  return source[dayOfYear % source.length];
}
