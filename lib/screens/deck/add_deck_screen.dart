import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:learnit/providers/deck_provider.dart';

class AddDeckScreen extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final deckProvider = Provider.of<DeckProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Deck'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Deck Name'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                deckProvider.addDeck(_nameController.text);
                Navigator.pop(context);
              },
              child: Text('Add Deck'),
            ),
          ],
        ),
      ),
    );
  }
}
