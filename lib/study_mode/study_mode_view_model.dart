import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StudyModeViewModel extends ChangeNotifier {
  List<DocumentSnapshot> cards = [];
  int currentIndex = 0;
  bool showAnswer = false;
  bool isLoading = true;

  Future<void> loadCards(String deckId) async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('decks')
          .doc(deckId)
          .collection('cards')
          .orderBy('createdAt')
          .get();

      cards = snapshot.docs;
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      print('Error loading cards: $e');
    }
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

  Future<void> saveAnswer(String userId, String deckId, bool isCorrect) async {
    await FirebaseFirestore.instance.collection('userAnswers').add({
      'userId': userId,
      'deckId': deckId,
      'cardId': cards[currentIndex].id,
      'isCorrect': isCorrect,
      'timestamp': FieldValue.serverTimestamp(),
    });
    nextCard();
  }
}
