import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_state.dart';

class AddDeckScreen extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Deck'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Deck Name'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Provider.of<AppState>(context, listen: false)
                    .addDeck(_nameController.text);
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
