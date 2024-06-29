import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  List<dynamic> _posts = [];

  Future<void> _fetchNews() async {
    final response = await http
        .get(Uri.parse('https://your-wordpress-site.com/wp-json/wp/v2/posts'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        _posts = data;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Noticias de WordPress'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.network('https://your-wordpress-site.com/logo.png'),
            Expanded(
              child: ListView.builder(
                itemCount: _posts.length,
                itemBuilder: (context, index) {
                  final post = _posts[index];
                  return ListTile(
                    title: Text(post['title']['rendered']),
                    subtitle: Text(post['excerpt']['rendered']),
                    trailing: IconButton(
                      icon: Icon(Icons.link),
                      onPressed: () {
                        final url = post['link'];
                        launch(url);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
