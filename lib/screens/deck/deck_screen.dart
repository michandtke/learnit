import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:learnit/providers/card_provider.dart';
import 'package:learnit/screens/study/study_mode_screen.dart';
import 'package:learnit/screens/card/edit_card_screen.dart';
import 'package:learnit/widgets/card_item.dart';

class DeckScreen extends StatelessWidget {
  final String deckId;
  final String deckTitle;

  DeckScreen({required this.deckId, required this.deckTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(deckTitle),
        actions: [
          IconButton(
            icon: Icon(Icons.school),
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
      body: Consumer<CardProvider>(
        builder: (context, cardProvider, child) {
          cardProvider.loadCards(deckId);
          return ListView.builder(
            itemCount: cardProvider.cards.length,
            itemBuilder: (context, index) {
              final card = cardProvider.cards[index];
              return CardItem(
                card: card,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          EditCardScreen(deckId: deckId, card: card),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          // Add new card logic
        },
      ),
    );
  }
}
