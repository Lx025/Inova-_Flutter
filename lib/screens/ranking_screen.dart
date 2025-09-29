import 'package:eurofarma_project/utils/mock_data.dart';
import 'package:flutter/material.dart';

class RankingScreen extends StatelessWidget {
  const RankingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Top 5', // [cite: 163]
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF0D47A1)),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: mockRanking.length,
              itemBuilder: (context, index) {
                final user = mockRanking[index];
                return _buildRankingItem(
                  user.position,
                  user.name,
                  user.profilePicUrl, // Passa a URL da imagem
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRankingItem(int position, String name, String profilePicUrl) {
    // Layout baseado na Page 10 [cite: 164-169]
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      decoration: BoxDecoration(
        color: const Color(0xFF1565C0), // Azul escuro
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Posição
          Text(
            '${position}º',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 20),
          
          // --- ALTERAÇÃO: Inclusão da Imagem do Ranking ao lado do nome ---
          CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(profilePicUrl),
            backgroundColor: Colors.white,
          ),
          const SizedBox(width: 15),
          
          // Nome
          Text(
            name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}