import 'package:flutter/material.dart';

class StudyModeService extends ChangeNotifier {
  bool _showAnswer = false;
  bool _answered = false;
  String? _feedback;

  bool get showAnswer => _showAnswer;
  bool get answered => _answered;
  String? get feedback => _feedback;

  void submitAnswer(String userAnswer, String correctAnswer) {
    if (userAnswer.trim().toLowerCase() == correctAnswer.trim().toLowerCase()) {
      _feedback = 'Correct!';
      _answered = true;
    } else {
      _feedback = 'Wrong. Try again.';
      _showAnswer = true;
    }
    notifyListeners();
  }

  void resetState() {
    _showAnswer = false;
    _answered = false;
    _feedback = null;
    notifyListeners();
  }
}
