import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'edit_card_screen.dart';

class CardDetailScreen extends StatelessWidget {
  // final String question;
  // final String answer;
  // final Function(String, String) onSave;
  // final Function onDelete; // Callback function to handle deletion
  final String deckId;
  final String cardId;

  CardDetailScreen({
    required this.deckId,
    required this.cardId,
    // required this.question,
    // required this.answer,
    // required this.onSave,
    // required this.onDelete,
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
                  builder: (context) => EditCardScreen(deckId: deckId, cardId: cardId),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async {
              await FirebaseFirestore.instance
                  .collection('decks')
                  .doc(deckId)
                  .collection('cards')
                  .doc(cardId)
                  .delete(); // Close dialog
              Navigator.pop(context); // Navigate back to previous screen
            },
          ),
        ],
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('decks')
            .doc(deckId)
            .collection('cards')
            .doc(cardId)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(child: Text('Card not found'));
          } else {
            final card = snapshot.data!.data() as Map<String, dynamic>;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Question: ${card['question']}', style: TextStyle(fontSize: 20)),
                  SizedBox(height: 20),
                  Text('Answer: ${card['answer']}', style: TextStyle(fontSize: 20)),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      await FirebaseFirestore.instance
                          .collection('decks')
                          .doc(deckId)
                          .collection('cards')
                          .doc(cardId)
                          .delete();
                      Navigator.pop(context);
                    },
                    child: Text('Delete Card'),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
