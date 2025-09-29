import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../utils/mock_data.dart'; 
import '../models/idea_model.dart'; 
import '../models/moderation_model.dart'; 
import 'idea_list_detail_screen.dart'; 
import 'idea_detail_screen.dart'; 

class AdminPanelScreen extends StatefulWidget {
  AdminPanelScreen({Key? key}) : super(key: key);

  @override
  State<AdminPanelScreen> createState() => _AdminPanelScreenState();
}

class _AdminPanelScreenState extends State<AdminPanelScreen> {
  
  // MOCK: Dados do Engajamento por Área (Gráfico de Barras)
  final List<BarChartGroupData> engagementData = [
    BarChartGroupData(x: 0, barRods: [BarChartRodData(toY: 100, color: Colors.blue)]),
    BarChartGroupData(x: 1, barRods: [BarChartRodData(toY: 150, color: Colors.red)]),
    BarChartGroupData(x: 2, barRods: [BarChartRodData(toY: 70, color: Colors.amber)]),
  ];

  // MOCK: Dados da Distribuição de Ideias (Gráfico de Pizza)
  final List<PieChartSectionData> ideaDistributionData = [
    PieChartSectionData(value: 80, title: 'Aprovadas (80)', color: Colors.green, radius: 60, titleStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white)),
    PieChartSectionData(value: 23, title: 'Análise (23)', color: Colors.amber, radius: 50, titleStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white)),
    PieChartSectionData(value: 28, title: 'Novas (28)', color: Colors.orange, radius: 70, titleStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white)),
  ];

  // FUNÇÃO DE MODERAÇÃO CENTRAL
  void _moderateIdea(String ideaId, bool approved) {
    setState(() {
      final ideaIndex = mockIdeas.indexWhere((i) => i.id == ideaId);
      
      if (ideaIndex != -1) {
        final newStatus = approved ? 'Approved' : 'Rejected';
        final ideaTitle = mockIdeas[ideaIndex].title;
        
        mockIdeas[ideaIndex].status = newStatus;

        mockModerationItems.removeWhere((i) => i.id == ideaId);
        
        final actionText = approved ? 'APROVADA!' : 'REPROVADA (Status: Rejected).';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ideia "${ideaTitle}" marcada como $actionText. KPI atualizado.')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Erro: Ideia não encontrada na lista principal.')),
        );
      }
    });
  }

  // Ação para o botão DETALHES: AGORA COM TRATAMENTO DE ERROS (try-catch)
  void _viewDetails(ModerationItem item) {
    try {
      // 1. Tenta encontrar a ideia principal, jogando um erro se não achar
      final idea = mockIdeas.firstWhere(
        (i) => i.id == item.id, 
        orElse: () => throw Exception('Ideia principal com ID ${item.id} não encontrada nos mockIdeas.'),
      );
      
      // 2. Navegação só ocorre se a ideia for encontrada
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => IdeaDetailScreen(
            idea: idea,
            onModerationComplete: _moderateIdea, 
          ),
        ),
      );
    } catch (e) {
      // 3. Captura a exceção e mostra uma mensagem de erro sem travar a aplicação
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('ERRO: Não foi possível carregar os detalhes da ideia. Detalhe: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // LÓGICA DE FILTRAGEM DE KPIS 
    final List<Idea> novasIdeias = mockIdeas.where((i) => i.status == 'Pending').toList();
    final List<Idea> emAnalise = mockIdeas.where((i) => i.status == 'In Review').toList();
    final List<Idea> aprovadas = mockIdeas.where((i) => i.status == 'Approved').toList();
    final List<Idea> reprovadas = mockIdeas.where((i) => i.status == 'Rejected').toList(); 
    
    final int totalNovas = novasIdeias.length; 
    final int totalEmAnalise = emAnalise.length; 
    final int totalAprovadas = aprovadas.length; 
    final int totalReprovadas = reprovadas.length; 
    final int totalIdeias = mockIdeas.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Painel Administrativo (RH/Gestor)', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue[900],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Métricas Chave (KPIs)',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),

            // --- Grid de Cartões de Métricas COM AÇÃO DE DETALHE ---
            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildMetricCard(context, 'Novos Projetos', totalNovas.toString(), Colors.orange, novasIdeias), 
                _buildMetricCard(context, 'Ideias em Análise', totalEmAnalise.toString(), Colors.yellow, emAnalise), 
                _buildMetricCard(context, 'Ideias Aprovadas', totalAprovadas.toString(), Colors.green, aprovadas), 
                _buildMetricCard(context, 'Ideias Reprovadas', totalReprovadas.toString(), Colors.red, reprovadas), 
                _buildMetricCard(context, 'Total de Ideias', totalIdeias.toString(), Colors.blue, mockIdeas), 
              ],
            ),
            
            const SizedBox(height: 30),
            
            // --- GRÁFICO 1: Engajamento por Área (Barra) ---
            const Text(
              'Engajamento por Área (Interações)', 
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Container(
              height: 250,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: BarChart(
                BarChartData(
                  barGroups: engagementData, 
                  titlesData: FlTitlesData(
                    show: true,
                    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          const titles = ['Financeiro', 'TI', 'Comercial'];
                          return SideTitleWidget(
                            axisSide: meta.axisSide,
                            space: 4,
                            child: Text(titles[value.toInt()], style: const TextStyle(fontSize: 10)),
                          );
                        },
                      ),
                    ),
                  ),
                  gridData: const FlGridData(show: false),
                  borderData: FlBorderData(show: true, border: Border.all(color: Colors.grey.shade200)),
                ),
              ),
            ),
            
            const SizedBox(height: 30),

            // --- GRÁFICO 2: Distribuição de Ideias (Pizza) ---
            const Text(
              'Status das Ideias', 
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            Container(
              height: 250,
              padding: const EdgeInsets.all(10),
              child: PieChart(
                PieChartData(
                  sections: ideaDistributionData, 
                  borderData: FlBorderData(show: false),
                  sectionsSpace: 2,
                  centerSpaceRadius: 40,
                ),
              ),
            ),


            const SizedBox(height: 30),
            
            // Fila de Moderação (RF09)
            const Text(
              'Fila de Moderação de Ideias',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),

            // Renderiza a lista de moderação
            mockModerationItems.isEmpty
                ? const Center(child: Text('Nenhum item pendente de moderação.'))
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: mockModerationItems.length,
                    itemBuilder: (context, index) {
                      final item = mockModerationItems[index];
                      return _buildModerationItem(context, item);
                    },
                  ),
          ],
        ),
      ),
    );
  }

  // Widget para os Cartões de Métricas (KPIs) - COM AÇÃO DE CLICK
  Widget _buildMetricCard(BuildContext context, String title, String value, Color color, List<Idea> ideas) {
    return GestureDetector(
      onTap: () {
        // Navega para a lista de ideias filtradas ao clicar no card
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => IdeaListDetailScreen(title: title, ideas: ideas),
          ),
        );
      },
      child: Card(
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 14),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    value,
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: color),
                  ),
                  // Ícone de detalhe
                  Icon(Icons.arrow_forward_ios, size: 20, color: color.withOpacity(0.7)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  // Widget para Itens na Fila de Moderação (RF09) - COM BOTÕES FUNCIONAIS
  Widget _buildModerationItem(BuildContext context, ModerationItem item) {
    return Card(
      elevation: 1,
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        title: Text(item.title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(item.status),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Botão DETALHES (Navega para a tela de detalhe e passa o callback)
            if (item.action == 'Detalhes')
              TextButton(
                onPressed: () => _viewDetails(item),
                child: Text('Detalhes', style: TextStyle(color: item.actionColor, fontWeight: FontWeight.bold)),
              ),
            
            // Botão APROVAR (Chama a função de moderação)
            if (item.action == 'Aprovar')
              TextButton(
                onPressed: () => _moderateIdea(item.id, true),
                child: Text('Aprovar', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
              ),

            // Botão REPROVAR (Chama a função de moderação)
            if (item.action == 'Reprovar')
              TextButton(
                onPressed: () => _moderateIdea(item.id, false),
                child: Text('Reprovar', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
              ),
          ],
        ),
      ),
    );
  }
}