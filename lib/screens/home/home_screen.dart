import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:learnit/providers/deck_provider.dart';
import 'package:learnit/screens/deck/deck_screen.dart';
import 'package:learnit/screens/deck/add_deck_screen.dart';
import 'package:learnit/widgets/custom_button.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final deckProvider = Provider.of<DeckProvider>(context);
    deckProvider.loadDecks();

    return Scaffold(
      appBar: AppBar(
        title: Text('Decks'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddDeckScreen()),
              );
            },
          ),
        ],
      ),
      body: Consumer<DeckProvider>(
        builder: (context, deckProvider, child) {
          if (deckProvider.decks.isEmpty) {
            return Center(child: Text('No decks available.'));
          }
          return ListView.builder(
            itemCount: deckProvider.decks.length,
            itemBuilder: (context, index) {
              final deck = deckProvider.decks[index];
              return ListTile(
                title: Text(deck.name),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DeckScreen(deckId: deck.id)),
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
