import 'package:flutter/material.dart';

class Portugues extends StatefulWidget {
  static const routeName = 'Portugues';

  @override
  _PortuguesState createState() => _PortuguesState();
}

class _PortuguesState extends State<Portugues> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('Alfabeto'),),);
  }
}
