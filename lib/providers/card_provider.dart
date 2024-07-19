import 'package:flutter/material.dart';
import 'package:learnit/models/card_model.dart';
import 'package:learnit/services/firestore_service.dart';

class CardProvider with ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();
  List<CardModel> _cards = [];

  List<CardModel> get cards => _cards;

  void loadCards(String deckId) {
    _firestoreService.getCards(deckId).listen((cards) {
      _cards = cards;
      notifyListeners();
    });
  }

  Future<void> addCard(String deckId, CardModel card) async {
    await _firestoreService.addCard(deckId, card);
    loadCards(deckId);
  }

  Future<void> deleteCard(String deckId, String cardId) async {
    await _firestoreService.deleteCard(deckId, cardId);
    loadCards(deckId);
  }
}
