import 'package:flutter/material.dart';
import 'inicio.dart';

void main() {
  runApp(const QuizHarryPotterApp());
}

class QuizHarryPotterApp extends StatelessWidget {
  const QuizHarryPotterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz Harry Potter',
      debugShowCheckedModeBanner: false,
      home: const InicioPage(),
    );
  }
}
