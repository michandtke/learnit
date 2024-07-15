import 'package:cloud_firestore/cloud_firestore.dart';

Future<List<Map<String, dynamic>>> fetchDecks(String userId) async {
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('decks')
      .where('userId', isEqualTo: userId)
      .get();

  return snapshot.docs.map((doc) => {
    'deckId': doc.id,
    'name': doc['name'],
  }).toList();
}

Future<void> addDeck(String userId, String name) async {
  await FirebaseFirestore.instance.collection('decks').add({
    'userId': userId,
    'name': name,
    'createdAt': FieldValue.serverTimestamp(),
  });
}
