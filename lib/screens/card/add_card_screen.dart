import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:learnit/providers/card_provider.dart';
import 'package:learnit/models/card_model.dart';

class AddCardScreen extends StatelessWidget {
  final String deckId;
  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _answerController = TextEditingController();

  AddCardScreen({required this.deckId});

  @override
  Widget build(BuildContext context) {
    final cardProvider = Provider.of<CardProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Card'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _questionController,
              decoration: InputDecoration(labelText: 'Question'),
            ),
            TextField(
              controller: _answerController,
              decoration: InputDecoration(labelText: 'Answer'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final newCard = CardModel(
                  id: DateTime.now().toString(),
                  question: _questionController.text,
                  answer: _answerController.text,
                );
                cardProvider.addCard(deckId, newCard);
                Navigator.pop(context);
              },
              child: Text('Add Card'),
            ),
          ],
        ),
      ),
    );
  }
}
