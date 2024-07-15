import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_state.dart';

class AddCardScreen extends StatelessWidget {
  final String deckId;
  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _answerController = TextEditingController();

  AddCardScreen({required this.deckId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Card'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Provider.of<AppState>(context, listen: false).addCard(
                  deckId,
                  _questionController.text,
                  _answerController.text,
                );
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
