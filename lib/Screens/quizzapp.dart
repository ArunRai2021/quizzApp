import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizz_app/Screens/quizz_screen.dart';
import 'package:quizz_app/const/colors.dart';
import 'package:quizz_app/const/text_style.dart';

import '../const/images.dart';

class QuizApp extends StatelessWidget {
  const QuizApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [blue, darkBlue],
            end: Alignment.bottomCenter,
          )),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: lightgrey, width: 2)),
                child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      CupertinoIcons.xmark,
                      color: Colors.white,
                      size: 20,
                    )),
              ),
              Image.asset(balloon2),
              const SizedBox(
                height: 20,
              ),
              normalText("welcome to our", lightgrey, 20),
              headingText("Quiz App", Colors.white, 32),
              const SizedBox(
                height: 20,
              ),
              normalText(
                  "Do you feel Confident? Here you will face some important questions",
                  lightgrey,
                  20),
              const Spacer(),
              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const QuizScreen()));
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    alignment: Alignment.center,
                    width: size.width - 100,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12)),
                    child: headingText("Continue", blue, 18),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
