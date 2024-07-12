import 'package:flutter/material.dart';
import 'package:learnit/study_mode.dart';

import 'add_card_screen.dart';
import 'card_detail_screen.dart';

class DeckScreen extends StatefulWidget {
  final String deckName;

  DeckScreen({required this.deckName});

  @override
  _DeckScreenState createState() => _DeckScreenState();
}

class _DeckScreenState extends State<DeckScreen> {
  List<Map<String, String>> cards = [
    {
      'question': 'What is Flutter?',
      'answer': 'A UI toolkit for building natively compiled applications.'
    },
    {
      'question': 'What is Dart?',
      'answer': 'A programming language optimized for building user interfaces.'
    },
  ];

  void updateCard(int index, String newQuestion, String newAnswer) {
    setState(() {
      cards[index] = {'question': newQuestion, 'answer': newAnswer};
    });
  }

  void addCard(String question, String answer) {
    setState(() {
      cards.add({'question': question, 'answer': answer});
    });
  }

  void deleteCard(int index) {
    setState(() {
      cards.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.deckName),
        actions: [
          IconButton(
            icon: Icon(Icons.play_arrow), // Example icon for study mode
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      StudyModeScreen(cards: cards, initialCardIndex: 0),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: cards.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(cards[index]['question']!),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CardDetailScreen(
                    question: cards[index]['question']!,
                    answer: cards[index]['answer']!,
                    onSave: (newQuestion, newAnswer) {
                      updateCard(index, newQuestion, newAnswer);
                    },
                    onDelete: () {
                      deleteCard(index);
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddCardScreen(onSave: addCard),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
