import 'package:flutter/material.dart';

class Auth extends StatefulWidget {
  @override
  _AuthState createState() => _AuthState();
}

/// Tela de autenticação de login
class _AuthState extends State<Auth> {
  final _formKey = GlobalKey<FormState>();
  bool estaLogando = false;

  @override
  Widget build(BuildContext context) {
    var _formValues = {};

    return Scaffold(
      body: SingleChildScrollView(
          child: Form(
        key: _formKey,
        child: Column(
          children: [
            Text('Acesse sua conta:'),
            Text(''),
            TextFormField(
              key: ValueKey('username'),
              textCapitalization: TextCapitalization.words,
              enableSuggestions: false,
              initialValue: _formValues['username'],
              decoration: InputDecoration(labelText: 'Nome de usuário'),
              validator: (value) {
                if (value.isEmpty || value.length < 4)
                  return 'O usuário precisa pelo menos 4 caracteres!';
                return null;
              },
              onSaved: (value) {
                _formValues['email'] = value;
              },
            ),
            TextFormField(
              key: ValueKey('email'),
              textCapitalization: TextCapitalization.words,
              enableSuggestions: false,
              initialValue: _formValues['email'],
              decoration: InputDecoration(labelText: 'Email'),
              validator: (value) {
                if (_isValidEmail(value)) return 'O email precisa ser válido!';
                return null;
              },
              onSaved: (value) {
                _formValues['email'] = value;
              },
            ),
            TextFormField(
              key: ValueKey('password'),
              initialValue: _formValues['password'],
              decoration: InputDecoration(labelText: 'Senha'),
              obscureText: true,
              validator: (value) {
                if (value.isEmpty || value.length < 8)
                  return 'A senha deve ter no mínimo 8 caracteres';
                return null;
              },
              onSaved: (value) {
                _formValues['password'] = value;
              },
            ),
            ElevatedButton(onPressed: () => {}, child: Text('Acessar')),
            ElevatedButton(onPressed: () => {}, child: Text('Registrar')),
          ],
        ),
      )),
    );
  }

  /// Regex simples de validação de email
  bool _isValidEmail(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }
}
