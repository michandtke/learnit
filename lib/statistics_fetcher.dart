import 'package:cloud_firestore/cloud_firestore.dart';

Future<Map<String, dynamic>> fetchStatistics(String userId) async {
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('guesses')
      .where('userId', isEqualTo: userId)
      .get();

  int totalGuesses = snapshot.docs.length;
  int correctGuesses = snapshot.docs.where((doc) => doc['isCorrect']).length;

  return {
    'totalGuesses': totalGuesses,
    'correctGuesses': correctGuesses,
    'accuracy': totalGuesses > 0 ? (correctGuesses / totalGuesses) * 100 : 0,
  };
}

Future<Map<String, dynamic>> fetchStatisticsDetailed(String userId) async {
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('guesses')
      .where('userId', isEqualTo: userId)
      .get();

  int totalGuesses = snapshot.docs.length;
  int correctGuesses = snapshot.docs.where((doc) => doc['isCorrect']).length;

  Map<String, Map<String, dynamic>> details = {};

  for (var doc in snapshot.docs) {
    String word = doc['question'];
    String date = (doc['timestamp'] as Timestamp).toDate().toIso8601String().split('T').first;
    bool isCorrect = doc['isCorrect'];

    if (!details.containsKey(word)) {
      details[word] = {};
    }
    if (!details[word]!.containsKey(date)) {
      details[word]![date] = {'correct': 0, 'incorrect': 0};
    }

    if (isCorrect) {
      details[word]![date]['correct'] += 1;
    } else {
      details[word]![date]['incorrect'] += 1;
    }
  }

  return {
    'totalGuesses': totalGuesses,
    'correctGuesses': correctGuesses,
    'accuracy': totalGuesses > 0 ? (correctGuesses / totalGuesses) * 100 : 0,
    'details': details,
  };
}
