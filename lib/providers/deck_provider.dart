import 'package:flutter/material.dart';
import 'package:learnit/models/deck_model.dart';
import 'package:learnit/services/firestore_service.dart';

class DeckProvider with ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();
  List<DeckModel> _decks = [];

  List<DeckModel> get decks => _decks;

  void loadDecks() {
    _firestoreService.getDecks().listen((decks) {
      _decks = decks;
      notifyListeners();
    });
  }

  Future<void> addDeck(String name) async {
    final newDeck = DeckModel(
      id: DateTime.now().toString(),
      name: name,
    );
    await _firestoreService.addDeck(newDeck);
  }

  Future<void> deleteDeck(String deckId) async {
    await _firestoreService.deleteDeck(deckId);
  }
}
