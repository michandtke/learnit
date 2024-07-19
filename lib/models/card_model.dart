import 'package:cloud_firestore/cloud_firestore.dart';

class CardModel {
  final String id;
  final String question;
  final String answer;

  CardModel({required this.id, required this.question, required this.answer});

  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
      id: json['id'] as String,
      question: json['question'] as String,
      answer: json['answer'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question': question,
      'answer': answer,
    };
  }

  factory CardModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return CardModel.fromJson(data);
  }
}
