import 'package:flutter/material.dart';
import '../models/idea_model.dart';
import '../utils/mock_data.dart'; 

class IdeaDetailScreen extends StatelessWidget {
  final Idea idea;
  final Function(String ideaId, bool approved)? onModerationComplete; 

  const IdeaDetailScreen({
    required this.idea, 
    this.onModerationComplete, 
    Key? key
  }) : super(key: key);

  void _handleAction(BuildContext context, bool approved) {
    if (onModerationComplete != null) {
        onModerationComplete!(idea.id, approved);
    }
    Navigator.pop(context);
  }

  // WIDGET AUXILIAR CORRIGIDO: Remove o Expanded interno e usa apenas a Row.
  Widget _buildDetailRow(String label, String value, Color color) {
    // Usamos um SizedBox para dar largura fixa ao label e deixamos o valor flexível
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        // Removido mainAxisAlignment.spaceBetween para evitar que a Row interna exija largura total
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140, // Largura fixa para o rótulo
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          // Usamos Expanded para garantir que o valor preencha o restante do espaço horizontal
          Expanded( 
            child: Text(
              value,
              style: TextStyle(color: color, fontWeight: FontWeight.bold),
              // Adicionado overflow.ellipsis para segurança, caso o texto seja muito longo
              overflow: TextOverflow.ellipsis, 
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCommentItem(Map<String, String> comment) {
    // ... (Mantido, usa List<Map>)
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 15,
            backgroundImage: NetworkImage(comment['pic']!),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      comment['author']!,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      '· ${comment['time']!}',
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Text(comment['text']!),
              ],
            ),
          ),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    final bool isAdminMode = onModerationComplete != null;
    final int totalMockComments = idea.comments;
    
    // Lista de comentários para exibição
    final List<Map<String, String>> commentsToShow = getSimpleMockComments(isAdminMode ? totalMockComments : 3);
    final bool showViewAllButton = !isAdminMode && totalMockComments > commentsToShow.length;

    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes: ${idea.title}', style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue[900],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- CABEÇALHO E DESCRIÇÃO ---
                  Row(
                    children: [
                      CircleAvatar(radius: 20, backgroundImage: NetworkImage(idea.authorProfilePicUrl)),
                      const SizedBox(width: 10),
                      Text(idea.author, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    ],
                  ),
                  const Divider(height: 25),
                  
                  Text(idea.description, style: const TextStyle(fontSize: 16, height: 1.5)),
                  const Divider(height: 30),

                  // --- METRICAS DE INTERAÇÃO/GESTAO (CORREÇÃO DE LAYOUT APLICADA) ---
                  // A Row principal da tela agora está em Column (SingleChildScrollView),
                  // mas a Row interna (que causava o erro) foi corrigida no _buildDetailRow.
                  
                  _buildDetailRow('Status:', idea.status, Colors.blue),
                  _buildDetailRow('XP:', '${idea.xpReward} pts', Colors.green),
                  _buildDetailRow('Nível de Impacto:', idea.impactLevel, Colors.orange),
                  _buildDetailRow('Curtidas:', idea.likes.toString(), Colors.grey),

                  // --- SEÇÃO DE COMENTÁRIOS ---
                  const Divider(height: 30),
                  Text(
                    'Comentários ($totalMockComments)', 
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),

                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: commentsToShow.length, 
                    itemBuilder: (context, index) {
                      return _buildCommentItem(commentsToShow[index]);
                    },
                  ),
                  
                  // Botão "Ver Todos" (Mock visual)
                  if (showViewAllButton)
                    TextButton(
                        onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Simulando carregamento de $totalMockComments comentários (API)...'))
                            );
                        },
                        child: Text('Ver todos os $totalMockComments comentários', style: TextStyle(color: Colors.blue[900])),
                    ),


                  // Botões de Admin (Se aplicável)
                  if (isAdminMode)
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () => _handleAction(context, true), 
                            icon: const Icon(Icons.check, color: Colors.white),
                            label: const Text('Aprovar Ideia', style: TextStyle(color: Colors.white)),
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                          ),
                          ElevatedButton.icon(
                            onPressed: () => _handleAction(context, false), 
                            icon: const Icon(Icons.close, color: Colors.white),
                            label: const Text('Reprovar', style: TextStyle(color: Colors.white)),
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
          
          // --- CAIXA DE INPUT PARA COMENTÁRIOS (APENAS PARA COLABORADOR) ---
          if (!isAdminMode)
             Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(top: BorderSide(color: Colors.grey.shade200)),
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
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Comentário simulado enviado!'))
                        );
                      },
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