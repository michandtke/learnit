import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_state.dart';
import 'deck_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Consumer<AppState>(
        builder: (context, appState, child) {
          if (appState.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (appState.decks.isEmpty) {
            return Center(child: Text('No decks available'));
          }

          return ListView.builder(
            itemCount: appState.decks.length,
            itemBuilder: (context, index) {
              final deck = appState.decks[index];
              final deckName = deck['name']; // Assuming the deck has a name field
              final deckId = deck.id;

              return ListTile(
                title: Text(deckName),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DeckScreen(deckId: deckId, deckName: deckName),
                    ),
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
