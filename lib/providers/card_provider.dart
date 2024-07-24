import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:learnit/models/card_model.dart';

class CardProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<CardModel> _cards = [];

  List<CardModel> get cards => _cards;

  Future<void> loadCards(String deckId) async {
    try {
      final snapshot = await _firestore.collection('decks/$deckId/cards').get();
      _cards = snapshot.docs.map((doc) => CardModel.fromSnapshot(doc)).toList();
      notifyListeners();
    } catch (e) {
      print('Error loading cards: $e');
    }
  }

  Future<void> addCard(String deckId, CardModel card) async {
    try {
      await _firestore.collection('decks/$deckId/cards').add(card.toMap());
      _cards.add(card);
      notifyListeners();
    } catch (e) {
      print('Error adding card: $e');
    }
  }

  Future<void> updateCard(String deckId, CardModel card) async {
    try {
      await _firestore
          .collection('decks/$deckId/cards')
          .doc(card.id)
          .update(card.toMap());
      final index = _cards.indexWhere((c) => c.id == card.id);
      if (index != -1) {
        _cards[index] = card;
        notifyListeners();
      }
    } catch (e) {
      print('Error updating card: $e');
    }
  }

  Future<void> deleteCard(String deckId, String cardId) async {
    try {
      await _firestore.collection('decks/$deckId/cards').doc(cardId).delete();
      _cards.removeWhere((c) => c.id == cardId);
      notifyListeners();
    } catch (e) {
      print('Error deleting card: $e');
    }
  }
}
