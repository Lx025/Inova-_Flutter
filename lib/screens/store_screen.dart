import 'package:eurofarma_project/models/reward_model.dart';
import 'package:eurofarma_project/utils/mock_data.dart';
import 'package:flutter/material.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({Key? key}) : super(key: key);

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  int _userPoints = 12500; 
  final Map<String, DateTime> _redeemedCooldowns = {};

  bool _isRewardOnCooldown(String rewardId) {
    final cooldownTime = _redeemedCooldowns[rewardId];
    if (cooldownTime == null) {
      return false;
    }
    return DateTime.now().isBefore(cooldownTime);
  }

  void _handleRedeem(BuildContext context, Reward reward) {
    if (_isRewardOnCooldown(reward.id)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Este item já foi resgatado recentemente. Espere o prazo de 1 semana para novo resgate.', style: TextStyle(color: Colors.orange))),
      );
      return;
    }

    if (_userPoints >= reward.cost) {
      setState(() {
        _userPoints -= reward.cost;
        _redeemedCooldowns[reward.id] = DateTime.now().add(const Duration(days: 7));
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sucesso! Você trocou ${reward.cost} pontos por ${reward.name}. Seu novo saldo é $_userPoints pontos.')),
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
                    _userPoints.toString(), 
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue[900]),
                  ),
                ],
              ),
            ],
          ),
        ),
        
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            'Troque seus pontos por recompensas exclusivas!',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ),

        // Lista de Recompensas
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // ALTERADO: 3 itens por linha (melhor usabilidade)
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 0.65, // ALTERADO: Reduz drasticamente a altura do card
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
    final bool canAfford = _userPoints >= reward.cost;
    final bool isRedeemedOnCooldown = _isRewardOnCooldown(reward.id);
    
    String buttonText;
    Color buttonColor;
    VoidCallback? onPressed;

    if (isRedeemedOnCooldown) {
      buttonText = 'Resgatado';
      buttonColor = Colors.grey[600]!;
      onPressed = null;
    } else if (!canAfford) {
      buttonText = 'Falta Pontos';
      buttonColor = Colors.grey[400]!;
      onPressed = null;
    } else {
      buttonText = 'Resgatar';
      buttonColor = Colors.green;
      onPressed = () => _handleRedeem(context, reward);
    }
    
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Imagem
          Expanded(
            flex: 4, // Dá mais espaço para a imagem
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
              child: Image.network(
                reward.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Center(child: Icon(Icons.shopping_bag, size: 30, color: Colors.grey)),
              ),
            ),
          ),
          // Conteúdo do Card
          Expanded(
            flex: 3, // Espaço para texto e botão
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Nome do Item (Fonte bem reduzida)
                  Text(
                    reward.name,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 10), 
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  // Descrição (Nova Adição)
                  Text(
                    reward.description,
                    style: const TextStyle(fontSize: 8, color: Colors.grey), 
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  // Custo
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber[700], size: 10), 
                      const SizedBox(width: 2),
                      Text(
                        reward.cost.toString(),
                        style: TextStyle(color: Colors.amber[700], fontWeight: FontWeight.bold, fontSize: 10), 
                      ),
                    ],
                  ),
                  // Botão
                  SizedBox(
                    width: double.infinity,
                    height: 25, // Altura do botão bastante reduzida
                    child: ElevatedButton(
                      onPressed: onPressed, 
                      style: ElevatedButton.styleFrom(
                        backgroundColor: buttonColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 0),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                        textStyle: const TextStyle(fontSize: 9), // Fonte do botão minúscula
                        minimumSize: Size.zero, 
                      ),
                      child: Text(buttonText), 
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}