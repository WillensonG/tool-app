import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Acerca de'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('images/willen.jpg'),
            ),
            SizedBox(height: 16),
            Text(
              'willenson R guillen',
              style: TextStyle(fontSize: 24),
            ),
            Text('20212406@itla.edu.do'),
            Text('809-777-3462'),
          ],
        ),
      ),
    );
  }
}
