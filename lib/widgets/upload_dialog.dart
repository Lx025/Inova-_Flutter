import 'package:flutter/material.dart';

class UploadDialog extends StatelessWidget {
  const UploadDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Diálogo para upload de arquivo (Imagem/Áudio - RF02)
    return AlertDialog(
      title: const Text('Anexar Mídia'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('Selecione o tipo de mídia para upload (RF02):'),
          const SizedBox(height: 20),
          // Opção 1: Upload de Imagem (S3 - RT05)
          ListTile(
            leading: Icon(Icons.image, color: Colors.blue[900]),
            title: const Text('Foto ou Imagem'),
            onTap: () {
              // Simula a seleção de Imagem
              Navigator.of(context).pop('Imagem (upload)');
            },
          ),
          // Opção 2: Upload de Áudio/Voz (S3 - RT05)
          ListTile(
            leading: Icon(Icons.mic, color: Colors.blue[900]),
            title: const Text('Áudio ou Gravação'),
            onTap: () {
              // Simula a seleção de Áudio
              Navigator.of(context).pop('Áudio (upload)');
            },
          ),
          // Opção 3: Documento/Texto
          ListTile(
            leading: Icon(Icons.attach_file, color: Colors.blue[900]),
            title: const Text('Outro Arquivo/Documento'),
            onTap: () {
              // Simula a seleção de Arquivo
              Navigator.of(context).pop('Documento (upload)');
            },
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancelar'),
        ),
      ],
    );
  }
}