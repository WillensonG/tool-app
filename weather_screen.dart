import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  String _weather = '';

  Future<void> _fetchWeather() async {
    final response = await http.get(Uri.parse(
        'http://api.weatherapi.com/v1/current.json?key=YOUR_API_KEY&q=Dominican Republic'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        _weather = data['current']['condition']['text'];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clima en RD'),
      ),
      body: Center(
        child: _weather.isNotEmpty
            ? Text(
                'Clima: $_weather',
                style: TextStyle(fontSize: 24),
              )
            : CircularProgressIndicator(),
      ),
    );
  }
}
