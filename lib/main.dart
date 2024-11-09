import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gamescore/HomePage.dart';
import 'package:gamescore/LoginScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Game Scoring App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
      routes: {
        '/login': (context) => const LoginScreen(),
      },
    );
  }
}
