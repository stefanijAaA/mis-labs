import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RandomJokeScreen extends StatefulWidget {
  @override
  _RandomJokeScreenState createState() => _RandomJokeScreenState();
}

class _RandomJokeScreenState extends State<RandomJokeScreen> {
  dynamic joke;

  @override
  void initState() {
    super.initState();
    fetchRandomJoke();
  }

  Future<void> fetchRandomJoke() async {
    final response = await http
        .get(Uri.parse('https://official-joke-api.appspot.com/random_joke'));
    if (response.statusCode == 200) {
      setState(() {
        joke = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load random joke');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Joke of the Day'),
        backgroundColor: Colors.deepPurple,
      ),
      body: joke == null
          ? Center(child: CircularProgressIndicator())
          : Center(
              child: Card(
                color: Colors.deepPurple[50],
                margin: EdgeInsets.all(20),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(joke['setup'],
                          style:
                              TextStyle(fontSize: 18, color: Colors.black87)),
                      SizedBox(height: 10),
                      Text(joke['punchline'],
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple)),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
