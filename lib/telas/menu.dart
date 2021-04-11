import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:educativo/aprender/matematica.dart';
import 'package:educativo/aprender/portugues.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  /// Pegar dados de usuário do Firebase
  Future<DocumentSnapshot> getFirebaseData() async {
    return await FirebaseFirestore.instance
        .collection('usuarios')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EducAPP'),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: FutureBuilder(
          future: getFirebaseData(),
          builder: (context, snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : buildListView(snapshot),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
            child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  children: [
                    Center(
                        child:
                            Image(image: AssetImage('images/matematica.jpeg'))),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () => Navigator.of(context)
                              .pushNamed(Matematica.routeName),
                          child: Text('Aprender matemática')),
                    ),
                    SizedBox(
                      height: 100,
                    ),
                    Center(
                        child:
                            Image(image: AssetImage('images/alfabeto.jpeg'))),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () => Navigator.of(context)
                              .pushNamed(Portugues.routeName),
                          child: Text('Aprender o alfabeto')),
                    ),
                  ],
                ))),
      ),
    );
  }

  ListView buildListView(AsyncSnapshot snapshot) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        UserAccountsDrawerHeader(
          accountName: Text(snapshot.data.data()['nome']),
          accountEmail: Text(snapshot.data.data()['email']),
          currentAccountPicture: CircleAvatar(
            child: Text(getInitials(snapshot.data.data()['nome'])),
          ),
        ),
        ListTile(
          leading: Icon(Icons.logout),
          title: Text('Sair'),
          onTap: () => firebaseLogout(),
        ),
      ],
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
