import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Acessando os sistemas do EducAPP...',
              style: Theme.of(context).textTheme.headline2,
            ),
            const SizedBox(
              height: 21,
            ),
            const Center(
              child: CircularProgressIndicator(),
            ),
          ],
        ),
      ),
    );
  }
}