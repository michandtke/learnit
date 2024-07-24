import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:learnit/models/deck_model.dart';

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
}
