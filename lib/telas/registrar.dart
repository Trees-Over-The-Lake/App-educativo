import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Registrar extends StatefulWidget {
  static const routeName = 'Registrar';

  @override
  _RegistrarState createState() => _RegistrarState();
}

/// Tela de autenticação de login
class _RegistrarState extends State<Registrar> {
  final _formKey = GlobalKey<FormState>();
  bool estaLogando = true;
  var _formValues = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registre-se'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              Text('Registre sua conta:'),
              Text(''),
              TextFormField(
                key: ValueKey('username'),
                textCapitalization: TextCapitalization.words,
                enableSuggestions: false,
                initialValue: _formValues['username'],
                decoration: InputDecoration(
                    labelText: 'Nome de usuário', border: OutlineInputBorder()),
                validator: (value) {
                  if (value.isEmpty || value.length < 4)
                    return 'O usuário precisa pelo menos 4 caracteres!';
                  return null;
                },
                onSaved: (value) {
                  _formValues['email'] = value;
                },
              ),
              SizedBox(
                height: 1,
              ),
              TextFormField(
                key: ValueKey('email'),
                textCapitalization: TextCapitalization.words,
                enableSuggestions: false,
                initialValue: _formValues['email'],
                decoration: InputDecoration(
                    labelText: 'Email', border: OutlineInputBorder()),
                validator: (value) {
                  if (!_isValidEmail(value))
                    return 'O email precisa ser válido!';
                  return null;
                },
                onSaved: (value) {
                  _formValues['email'] = value;
                },
              ),
              SizedBox(
                height: 1,
              ),
              TextFormField(
                key: ValueKey('password'),
                initialValue: _formValues['password'],
                decoration: InputDecoration(
                    labelText: 'Senha', border: OutlineInputBorder()),
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
              SizedBox(
                height: 1,
              ),
              TextFormField(
                key: ValueKey('confirmPassword'),
                initialValue: _formValues['confirmPassword'],
                decoration: InputDecoration(
                    labelText: 'Confirme a senha',
                    border: OutlineInputBorder()),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'O campo de confirmação de senha não pode ser vazio!';

                  return null;
                },
                onSaved: (value) {
                  _formValues['confirmPassword'] = value;
                },
              ),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (!_formKey.currentState.validate() ||
                        _formValues['password'] !=
                            _formValues['confirmPassword']) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Há erro em algum dos campos!')));

                      return;
                    }
                    _formKey.currentState.save();

                    // Registrando a conta
                    registrarNoFirebase();
                  },
                  child: Text('Registrar'),
                  style: ElevatedButton.styleFrom(
                      textStyle: TextStyle(fontSize: 20))),
            ],
          ),
        ),
      )),
    );
  }

  void registrarNoFirebase() async {}

  /// Regex simples de validação de email
  bool _isValidEmail(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }
}
