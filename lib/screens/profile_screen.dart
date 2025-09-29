import 'package:eurofarma_project/screens/admin_panel_screen.dart';
import 'package:eurofarma_project/utils/mock_data.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  void _navigateToAdmin(BuildContext context) {
    // Simula que apenas Gestores/RH podem acessar este painel
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => AdminPanelScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    const int currentLevel = 7; 
    const double xpProgress = 0.75;
    const int maxAchievements = 20;
    const int achievedCount = 5; 

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Cabeçalho (Imagem de Perfil e Informações)
          Row(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(MOCK_PIC_FELIPE), 
              ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Felipe Pereira Meschiatti',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Desenvolvedor Pleno',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
          const Divider(height: 20),

          // --- NOVO: Botão de Acesso ao Painel Administrativo (RF09) ---
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () => _navigateToAdmin(context),
              icon: const Icon(Icons.dashboard, color: Colors.red),
              label: const Text('Acessar Painel Admin', style: TextStyle(color: Colors.red)),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.red),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
          const Divider(height: 40),
          // --- FIM NOVO BOTÃO ---

          // Progressão de XP/Nível (RF05)
          Row(
            // ... (código de XP e Nível)
          ),
          const SizedBox(height: 10),
          // Barra de Progresso
          LinearProgressIndicator(
            value: xpProgress,
            backgroundColor: Colors.grey[300],
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.yellow),
            minHeight: 15,
          ),
          const SizedBox(height: 40),

          // Seção de Conquistas (RF06)
          // ... (código de Conquistas)
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Conquistas',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                'Max $achievedCount de $maxAchievements',
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 20),
          
          _buildAchievementItem(Icons.settings, 'Primeira Configuração', 0.9),
          _buildAchievementItem(Icons.alternate_email, 'Colaborador Ativo', 0.5),
          _buildAchievementItem(Icons.wifi_tethering, 'Ideia Aprovada', 0.8),
        ],
      ),
    );
  }

  // (Métodos auxiliares _buildAchievementItem mantidos)
  Widget _buildAchievementItem(IconData icon, String title, double progress) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.blue[900], size: 30),
              const SizedBox(width: 10),
              Text(title, style: const TextStyle(fontSize: 16)),
            ],
          ),
          const SizedBox(height: 5),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey[300],
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
            minHeight: 10,
          ),
        ],
      ),
    );
  }
}