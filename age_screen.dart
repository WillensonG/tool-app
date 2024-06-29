import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AgeScreen extends StatefulWidget {
  @override
  _AgeScreenState createState() => _AgeScreenState();
}

class _AgeScreenState extends State<AgeScreen> {
  final TextEditingController _controller = TextEditingController();
  int _age = -1;

  Future<void> _predictAge(String name) async {
    final response =
        await http.get(Uri.parse('https://api.agify.io/?name=$name'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        _age = data['age'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Predicción de Edad'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Nombre',
              ),
            ),
            ElevatedButton(
              onPressed: () => _predictAge(_controller.text),
              child: Text('Predecir Edad'),
            ),
            if (_age != -1)
              Column(
                children: [
                  Text(
                    'Edad: $_age',
                    style: TextStyle(fontSize: 24),
                  ),
                  if (_age < 18)
                    Column(
                      children: [
                        Text('Joven', style: TextStyle(fontSize: 24)),
                        Image.asset('assets/young.png'),
                      ],
                    )
                  else if (_age < 60)
                    Column(
                      children: [
                        Text('Adulto', style: TextStyle(fontSize: 24)),
                        Image.asset('assets/adult.png'),
                      ],
                    )
                  else
                    Column(
                      children: [
                        Text('Anciano', style: TextStyle(fontSize: 24)),
                        Image.asset('assets/elder.png'),
                      ],
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
