import 'package:flutter/material.dart';
import 'package:quizzler/question.dart';
import 'package:quizzler/quizzler_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizzlerBrain quizzlerBrain = QuizzlerBrain();

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
                quizzlerBrain.getQuestionText(),
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
                checkAnswer(context, true);
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
                checkAnswer(context, false);
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

  void checkAnswer(BuildContext context, bool pickedAnswer) {
    setState(() {
      bool currentAnswer = quizzlerBrain.getQuestionAnswer();
      if (currentAnswer == pickedAnswer) {
        // add true
        addTrue();
      } else {
        //  add false
        addFalse();
      }
      if (quizzlerBrain.isEnd()) {
        Alert(
          context: context,
          type: AlertType.warning,
          title: "END",
          desc: "you have answer all the question.",
          buttons: [
            DialogButton(
              child: Text(
                "to privious",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () {
                Navigator.pop(context);
                initData();
              },
              color: Color.fromRGBO(0, 179, 134, 1.0),
            ),
          ],
        ).show();
      } else {
        quizzlerBrain.nextQuestion();
      }
    });
  }

  void initData() {
    setState(() {
      scoreKeeper = [];
      quizzlerBrain.initData();
    });
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
