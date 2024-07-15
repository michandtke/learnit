import 'package:cloud_firestore/cloud_firestore.dart';

Future<List<Map<String, dynamic>>> fetchCards(String deckId) async {
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('decks')
      .doc(deckId)
      .collection('cards')
      .get();

  return snapshot.docs.map((doc) => {
    'cardId': doc.id,
    'question': doc['question'],
    'answer': doc['answer'],
  }).toList();
}

Future<void> updateCard(String deckId, String cardId, String question, String answer) async {
  await FirebaseFirestore.instance
      .collection('decks')
      .doc(deckId)
      .collection('cards')
      .doc(cardId)
      .update({
    'question': question,
    'answer': answer,
  });
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
}
