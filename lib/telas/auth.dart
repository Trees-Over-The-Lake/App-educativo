import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:educativo/telas/registrar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class Auth extends StatefulWidget {
  @override
  _AuthState createState() => _AuthState();
}

/// Tela de autenticação de login
class _AuthState extends State<Auth> {
  final _formKey = GlobalKey<FormState>();
  var _formValues = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Acesso à conta'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              Text('Acesse sua conta:'),
              Text(''),
              TextFormField(
                key: ValueKey('email'),
                keyboardType: TextInputType.emailAddress,
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
                height: 30,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (!_formKey.currentState.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Há erro em algum dos campos!')));

                      return;
                    }
                    _formKey.currentState.save();

                    // Login no Firebase
                    loginFirebase();
                  },
                  child: Text('Acessar'),
                  style: ElevatedButton.styleFrom(
                      textStyle: TextStyle(fontSize: 20))),
              TextButton(
                onPressed: () =>
                    Navigator.of(context).pushNamed(Registrar.routeName),
                child: Text('Registrar'),
                style: TextButton.styleFrom(textStyle: TextStyle(fontSize: 20)),
              ),
            ],
          ),
        ),
      )),
    );
  }

  void loginFirebase() async {
    try {
      UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _formValues['email'], password: _formValues['password']);
      print(user.toString());
    } catch (e) {
      print('Firebase error -> $e');
    }
  }

  /// Regex simples de validação de email
  bool _isValidEmail(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }
}
