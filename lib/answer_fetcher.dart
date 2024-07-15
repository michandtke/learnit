import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> saveUserAnswer(String userId, String deckId, String cardId, bool isCorrect) async {
  await FirebaseFirestore.instance.collection('userAnswers').add({
    'userId': userId,
    'deckId': deckId,
    'cardId': cardId,
    'isCorrect': isCorrect,
    'timestamp': FieldValue.serverTimestamp(),
  });
}
