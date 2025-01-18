import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lab4/add_exam_screen.dart';
import 'package:lab4/calendar_widget.dart';
import 'package:lab4/exam_list.dart';
import 'package:lab4/map_page.dart';
import 'package:lab4/notification_service.dart';
import 'package:lab4/signin.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';



vFuture<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}


  

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AuthService>(
      create: (context) => AuthService(),
      child: MaterialApp(
        title: 'Exam Schedule App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: AuthWrapper(),
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return StreamBuilder<User?>(
      stream: authService.user,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          User? user = snapshot.data;

          if (user == null) {
            return AuthHomePage();
          } else {
            return HomeScreen();
          }
        }

        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exam Schedule App'),
        actions: [
          IconButton(
            icon: Icon(Icons.map),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MapScreen(), // Navigate to MapPage
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddExamScreen(),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await Provider.of<AuthService>(context, listen: false).signOut();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          CalendarWidget(),
          Expanded(
            child: ExamList(),
          ),
        ],
      ),
    );
  }
}