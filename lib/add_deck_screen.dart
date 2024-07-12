import 'package:flutter/material.dart';

class AddDeckScreen extends StatefulWidget {
  final Function(String) onSave;

  AddDeckScreen({required this.onSave});

  @override
  _AddDeckScreenState createState() => _AddDeckScreenState();
}

class _AddDeckScreenState extends State<AddDeckScreen> {
  late TextEditingController _deckNameController;

  @override
  void initState() {
    super.initState();
    _deckNameController = TextEditingController();
  }

  @override
  void dispose() {
    _deckNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create New Deck'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _deckNameController,
              decoration: InputDecoration(
                labelText: 'Deck Name',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                widget.onSave(_deckNameController.text);
                Navigator.pop(context);
              },
              child: Text('Save Deck'),
            ),
          ],
        ),
      ),
    );
  }
}
