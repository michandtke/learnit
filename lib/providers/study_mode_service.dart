import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:learnit/models/card_model.dart';

class StudyModeService with ChangeNotifier {
  List<CardModel> _cards = [];
  int _currentCardIndex = 0;
  bool _showAnswer = false;
  String? _feedback;

  List<CardModel> get cards => _cards;
  bool get showAnswer => _showAnswer;
  String? get feedback => _feedback;
  CardModel get currentCard => _cards[_currentCardIndex];

  void loadCards(String deckId) async {
    final snapshot = await FirebaseFirestore.instance.collection('decks/$deckId/cards').get();
    _cards = snapshot.docs.map((doc) => CardModel.fromSnapshot(doc)).toList();
    _currentCardIndex = 0;
    notifyListeners();
  }

  void submitAnswer(String userAnswer) {
    if (userAnswer.trim().toLowerCase() == currentCard.answer.trim().toLowerCase()) {
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

  bool nextCard() {
    if (_currentCardIndex < _cards.length - 1) {
      _currentCardIndex++;
      resetState();
      return true;
    }
    return false;
  }
}
