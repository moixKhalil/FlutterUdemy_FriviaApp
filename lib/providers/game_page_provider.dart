import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class GamePageProvider extends ChangeNotifier {
  final int _maxQuestions = 10;
  int _currentQuestionCount = 0;
  int _correctCount = 0;
  final String difficultyLevel;
  final Dio _dio = Dio();
  List? question;
  BuildContext context;
  GamePageProvider({required this.context,required this.difficultyLevel}) {
    _dio.options.baseUrl = "https://opentdb.com/api.php";
    _getQuestionsFromAPI();
  }
  Future<void> _getQuestionsFromAPI() async {
    var _response = await _dio.get('', queryParameters: {
      'amount': 10,
      'type': 'boolean',
      'difficulty': 'easy',
    });
    var _data = jsonDecode(
      _response.toString(),
    );
    question = _data["results"];
    notifyListeners();
  }

  String getCurrentQuestionText() {
    return question![_currentQuestionCount]['question'];
  }

  void answerQuestion(String _answer) async {
    bool isCorrect =
        question![_currentQuestionCount]['correct_answer'] == _answer;
    _correctCount += isCorrect ? 1 : 0;
    _currentQuestionCount++;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: isCorrect ? Colors.green : Colors.red,
            title: Icon(
              isCorrect ? Icons.check_circle : Icons.cancel_sharp,
              color: Colors.white,
            ),
          );
        });
    await Future.delayed(
      Duration(seconds: 1),
    );
    Navigator.pop(context);
    if (_currentQuestionCount == _maxQuestions) {
      endGame();
    } else {
      notifyListeners();
    }
  }

  Future<void> endGame() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.blue,
            title: Text(
              "End Game",
              style: TextStyle(fontSize: 25, color: Colors.white),
            ),
            content: Text("Score : $_correctCount / $_maxQuestions"),
          );
        });
    await Future.delayed(Duration(seconds: 3));
    Navigator.pop(context);
    Navigator.pop(context);
  }
}
