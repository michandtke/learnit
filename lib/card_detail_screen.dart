import 'package:flutter/material.dart';

import 'edit_card_screen.dart';

class CardDetailScreen extends StatelessWidget {
  final String question;
  final String answer;
  final Function(String, String) onSave;
  final Function onDelete; // Callback function to handle deletion

  CardDetailScreen({
    required this.question,
    required this.answer,
    required this.onSave,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Card Detail'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditCardScreen(
                    question: question,
                    answer: answer,
                    onSave: onSave,
                  ),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              onDelete(); // Call delete callback
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Navigate back to previous screen
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              question,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              answer,
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
