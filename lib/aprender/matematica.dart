import 'package:flutter/material.dart';

class Matematica extends StatefulWidget {
  static const routeName = 'Matematica';

  @override
  _MatematicaState createState() => _MatematicaState();
}

class _MatematicaState extends State<Matematica> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('Matematica'),),);
  }
}
