import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  /// Pegar dados de usuário do Firebase
  void getFirebaseData() async {
    var valores =
        await FirebaseFirestore.instance.collection('/usuarios').get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EducAPP'),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text('testName'),
              accountEmail: Text('testEmail'),
              currentAccountPicture: CircleAvatar(
                child: Text(getInitials('test Name')),
              ),
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Sair'),
              onTap: () => firebaseLogout(),
            ),
          ],
        ),
      ),
    );
  }

  /// Pegar as iniciais de um nome
  /// Fonte: https://stackoverflow.com/questions/61289182/how-to-get-first-character-from-words-in-flutter-dart
  String getInitials(String name) => name.isNotEmpty
      ? name.trim().split(' ').map((l) => l[0].toUpperCase()).take(2).join()
      : '';

  void firebaseLogout() async {
    await FirebaseAuth.instance.signOut();
  }
}
