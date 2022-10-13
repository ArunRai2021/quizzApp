import 'package:flutter/material.dart';
import 'package:quizz_app/Screens/quizzapp.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const QuizApp(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: "quick"),
      title: "Demo",
    );
  }
}
