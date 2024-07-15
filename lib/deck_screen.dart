import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_state.dart';
import 'study_mode/study_mode_screen.dart';
import 'add_card_screen.dart';

class DeckScreen extends StatefulWidget {
  final String deckId;
  final String deckName;

  DeckScreen({required this.deckId, required this.deckName});

  @override
  _DeckScreenState createState() => _DeckScreenState();
}

class _DeckScreenState extends State<DeckScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Provider.of<AppState>(context, listen: false).loadCards(widget.deckId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.deckName), // Use the deck name as the title
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddCardScreen(deckId: widget.deckId),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.play_arrow),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StudyModeScreen(deckId: widget.deckId),
                ),
              );
            },
          ),
        ],
      ),
      body: Consumer<AppState>(
        builder: (context, appState, child) {
          if (appState.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (appState.cards.isEmpty) {
            return Center(child: Text('No cards available'));
          }

          return ListView.builder(
            itemCount: appState.cards.length,
            itemBuilder: (context, index) {
              final card = appState.cards[index];
              return ListTile(
                title: Text(card['question']),
                subtitle: Text(card['answer']),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    appState.deleteCard(card.id);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
