import 'package:eurofarma_project/screens/home_screen.dart';
import 'package:eurofarma_project/widgets/upload_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class InnovationSubmissionScreen extends StatefulWidget {
  const InnovationSubmissionScreen({Key? key}) : super(key: key);

  @override
  State<InnovationSubmissionScreen> createState() => _InnovationSubmissionScreenState();
}

class _InnovationSubmissionScreenState extends State<InnovationSubmissionScreen> {
  String? _attachedFile; // Variável de estado para mostrar o nome do arquivo anexado

  // Função para abrir o Diálogo de Upload (NOVA FUNCIONALIDADE)
  void _openUploadDialog(BuildContext context) async {
    // Exibe o diálogo e espera o resultado (o tipo de arquivo mockado)
    final result = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return const UploadDialog();
      },
    );

    if (result != null) {
      setState(() {
        _attachedFile = result; // Atualiza o estado para exibir o anexo
      });
      if (kDebugMode) {
        print('Resultado do Upload: $result');
      }
    }
  }

  void _handleSubmit(BuildContext context) {
    // Lógica de submissão (simulação)
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const SubmissionSuccessScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Layout baseado na Page 11 [cite: 176-181]
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // User Information (Mocked) [cite: 176]
          const Text(
            'Felipe Pereira Meschiatti',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const Text(
            'Desenvolvedor Pleno',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const Divider(height: 30),

          // Idea Title Field [cite: 177]
          const Text('Título da sua inovação', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Digite o título aqui...',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),

          // Idea Description Field [cite: 178]
          const Text('Escreva aqui:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          TextFormField(
            maxLines: 6,
            decoration: const InputDecoration(
              hintText: 'Descreva sua ideia em detalhes...',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),

          // Upload File (RF02 - Imagem/Áudio) 
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              // Chamada para a função de upload
              onPressed: () => _openUploadDialog(context),
              icon: const Icon(Icons.cloud_upload_outlined),
              label: const Text('UPLOAD DE ARQUIVO'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
            ),
          ),
          
          // NOVO: Exibe o nome do arquivo anexado (se houver)
          if (_attachedFile != null)
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                'Anexo: $_attachedFile',
                style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
              ),
            ),
          
          const SizedBox(height: 30),

          // Submit Button [cite: 181]
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () => _handleSubmit(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4CAF50), // Green for submission
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Enviar', style: TextStyle(fontSize: 18)),
            ),
          ),
        ],
      ),
    );
  }
}


// Success Screen (Page 12)
class SubmissionSuccessScreen extends StatelessWidget {
  const SubmissionSuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inova+', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue[900],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 100),
            const SizedBox(height: 20),
            // Title [cite: 189]
            const Text(
              'Ideia Registrada!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            // Message [cite: 190]
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.0),
              child: Text(
                'Parabéns, sua ideia foi registrada com sucesso!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 40),
            // Button [cite: 191]
            SizedBox(
              width: 200,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  // Navigate back to Home/Feed (Page 12) [cite: 191]
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                    (Route<dynamic> route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[900],
                  foregroundColor: Colors.white,
                ),
                child: const Text('Voltar para o feed', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}