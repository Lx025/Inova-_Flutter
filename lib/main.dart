import 'package:eurofarma_project/screens/login_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const InovaApp());
}

class InovaApp extends StatelessWidget {
  const InovaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inova+ (Eurofarma)',
      debugShowCheckedModeBanner: false, // Remove a faixa de 'DEBUG'
      theme: ThemeData(
        // Tema visual baseado na identidade corporativa (RNF01)
        primaryColor: const Color(0xFF0D47A1), // Azul Primário Eurofarma
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          color: Color(0xFF0D47A1),
          iconTheme: IconThemeData(color: Colors.white), // Ícones do AppBar brancos
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity, 
      ),
      // A primeira tela a ser carregada é a tela de login
      home: const LoginScreen(), 
    );
  }
}