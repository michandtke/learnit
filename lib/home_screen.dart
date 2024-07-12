import 'package:flutter/material.dart';

import 'add_deck_screen.dart';
import 'deck_screen.dart';
import 'study_mode.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> decks = ['Deck 1', 'Deck 2', 'Deck 3']; // Example list of decks

  void addDeck(String newDeckName) {
    setState(() {
      decks.add(newDeckName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Index Card Learning'),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              // Handle user profile action
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddDeckScreen(onSave: addDeck),
                  ),
                );
              },
              child: Text('Create New Deck'),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: decks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(decks[index]),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DeckScreen(deckName: decks[index]),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
