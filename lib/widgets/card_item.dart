import 'package:flutter/material.dart';
import 'package:learnit/models/card_model.dart';

class CardItem extends StatelessWidget {
  final CardModel card;

  CardItem({required this.card});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(card.question),
      subtitle: Text(card.answer),
    );
  }
}
