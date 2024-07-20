import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../card/edit_card_screen.dart';
import '../study/study_mode_screen.dart';

class DeckScreen extends StatelessWidget {
  final String deckId;
  final String deckName;

  DeckScreen({required this.deckId, required this.deckName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(deckName),
        actions: [
          IconButton(
            icon: Icon(Icons.play_arrow),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StudyModeScreen(deckId: deckId),
                ),
              );
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('decks')
            .doc(deckId)
            .collection('cards')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          var cards = snapshot.data!.docs;
          return ListView.builder(
            itemCount: cards.length,
            itemBuilder: (context, index) {
              var card = cards[index];
              return ListTile(
                title: Text(card['question']),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditCardScreen(
                        deckId: deckId,
                        cardId: card.id,
                        question: card['question'],
                        answer: card['answer'],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add functionality to add a new card
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
