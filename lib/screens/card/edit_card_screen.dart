import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditCardScreen extends StatelessWidget {
  final String deckId;
  final String cardId;
  final String question;
  final String answer;

  EditCardScreen({
    required this.deckId,
    required this.cardId,
    required this.question,
    required this.answer,
  });

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _answerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _questionController.text = question;
    _answerController.text = answer;

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Card'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _questionController,
                decoration: InputDecoration(labelText: 'Question'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a question';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _answerController,
                decoration: InputDecoration(labelText: 'Answer'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an answer';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    FirebaseFirestore.instance
                        .collection('decks')
                        .doc(deckId)
                        .collection('cards')
                        .doc(cardId)
                        .update({
                      'question': _questionController.text,
                      'answer': _answerController.text,
                    });
                    Navigator.pop(context);
                  }
                },
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
