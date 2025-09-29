import 'package:eurofarma_project/utils/mock_data.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Dados Mockados para XP e Conquistas (RF04, RF05, RF06)
    const int currentLevel = 7; // [cite: 204]
    const double xpProgress = 0.75;
    const int maxAchievements = 20;
    const int achievedCount = 5; // [cite: 206]

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Cabeçalho (Imagem de Perfil e Informações)
          Row(
            children: [
              // --- ALTERAÇÃO: Inclusão da Imagem do Perfil do Usuário ---
              CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(MOCK_PIC_FELIPE), // Imagem de Perfil Mockada [cite: 202]
              ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Felipe Pereira Meschiatti', // [cite: 202]
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Desenvolvedor Pleno', // [cite: 202]
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
          const Divider(height: 40),

          // Progressão de XP/Nível (RF05)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Próximo Nível', style: TextStyle(fontSize: 16, color: Colors.grey)),
              Text('XP: ${currentLevel * 100}/${(currentLevel + 1) * 100}', style: const TextStyle(fontSize: 16, color: Colors.grey)),
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.yellow, size: 24),
                  Text(
                    ' $currentLevel', // Nível [cite: 204]
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                ],
              ),
            ],
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Conquistas', // [cite: 205]
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                'Max $achievedCount de $maxAchievements', // [cite: 206]
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 20),
          
          // Lista de Conquistas Mockadas
          _buildAchievementItem(Icons.settings, 'Primeira Configuração', 0.9),
          _buildAchievementItem(Icons.alternate_email, 'Colaborador Ativo', 0.5),
          _buildAchievementItem(Icons.wifi_tethering, 'Ideia Aprovada', 0.8),
        ],
      ),
    );
  }

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