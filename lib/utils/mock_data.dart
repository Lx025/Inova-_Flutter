import 'package:eurofarma_project/models/reward_model.dart';

import '../models/idea_model.dart';

const String MOCK_PIC_FELIPE = 'https://picsum.photos/id/1012/100/100';
const String MOCK_PIC_PEDRO = 'https://picsum.photos/id/1025/100/100';
const String MOCK_PIC_VITORIA = 'https://picsum.photos/id/1027/100/100';
const String MOCK_PIC_LEONARDO = 'https://picsum.photos/id/1026/100/100';
const String MOCK_PIC_LUCAS = 'https://picsum.photos/id/1011/100/100';

// Novos nomes e URLs para a geração de comentários
const List<String> MOCK_OTHER_NAMES = [
  'Ana Silva', 'Bruno Costa', 'Mariana Gomes', 'Ricardo Nunez', 'Juliana Lima'
];
const List<String> MOCK_OTHER_PICS = [
  'https://picsum.photos/id/50/100/100', 'https://picsum.photos/id/60/100/100',
  'https://picsum.photos/id/70/100/100', 'https://picsum.photos/id/80/100/100',
  'https://picsum.photos/id/90/100/100'
];

// 5 Ideias, uma para cada membro do grupo
final List<Idea> mockIdeas = [
  // IDEIA 1: Atribuída a Pedro Henrique
  Idea(
    id: '1',
    title: 'Aumentar o espaço de convivência entre as diferentes áreas da empresa.',
    description: 'A ideia é criar um lounge central onde colaboradores de diferentes setores (TI, Financeiro, Comercial) possam interagir informalmente, promovendo a troca de conhecimento e a colaboração. Isso está diretamente ligado aos objetivos do projeto Inova+ de estimular a colaboração entre os colaboradores.',
    author: 'Pedro Henrique',
    authorProfilePicUrl: MOCK_PIC_PEDRO, 
    timeAgo: '12h',
    likes: 87, 
    comments: 353, 
  ),
  // IDEIA 2: Atribuída a Vitoria Cerqueira
  Idea(
    id: '2',
    title: 'Digitalização de Processos de RH',
    description: 'Proposta para automatizar a admissão de novos colaboradores através de um app, reduzindo o uso de papel e o tempo de onboarding em 30%.',
    author: 'Vitoria Cerqueira',
    authorProfilePicUrl: MOCK_PIC_VITORIA,
    timeAgo: '1d',
    likes: 154,
    comments: 42,
  ),
  // IDEIA 3: Atribuída a Felipe Pereira
  Idea(
    id: '3',
    title: 'Uso de IA para otimização da cadeia de suprimentos farmacêutica.',
    description: 'Proponho um sistema de aprendizado de máquina no backend (Python/Java) para prever picos de demanda e ajustar estoques, minimizando perdas e otimizando o armazenamento na AWS S3.',
    author: 'Felipe Pereira',
    authorProfilePicUrl: MOCK_PIC_FELIPE,
    timeAgo: '2d',
    likes: 78,
    comments: 15,
  ),
  // IDEIA 4: Atribuída a Leonardo Queiroz
  Idea(
    id: '4',
    title: 'Desafio Semanal Temático: Redução de Carbono na Produção.',
    description: 'Criar um Desafio Semanal dentro do app para que os colaboradores sugiram formas de reduzir o impacto ambiental, usando o sistema de gamificação para recompensar as melhores soluções.',
    author: 'Leonardo Queiroz',
    authorProfilePicUrl: MOCK_PIC_LEONARDO,
    timeAgo: '4d',
    likes: 21,
    comments: 5,
  ),
  // IDEIA 5: Atribuída a Lucas Henrique
  Idea(
    id: '5',
    title: 'Implementação de programa de mentoria reversa em tecnologia.',
    description: 'Criar um sistema de mentoria onde colaboradores mais jovens (digitais) ensinam os mais experientes sobre novas tecnologias e o uso do próprio aplicativo, garantindo a acessibilidade.',
    author: 'Lucas Henrique',
    authorProfilePicUrl: MOCK_PIC_LUCAS,
    timeAgo: '1 sem',
    likes: 99,
    comments: 28,
  ),
];

final List<RankingUser> mockRanking = [
  RankingUser(position: 1, name: 'Felipe Pereira', profilePicUrl: MOCK_PIC_FELIPE),
  RankingUser(position: 2, name: 'Pedro Henrique', profilePicUrl: MOCK_PIC_PEDRO),
  RankingUser(position: 3, name: 'Vitoria Cerqueira', profilePicUrl: MOCK_PIC_VITORIA),
  RankingUser(position: 4, name: 'Leonardo Queiroz', profilePicUrl: MOCK_PIC_LEONARDO),
  RankingUser(position: 5, name: 'Lucas Henrique', profilePicUrl: MOCK_PIC_LUCAS),
];

// Comentários iniciais fixos
final List<Comment> mockCommentsBase = [
  Comment(
    author: 'Felipe Meschiatti',
    authorPicUrl: MOCK_PIC_FELIPE,
    text: 'Ótimo tema, com certeza essa ideia inovadora irá fazer sentido para o perfil da empresa!',
    timeAgo: '12h',
  ),
  Comment(
    author: 'Pedro Henrique',
    authorPicUrl: MOCK_PIC_PEDRO,
    text: 'Parabéns, ficou ótimo!',
    timeAgo: '12h',
  ),
  Comment(
    author: 'Leonardo Queiroz',
    authorPicUrl: MOCK_PIC_LEONARDO,
    text: 'Achei a ideia muito relevante para estimular a colaboração e a cultura de inovação que a Inova+ busca.',
    timeAgo: '11h',
  ),
];

final List<Reward> mockRewards = [
  Reward(
    id: 'R01',
    name: 'Vale-Presente R\$100',
    description: 'Um vale para usar em lojas parceiras da Eurofarma.',
    cost: 5000, 
    // Imagem mais adequada para "Vale-Presente"
    imageUrl: 'https://images.unsplash.com/photo-1579546929518-971f15aa0252?q=80&w=200&h=150&fit=crop',
  ),
  Reward(
    id: 'R02',
    name: 'Dia de Folga Extra',
    description: 'Troque seus pontos por um dia de descanso remunerado.',
    cost: 15000, 
    // Imagem mais adequada para "Dia de Folga" (praia/descanso)
    imageUrl: 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?q=80&w=200&h=150&fit=crop',
  ),
  Reward(
    id: 'R03',
    name: 'Café com a Diretoria',
    description: 'Networking e reconhecimento pelo seu nível de inovação.',
    cost: 8000, 
    // Imagem mais adequada para "Networking/Reunião"
    imageUrl: 'https://images.unsplash.com/photo-1549488344-9f268a735c02?q=80&w=200&h=150&fit=crop',
  ),
  Reward(
    id: 'R04',
    name: 'Certificado de Destaque',
    description: 'Um reconhecimento formal da sua contribuição em inovação.',
    cost: 2000, 
    // Imagem mais adequada para "Certificado/Prêmio"
    imageUrl: 'https://images.unsplash.com/photo-1510936111840-692797e9de29?q=80&w=200&h=150&fit=crop',
  ),
];

// FUNÇÃO PARA GERAR COMENTÁRIOS ADICIONAIS DINAMICAMENTE
List<Comment> generateMockComments(int totalComments) {
  List<Comment> allComments = List.from(mockCommentsBase);
  
  int commentsToGenerate = totalComments - mockCommentsBase.length;
  if (commentsToGenerate <= 0) {
    return allComments;
  }
  
  const List<String> genericTexts = [
    'Excelente iniciativa!', 
    'Apoio totalmente essa ideia!', 
    'Isso vai revolucionar nosso ambiente.', 
    'Qual o próximo passo para implementação?',
    'Muitos pontos de XP para o autor!', 
    'Concordo, precisamos de mais integração entre os setores.',
  ];

  for (int i = 0; i < commentsToGenerate; i++) {
    int index = i % MOCK_OTHER_NAMES.length;
    allComments.add(
      Comment(
        author: MOCK_OTHER_NAMES[index] + ' ($i)',
        authorPicUrl: MOCK_OTHER_PICS[index],
        text: genericTexts[i % genericTexts.length],
        timeAgo: '${i + 1}min',
      ),
    );
  }
  return allComments;
}