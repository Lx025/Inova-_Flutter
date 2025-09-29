import 'package:eurofarma_project/models/idea_model.dart';
import 'package:eurofarma_project/screens/idea_detail_screen.dart';
import 'package:flutter/material.dart';

class IdeaCard extends StatelessWidget {
  final Idea idea;

  const IdeaCard({required this.idea, Key? key}) : super(key: key);

  void _navigateToDetail(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => IdeaDetailScreen(
          idea: idea,
          // *** OBRIGATÓRIO: NÃO passe onModerationComplete aqui! ***
          // Ele é opcional, então omitir a passagem está correto.
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cabeçalho da Ideia com Imagem do Autor
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(idea.authorProfilePicUrl),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        idea.author, 
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      Text(
                        'Postado há ${idea.timeAgo}',
                        style: const TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Conteúdo da Ideia
            Text(
              idea.title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            
            // Botões de Interação (RF03)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Likes: usando o dado mockado
                _buildInteractionButton(Icons.thumb_up_alt_outlined, idea.likes.toString()),
                
                // Comentários: Usando o dado mockado, corrigindo a inconsistência!
                _buildInteractionButton(Icons.comment_outlined, idea.comments.toString()), 
                
                // Compartilhar
                _buildInteractionButton(Icons.send_outlined, ''),
                
                // Botão para abrir o texto completo/comentários
                TextButton(
                  onPressed: () => _navigateToDetail(context),
                  // Link usa o mesmo valor de comments, garantindo a consistência
                  child: Text('Ver todos os ${idea.comments} comentários'), 
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInteractionButton(IconData icon, String count) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.blue[900]),
        const SizedBox(width: 5),
        Text(count, style: TextStyle(color: Colors.blue[900])),
      ],
    );
  }
}