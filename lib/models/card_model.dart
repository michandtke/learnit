import 'package:cloud_firestore/cloud_firestore.dart';

class CardModel {
  final String id;
  final String question;
  final String answer;
  final Timestamp createdAt;

  CardModel({
    required this.id,
    required this.question,
    required this.answer,
    required this.createdAt,
  });

  factory CardModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return CardModel(
      id: snapshot.id,
      question: data['question'] ?? '',
      answer: data['answer'] ?? '',
      createdAt: data['createdAt'] ?? Timestamp.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'question': question,
      'answer': answer,
      'createdAt': createdAt,
    };
  }
}
