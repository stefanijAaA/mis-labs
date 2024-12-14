import 'package:flutter/material.dart';
import 'package:lab2/screens/home.dart';
import 'screens/random_joke_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Joke App',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: Colors.grey[200],
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.deepPurple[900]),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => JokeTypesScreen(),
        '/randomJoke': (context) => RandomJokeScreen(),
      },
    );
  }
}
