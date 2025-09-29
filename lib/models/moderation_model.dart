import 'dart:ui';

class ModerationItem {
  final String id; // <--- CAMPO CRÍTICO QUE CAUSA O ERRO SE ESTIVER FALTANDO
  final String title;
  String status;
  String action;
  Color actionColor;

  ModerationItem({
    required this.id,
    required this.title,
    required this.status,
    required this.action,
    required this.actionColor,
  });
}