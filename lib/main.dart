import 'package:educativo/telas/auth.dart';
import 'package:educativo/telas/loading.dart';
import 'package:educativo/telas/menu.dart';
import 'package:educativo/telas/registrar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> _initialization = Firebase.initializeApp();

    return FutureBuilder(
      future: _initialization,
      builder: (context, aSyncSnap) => MaterialApp(
        title: 'EducAPP',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        home: aSyncSnap.connectionState != ConnectionState.done
            ? Loading()
            : StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshot) =>
                    snapshot.hasData ? Menu() : Auth()),
        routes: {
          Registrar.routeName: (ctx) => Registrar(),
        },
      ),
    );
  }
}
