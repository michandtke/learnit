import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:learnit/models/deck_model.dart';
import 'package:learnit/models/card_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Deck methods
  Stream<List<DeckModel>> getDecks() {
    return _db.collection('decks').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => DeckModel.fromDocument(doc)).toList());
  }

  Future<void> addDeck(DeckModel deck) {
    return _db.collection('decks').add(deck.toJson());
  }

  Future<void> deleteDeck(String deckId) {
    return _db.collection('decks').doc(deckId).delete();
  }

  // Card methods
  Stream<List<CardModel>> getCards(String deckId) {
    return _db
        .collection('decks')
        .doc(deckId)
        .collection('cards')
        .snapshots()
        .map((snapshot) =>
        snapshot.docs.map((doc) => CardModel.fromDocument(doc)).toList());
  }

  Future<void> addCard(String deckId, CardModel card) {
    return _db
        .collection('decks')
        .doc(deckId)
        .collection('cards')
        .add(card.toJson());
  }

  Future<void> deleteCard(String deckId, String cardId) {
    return _db
        .collection('decks')
        .doc(deckId)
        .collection('cards')
        .doc(cardId)
        .delete();
  }
}
