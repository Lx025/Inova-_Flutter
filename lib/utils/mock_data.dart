import 'package:flutter/material.dart';
import '../models/idea_model.dart';
import '../models/reward_model.dart'; 
import '../models/moderation_model.dart'; 
// REMOVIDO: import '../models/comment_model.dart'; (O Comment é um Map<String, String> agora)

// --- 1. MOCK DE IMAGENS E USUÁRIOS (IDs Fixos para URLs Mockadas) ---
const String MOCK_PIC_FELIPE = 'https://picsum.photos/id/1012/100/100';
const String MOCK_PIC_PEDRO = 'https://picsum.photos/id/1025/100/100';
const String MOCK_PIC_VITORIA = 'https://picsum.photos/id/1027/100/100';
const String MOCK_PIC_LEONARDO = 'https://picsum.photos/id/1026/100/100';
const String MOCK_PIC_LUCAS = 'https://picsum.photos/id/1011/100/100';

// Nomes e URLs auxiliares (usados na geração de comentários)
const List<String> MOCK_OTHER_NAMES = [
  'Ana Silva', 'Bruno Costa', 'Mariana Gomes', 'Ricardo Nunez', 'Juliana Lima'
];
const List<String> MOCK_OTHER_PICS = [
  'https://picsum.photos/id/50/100/100', 'https://picsum.photos/id/60/100/100',
  'https://picsum.photos/id/70/100/100', 'https://picsum.photos/id/80/100/100',
  'https://picsum.photos/id/90/100/100'
];


// --- 2. LISTA PRINCIPAL DE IDEIAS (MUTÁVEL E COMPLETA) ---
List<Idea> mockIdeas = [
  // IDEIA 1/5: Pedro Henrique (Pending -> Na fila de moderação)
  Idea(
    id: '1',
    title: 'Aumentar o espaço de convivência entre as diferentes áreas da empresa.',
    description: 'A ideia é criar um lounge central onde colaboradores de diferentes setores (TI, Financeiro, Comercial) possam interagir informalmente, promovendo a troca de conhecimento e a colaboração.',
    author: 'Pedro Henrique',
    authorProfilePicUrl: MOCK_PIC_PEDRO, 
    timeAgo: '12h',
    likes: 87, 
    comments: 353, 
    status: 'Pending', 
    impactLevel: 'Alto',
    xpReward: 100,
  ),
  // IDEIA 2/5: Vitoria Cerqueira (Pending -> Na fila de moderação)
  Idea(
    id: '2',
    title: 'Digitalização de Processos de RH.',
    description: 'Proposta para automatizar a admissão de novos colaboradores através de um app, reduzindo o uso de papel e o tempo de onboarding em 30%.',
    author: 'Vitoria Cerqueira',
    authorProfilePicUrl: MOCK_PIC_VITORIA,
    timeAgo: '1d',
    likes: 154,
    comments: 42,
    status: 'Pending', 
    impactLevel: 'Médio',
    xpReward: 50,
  ),
  // IDEIA 3/5: Felipe Pereira (In Review -> Na fila de moderação)
  Idea(
    id: '3',
    title: 'Uso de IA para otimização da cadeia de suprimentos farmacêutica.',
    description: 'Proponho um sistema de aprendizado de máquina no backend (Python/Java) para prever picos de demanda e ajustar estoques, minimizando perdas e otimizando o armazenamento na AWS S3.',
    author: 'Felipe Pereira',
    authorProfilePicUrl: MOCK_PIC_FELIPE,
    timeAgo: '2d',
    likes: 78,
    comments: 15,
    status: 'In Review', 
    impactLevel: 'Crítico',
    xpReward: 120,
  ),
  // IDEIA 4/5: Leonardo Queiroz (Approved -> Já Aprovada)
  Idea(
    id: '4',
    title: 'Desafio Semanal Temático: Redução de Carbono na Produção.',
    description: 'Criar um Desafio Semanal dentro do app para que os colaboradores sugiram formas de reduzir o impacto ambiental.',
    author: 'Leonardo Queiroz',
    authorProfilePicUrl: MOCK_PIC_LEONARDO,
    timeAgo: '4d',
    likes: 21,
    comments: 5,
    status: 'Approved', 
    impactLevel: 'Baixo',
    xpReward: 30,
  ),
  // IDEIA 5/5: Lucas Henrique (Approved -> Já Aprovada)
  Idea(
    id: '5',
    title: 'Implementação de programa de mentoria reversa em tecnologia.',
    description: 'Criar um sistema de mentoria onde colaboradores mais jovens (digitais) ensinam os mais experientes sobre novas tecnologias e o uso do próprio aplicativo.',
    author: 'Lucas Henrique',
    authorProfilePicUrl: MOCK_PIC_LUCAS,
    timeAgo: '1 sem',
    likes: 99,
    comments: 28,
    status: 'Approved', 
    impactLevel: 'Alto',
    xpReward: 80,
  ),
];


// --- 3. LISTA DE RANKING (RF07) ---
final List<RankingUser> mockRanking = [
  RankingUser(position: 1, name: 'Felipe Pereira', profilePicUrl: MOCK_PIC_FELIPE),
  RankingUser(position: 2, name: 'Pedro Henrique', profilePicUrl: MOCK_PIC_PEDRO),
  RankingUser(position: 3, name: 'Vitoria Cerqueira', profilePicUrl: MOCK_PIC_VITORIA),
  RankingUser(position: 4, name: 'Leonardo Queiroz', profilePicUrl: MOCK_PIC_LEONARDO),
  RankingUser(position: 5, name: 'Lucas Henrique', profilePicUrl: MOCK_PIC_LUCAS),
];


// --- 4. LISTA DE RECOMPENSAS (LOJA - RF08) ---
final List<Reward> mockRewards = [
  Reward(
    id: 'R01',
    name: 'Vale R\$100',
    description: 'Cartão presente em lojas parceiras.',
    cost: 5000, 
    imageUrl: 'https://images.unsplash.com/photo-1579546929518-971f15aa0252?q=80&w=200&h=150&fit=crop',
  ),
  Reward(
    id: 'R02',
    name: 'Dia de Folga',
    description: 'Um dia de descanso remunerado extra.',
    cost: 15000, 
    imageUrl: 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?q=80&w=200&h=150&fit=crop',
  ),
  Reward(
    id: 'R03',
    name: 'Café com Diretor',
    description: 'Sessão de networking com a liderança.',
    cost: 8000, 
    imageUrl: 'https://images.unsplash.com/photo-1549488344-9f268a735c02?q=80&w=200&h=150&fit=crop',
  ),
  Reward(
    id: 'R04',
    name: 'Certificado',
    description: 'Reconhecimento formal por sua inovação.',
    cost: 2000, 
    imageUrl: 'https://images.unsplash.com/photo-1510936111840-692797e9de29?q=80&w=200&h=150&fit=crop',
  ),
  Reward(
    id: 'R05',
    name: 'Kit Escritório',
    description: 'Material de escritório premium.',
    cost: 3500, 
    imageUrl: 'https://images.unsplash.com/photo-1587561838612-401799446f05?q=80&w=200&h=150&fit=crop',
  ),
  Reward(
    id: 'R06',
    name: 'Assinatura PRO',
    description: 'Acesso Pro a ferramenta de produtividade.',
    cost: 7000, 
    imageUrl: 'https://images.unsplash.com/photo-1517058865203-c3577d24660d?q=80&w=200&h=150&fit=crop',
  ),
  Reward(
    id: 'R07',
    name: 'Almoço Gourmet',
    description: 'Almoço especial em restaurante selecionado.',
    cost: 6500, 
    imageUrl: 'https://images.unsplash.com/photo-1517688029517-57303c72b226?q=80&w=200&h=150&fit=crop',
  ),
  Reward(
    id: 'R08',
    name: 'Doação ONG',
    description: 'Doação em seu nome para uma ONG.',
    cost: 1000, 
    imageUrl: 'https://images.unsplash.com/photo-1532629399222-38520281cc93?q=80&w=200&h=150&fit=crop',
  ),
  Reward(
    id: 'R09',
    name: 'Mentor. Pessoal',
    description: 'Sessão de mentoria individual (RF11).',
    cost: 9000, 
    imageUrl: 'https://images.unsplash.com/photo-1454165804606-c3d57bc86b40?q=80&w=200&h=150&fit=crop',
  ),
  Reward(
    id: 'R10',
    name: 'Camiseta Inova',
    description: 'Camiseta exclusiva do projeto Inova+.',
    cost: 1500, 
    imageUrl: 'https://images.unsplash.com/photo-1583743814966-8936081d89b6?q=80&w=200&h=150&fit=crop',
  ),
];


// --- 5. LISTA DE MODERAÇÃO (RF09) ---
List<ModerationItem> mockModerationItems = [
  // M01 -> Corresponde a Idea com ID '1' (Aprovar)
  ModerationItem(
    id: '1',
    title: 'RF01. Acessibilidade na fábrica',
    status: 'Aguardando aprovação do Gestor',
    action: 'Aprovar',
    actionColor: Colors.green,
  ),
  // M02 -> Corresponde a Idea com ID '3' (Detalhes)
  ModerationItem(
    id: '3',
    title: 'RF02. Automação do setor X',
    status: 'Em análise pelo Comitê de Inovação',
    action: 'Detalhes',
    actionColor: Colors.blue,
  ),
  // M03 -> Corresponde a Idea com ID '2' (Reprovar)
  ModerationItem(
    id: '2',
    title: 'RF03. Novo canal de vendas',
    status: 'Necessita de validação de RH/Financeiro',
    action: 'Reprovar',
    actionColor: Colors.red,
  ),
];


// --- 6. FUNÇÃO AUXILIAR DE COMENTÁRIOS (Retorna List<Map> para estabilidade) ---
// Esta é a lista de comentários simples que é usada na IdeaDetailScreen.
List<Map<String, String>> getSimpleMockComments(int totalComments) {
    // Comentários iniciais fixos
    final List<Map<String, String>> mockCommentsBase = [
      {'author': 'Felipe Meschiatti', 'pic': MOCK_PIC_FELIPE, 'text': 'Ótimo tema!', 'time': '12h'},
      {'author': 'Pedro Henrique', 'pic': MOCK_PIC_PEDRO, 'text': 'Parabéns, ficou ótimo!', 'time': '12h'},
      {'author': 'Leonardo Queiroz', 'pic': MOCK_PIC_LEONARDO, 'text': 'Achei a ideia muito relevante!', 'time': '11h'},
    ];
    
    List<Map<String, String>> allComments = List.from(mockCommentsBase);
    int commentsToGenerate = totalComments - mockCommentsBase.length;

    if (commentsToGenerate <= 0) {
      return allComments;
    }
    
    const List<String> genericTexts = ['Excelente iniciativa!', 'Apoio totalmente essa ideia!', 'Isso vai revolucionar nosso ambiente.', 'Muitos pontos de XP!'];


    for (int i = 0; i < commentsToGenerate; i++) {
      int index = i % MOCK_OTHER_NAMES.length;
      allComments.add({
        'author': MOCK_OTHER_NAMES[index] + ' ($i)',
        'pic': MOCK_OTHER_PICS[index % MOCK_OTHER_PICS.length],
        'text': genericTexts[i % genericTexts.length],
        'time': '${i + 1}min',
      });
    }
    return allComments;
}