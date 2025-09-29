import 'package:eurofarma_project/models/idea_model.dart';
import 'package:flutter/material.dart';

class IdeaListDetailScreen extends StatelessWidget {
  final String title;
  final List<Idea> ideas;

  const IdeaListDetailScreen({required this.title, required this.ideas, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue[900],
      ),
      body: ideas.isEmpty
          ? const Center(child: Text('Nenhuma ideia nesta categoria no momento.'))
          : ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: ideas.length,
              itemBuilder: (context, index) {
                final idea = ideas[index];
                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 0),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(idea.authorProfilePicUrl),
                    ),
                    title: Text(
                      idea.title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('Autor: ${idea.author} | Interações: ${idea.likes + idea.comments}'),
                    trailing: Text(idea.timeAgo, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                    onTap: () {
                      // Em um projeto real, navegaria para o detalhe da ideia/moderação
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Detalhes da ideia ID: ${idea.id}')),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}