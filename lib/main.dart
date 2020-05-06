import 'package:flutter/material.dart';

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Widget> scoreKeeper = [];
  List<String> questions = [
    'You can lead a cow down stairs but not up stairs.',
    'You can lead a cow down stairs but not up stairs.',
    'A slug\'s blood is green.'
  ];
  int questionNumber = 0;
  List<bool> answers = [false, true, true];
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                questions[questionNumber],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                //The user picked true.
                bool currentAnswer = answers[questionNumber];
                if (currentAnswer == true) {
                  // add true
                  addTrue();
                } else {
                  //  add false
                  addFalse();
                }
                toNextQuestion();
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                //The user picked false.\
                bool currentAnswer = answers[questionNumber];
                if (currentAnswer == false) {
                  // add true
                  addTrue();
                } else {
                  //  add false
                  addFalse();
                }
                toNextQuestion();
              },
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        )
      ],
    );
  }

  void toNextQuestion() {
    if (questionNumber < questions.length - 1) {
      setState(() {
        questionNumber++;
      });
    } else {
      setState(() {
        questionNumber = 0;
      });
    }
  }

  void addTrue() {
    scoreKeeper.add(Icon(
      Icons.check,
      color: Colors.green,
    ));
  }

  void addFalse() {
    scoreKeeper.add(Icon(
      Icons.close,
      color: Colors.red,
    ));
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/