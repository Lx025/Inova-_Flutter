import 'package:eurofarma_project/screens/home_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Chave global para identificar e validar o formulário
  final _formKey = GlobalKey<FormState>();

  void _handleLogin(BuildContext context) {
    // Verifica se o estado atual do formulário é válido
    if (_formKey.currentState!.validate()) {
      // Se a validação passar, navega para a tela Home
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }
  }

  // Regex para validar e-mail: deve conter @ e terminar em .com OU .br
  final RegExp emailRegex = RegExp(r"^[^\s@]+@[^\s@]+\.(com|br)$");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Eurofarma INOVA +', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue[900],
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30.0),
          // O widget Form é essencial para que o validador funcione.
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Logo
                Image.asset(
                  'assets/eurofarma_logo.png',
                  height: 100, 
                ), 
                const SizedBox(height: 50),
                
                // Campo de E-mail Corporativo/Matrícula com Validação
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'E-mail Corporativo ou Matrícula',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o e-mail ou matrícula.';
                    }
                    
                    // Validação: Se contiver '@', deve seguir o padrão .com ou .br
                    if (value.contains('@')) {
                        if (!emailRegex.hasMatch(value)) {
                            return 'O e-mail deve ser corporativo (ex: user@empresa.com ou .br).';
                        }
                    }
                    // Caso não contenha '@' (assumindo que é uma matrícula), ou a validação de e-mail passe, retorna null.
                    
                    return null; 
                  },
                ),
                const SizedBox(height: 20),

                // Campo de Senha
                TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Senha',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira sua senha.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),

                // Botão de Login
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () => _handleLogin(context), // Chama o validador
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[900],
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text('Entrar', style: TextStyle(fontSize: 18)),
                  ),
                ),
                const SizedBox(height: 20),
                
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Problemas com o acesso',
                    style: TextStyle(color: Colors.blue[900]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}