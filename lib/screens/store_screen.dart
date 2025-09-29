import 'package:eurofarma_project/models/reward_model.dart';
import 'package:eurofarma_project/utils/mock_data.dart';
import 'package:flutter/material.dart';

class StoreScreen extends StatelessWidget {
  final int userPoints = 12500; 

  const StoreScreen({Key? key}) : super(key: key);

  void _handleRedeem(BuildContext context, Reward reward) {
    if (userPoints >= reward.cost) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sucesso! Você trocou ${reward.cost} pontos por ${reward.name}.')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pontos insuficientes para esta recompensa.', style: TextStyle(color: Colors.red))),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header com Saldo de Pontos
        Container(
          padding: const EdgeInsets.all(16.0),
          color: Colors.blue[50],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Seus Pontos:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Icon(Icons.star, color: Colors.amber[700]),
                  const SizedBox(width: 5),
                  Text(
                    userPoints.toString(),
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue[900]),
                  ),
                ],
              ),
            ],
          ),
        ),
        
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Troque seus pontos por recompensas exclusivas!',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),

        // Lista de Recompensas
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, 
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              // *** AJUSTE PRINCIPAL: Diminui a proporção altura/largura para achatar o card. ***
              childAspectRatio: 0.85, 
            ),
            itemCount: mockRewards.length,
            itemBuilder: (context, index) {
              final reward = mockRewards[index];
              return _buildRewardCard(context, reward);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildRewardCard(BuildContext context, Reward reward) {
    final bool canAfford = userPoints >= reward.cost;
    
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Imagem
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
              child: Image.network(
                reward.imageUrl,
                fit: BoxFit.cover,
                // Reduzindo o tamanho da imagem de erro/placeholder
                errorBuilder: (context, error, stackTrace) => const Icon(Icons.shopping_bag, size: 40, color: Colors.grey),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Ajustando a fonte do nome do item
                Text(
                  reward.name,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14), 
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber[700], size: 14), // Ícone menor
                    const SizedBox(width: 4),
                    Text(
                      reward.cost.toString(),
                      style: TextStyle(color: Colors.amber[700], fontWeight: FontWeight.bold, fontSize: 14), // Fonte menor
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  height: 35, // Altura do botão ligeiramente reduzida
                  child: ElevatedButton(
                    onPressed: canAfford ? () => _handleRedeem(context, reward) : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: canAfford ? Colors.green : Colors.grey[400],
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 0),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: Text(canAfford ? 'Resgatar' : 'Pontos Insuficientes', style: const TextStyle(fontSize: 12)), // Fonte menor no botão
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}