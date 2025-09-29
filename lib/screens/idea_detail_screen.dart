import 'package:eurofarma_project/models/idea_model.dart';
import 'package:eurofarma_project/utils/mock_data.dart';
import 'package:flutter/material.dart';

class IdeaDetailScreen extends StatelessWidget {
  final Idea idea;

  const IdeaDetailScreen({required this.idea, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Geração dinâmica dos comentários para simular o volume total
    final List<Comment> allComments = generateMockComments(idea.comments);

    return Scaffold(
      appBar: AppBar(
        title: Text(idea.title, style: const TextStyle(color: Colors.white, fontSize: 16)),
        backgroundColor: Colors.blue[900],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Cabeçalho da Ideia e Autor
              Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(idea.authorProfilePicUrl),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        idea.author,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Text(
                        'Postado há ${idea.timeAgo}',
                        style: const TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
              const Divider(height: 30),

              // Descrição Completa da Ideia
              Text(
                idea.description, 
                style: const TextStyle(fontSize: 16, height: 1.5),
              ),
              const Divider(height: 30),

              // Interações (Likes/Comentários)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildInteractionCount(Icons.thumb_up_alt_outlined, idea.likes),
                  // Usando o número total para a contagem visual
                  _buildInteractionCount(Icons.comment_outlined, idea.comments), 
                ],
              ),
              const Divider(height: 30),

              // Seção de Comentários
              Text(
                'Comentários (${allComments.length})', // A contagem é o tamanho da lista gerada
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              
              // Lista de Comentários (usando a lista completa)
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: allComments.length,
                itemBuilder: (context, index) {
                  return _buildCommentItem(allComments[index]);
                },
              ),
            ],
          ),
        ),
      ),
      // Campo de Input para novos comentários
      bottomNavigationBar: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), spreadRadius: 1, blurRadius: 5)],
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Adicionar um comentário...',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.send, color: Colors.blue[900]),
                onPressed: () {
                  // Lógica para enviar comentário
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInteractionCount(IconData icon, int count) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey),
        const SizedBox(width: 5),
        Text('$count', style: const TextStyle(color: Colors.grey)),
      ],
    );
  }

  Widget _buildCommentItem(Comment comment) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 15,
            backgroundImage: NetworkImage(comment.authorPicUrl),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      comment.author,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      '· ${comment.timeAgo}',
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Text(comment.text),
              ],
            ),
          ),
        ],
      ),
    );
  }
}