import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GenderScreen extends StatefulWidget {
  @override
  _GenderScreenState createState() => _GenderScreenState();
}

class _GenderScreenState extends State<GenderScreen> {
  final TextEditingController _controller = TextEditingController();
  String _gender = '';

  Future<void> _predictGender(String name) async {
    final response =
        await http.get(Uri.parse('https://api.genderize.io/?name=$name'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        _gender = data['gender'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Predicción de Género'),
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
              onPressed: () => _predictGender(_controller.text),
              child: Text('Predecir Género'),
            ),
            if (_gender.isNotEmpty)
              Container(
                color: _gender == 'male' ? Colors.blue : Colors.pink,
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Género: $_gender',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
