import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizz_app/api_services.dart';
import 'package:quizz_app/const/text_style.dart';

import '../const/colors.dart';
import '../const/images.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  @override
  void initState() {
    super.initState();
    quiz = getQuiz();
    startTimer();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  int seconds = 60;
  Timer? timer;
  late Future quiz;
  int points = 0;
  var currentQuestionIndex = 0;
  var isLoaded = false;
  var optionList = [];
  var optionColor = [
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
  ];

  startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (seconds > 0) {
          seconds--;
        } else {
          timer.cancel();
        }
      });
    });
  }

  resetColors() {
    optionColor = [
      Colors.white,
      Colors.white,
      Colors.white,
      Colors.white,
      Colors.white,
    ];
  }

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
                child: FutureBuilder(
                  future: quiz,
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasData) {
                      var data = snapshot.data["results"];
                      if (isLoaded == false) {
                        optionList =
                            data[currentQuestionIndex]["incorrect_answers"];
                        optionList
                            .add(data[currentQuestionIndex]["correct_answer"]);
                        optionList.shuffle();
                        isLoaded = true;
                      }
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    border:
                                        Border.all(color: lightgrey, width: 2)),
                                child: IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: const Icon(
                                      CupertinoIcons.xmark,
                                      color: Colors.white,
                                      size: 20,
                                    )),
                              ),
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  normalText("$seconds", Colors.white, 24),
                                  SizedBox(
                                    width: 80,
                                    height: 80,
                                    child: CircularProgressIndicator(
                                      value: seconds / 60,
                                      valueColor: const AlwaysStoppedAnimation(
                                          Colors.white),
                                    ),
                                  )
                                ],
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    border:
                                        Border.all(color: lightgrey, width: 2)),
                                child: TextButton.icon(
                                    onPressed: null,
                                    icon: const Icon(
                                      CupertinoIcons.heart_fill,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                    label:
                                        normalText("like", Colors.white, 14)),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Image.asset(
                            ideas,
                            width: 200,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Align(
                              alignment: Alignment.centerLeft,
                              child: normalText(
                                  "question ${currentQuestionIndex + 1} of ${data.length}",
                                  lightgrey,
                                  18)),
                          const SizedBox(
                            height: 20,
                          ),
                          normalText(data[currentQuestionIndex]["question"],
                              Colors.white, 20),
                          const SizedBox(
                            height: 20,
                          ),
                          Expanded(
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: optionList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  var answer = data[currentQuestionIndex]
                                      ["correct_answer"];
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (answer.toString() ==
                                            optionList[index].toString()) {
                                          optionColor[index] = Colors.green;
                                          points = points + 10;
                                        } else {
                                          optionColor[index] = Colors.red;
                                        }
                                        isLoaded = false;
                                        if (currentQuestionIndex <
                                            data.length - 1) {
                                          Future.delayed(
                                              const Duration(seconds: 1), () {
                                            isLoaded = false;
                                            currentQuestionIndex++;
                                            resetColors();
                                            timer!.cancel();
                                            seconds = 60;
                                            startTimer();
                                          });
                                        } else {
                                          timer!.cancel();
                                        }
                                      });
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(bottom: 20),
                                      alignment: Alignment.center,
                                      width: size.width - 100,
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                          color: optionColor[index],
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: headingText(
                                          optionList[index].toString(),
                                          blue,
                                          18),
                                    ),
                                  );
                                }),
                          )
                        ],
                      );
                    } else {
                      return const Center(
                          child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                      ));
                    }
                  },
                ))));
  }
}
