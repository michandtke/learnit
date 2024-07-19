import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:learnit/providers/card_provider.dart';
import 'package:learnit/models/deck_model.dart';
import 'package:learnit/models/card_model.dart';
import 'package:learnit/screens/card/add_card_screen.dart';
import 'package:learnit/screens/study/study_screen.dart';
import 'package:learnit/widgets/loading_indicator.dart';

class DeckScreen extends StatelessWidget {
  final String deckId;

  DeckScreen({required this.deckId});

  @override
  Widget build(BuildContext context) {
    final cardProvider = Provider.of<CardProvider>(context);
    cardProvider.loadCards(deckId);

    return Scaffold(
      appBar: AppBar(
        title: Text('Deck Details'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddCardScreen(deckId: deckId)),
              );
            },
          ),
        ],
      ),
      body: Consumer<CardProvider>(
        builder: (context, cardProvider, child) {
          if (cardProvider.cards.isEmpty) {
            return Center(child: Text('No cards available.'));
          }
          return ListView.builder(
            itemCount: cardProvider.cards.length,
            itemBuilder: (context, index) {
              final card = cardProvider.cards[index];
              return ListTile(
                title: Text(card.question),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => StudyScreen(deckId: deckId)),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
