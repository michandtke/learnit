import 'package:cloud_firestore/cloud_firestore.dart';

class DeckModel {
  final String id;
  final String name;

  DeckModel({
    required this.id,
    required this.name,
  });

  factory DeckModel.fromJson(Map<String, dynamic> json) {
    return DeckModel(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory DeckModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return DeckModel.fromJson(data);
  }
}
