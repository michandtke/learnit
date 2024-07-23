import 'package:flutter/material.dart';

class StudyModeService with ChangeNotifier {
  bool _showAnswer = false;
  String? _feedback;

  bool get showAnswer => _showAnswer;
  String? get feedback => _feedback;

  void submitAnswer(String userAnswer, String correctAnswer) {
    if (userAnswer.trim().toLowerCase() == correctAnswer.trim().toLowerCase()) {
      _feedback = 'Correct!';
    } else {
      _feedback = 'Wrong, try again!';
    }
    _showAnswer = true;
    notifyListeners();
  }

  void resetState() {
    _showAnswer = false;
    _feedback = null;
    notifyListeners();
  }
}
