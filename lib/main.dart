import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gerador de Senhas',
      home: PasswordGeneratorScreen(),
    );
  }
}

class PasswordGeneratorScreen extends StatefulWidget {
  @override
  _PasswordGeneratorScreenState createState() =>
      _PasswordGeneratorScreenState();
}

class _PasswordGeneratorScreenState extends State<PasswordGeneratorScreen> {
  TextEditingController _passwordController = TextEditingController();
  String _passwordStrength = "";

  void _generatePassword() {
    const String chars =
        "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#\$%^&*()-_=+";
    const int passwordLength = 15;
    Random random = Random();

    setState(() {
      _passwordController.text = List.generate(
              passwordLength, (index) => chars[random.nextInt(chars.length)])
          .join();
      _passwordStrength = _checkPasswordStrength(_passwordController.text);
    });
  }

  String _checkPasswordStrength(String password) {
    if (password.contains(RegExp(r'[A-Z]')) &&
        password.contains(RegExp(r'[a-z]')) &&
        password.contains(RegExp(r'[0-9]')) &&
        password.contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>]'))) {
      return "Forte";
    } else if (password.contains(RegExp(r'[A-Z]')) ||
        password.contains(RegExp(r'[a-z]')) ||
        password.contains(RegExp(r'[0-9]'))) {
      return "Média";
    } else {
      return "Fraca";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gerador de Senhas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _passwordController,
              onChanged: (text) {
                setState(() {
                  _passwordStrength = _checkPasswordStrength(text);
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Senha Gerada ou Insira Manualmente',
              ),
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 10),
            Text(
              'Força da senha: $_passwordStrength',
              style: TextStyle(
                fontSize: 20,
                color: _passwordStrength == 'Forte'
                    ? Colors.green
                    : _passwordStrength == 'Média'
                        ? Colors.orange
                        : Colors.red,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _generatePassword,
              child: Text('Gerar Senha'),
            ),
          ],
        ),
      ),
    );
  }
}
