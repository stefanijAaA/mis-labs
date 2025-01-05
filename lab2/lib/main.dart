import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lab2/screens/fav_jokes.dart';
import 'package:lab2/screens/home.dart';
import 'screens/random_joke_screen.dart';

final navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyChw9dlOxziD2H2TIlWFtNha2yDwm-4NNo",
            authDomain: "fir-setup-842f6.firebaseapp.com",
            projectId: "fir-setup-842f6",
            storageBucket: "fir-setup-842f6.firebasestorage.app",
            messagingSenderId: "137211149499",
            appId: "1:137211149499:web:82933267e259c87e18fd9e",
            measurementId: "G-DPKPWLZYHZ"));
  } else {
    await Firebase.initializeApp();
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
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
        '/favorites': (context) => FavoritesScreen(),
      },
    );
  }
}
