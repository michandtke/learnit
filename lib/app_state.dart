import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AppState extends ChangeNotifier {
  List<DocumentSnapshot> decks = [];
  List<DocumentSnapshot> cards = [];
  int currentIndex = 0;
  bool showAnswer = false;
  bool isLoading = true;
  String currentDeckId = '';

  Future<void> loadDecks() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('decks')
          .orderBy('createdAt')
          .get();

      decks = snapshot.docs;
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      print('Error loading decks: $e');
    }
  }

  Future<void> loadCards(String deckId) async {
    try {
      isLoading = true;
      notifyListeners();
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('decks')
          .doc(deckId)
          .collection('cards')
          .orderBy('createdAt')
          .get();

      cards = snapshot.docs;
      currentDeckId = deckId;
      currentIndex = 0;
      showAnswer = false;
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      print('Error loading cards: $e');
    }
  }

  Future<void> addCard(String deckId, String question, String answer) async {
    await FirebaseFirestore.instance
        .collection('decks')
        .doc(deckId)
        .collection('cards')
        .add({
      'question': question,
      'answer': answer,
      'createdAt': FieldValue.serverTimestamp(),
    });
    await loadCards(deckId);
  }

  Future<void> deleteCard(String cardId) async {
    await FirebaseFirestore.instance
        .collection('decks')
        .doc(currentDeckId)
        .collection('cards')
        .doc(cardId)
        .delete();
    await loadCards(currentDeckId);
  }

  void nextCard() {
    if (currentIndex < cards.length - 1) {
      currentIndex++;
      showAnswer = false;
      notifyListeners();
    }
  }

  void previousCard() {
    if (currentIndex > 0) {
      currentIndex--;
      showAnswer = false;
      notifyListeners();
    }
  }

  void revealAnswer() {
    showAnswer = true;
    notifyListeners();
  }

  Future<void> saveAnswer(String userId, bool isCorrect) async {
    await FirebaseFirestore.instance.collection('userAnswers').add({
      'userId': userId,
      'deckId': currentDeckId,
      'cardId': cards[currentIndex].id,
      'isCorrect': isCorrect,
      'timestamp': FieldValue.serverTimestamp(),
    });
    nextCard();
  }

  Future<void> addDeck(String name) async {
    await FirebaseFirestore.instance.collection('decks').add({
      'name': name,
      'createdAt': FieldValue.serverTimestamp(),
    });
    await loadDecks();
  }
}
