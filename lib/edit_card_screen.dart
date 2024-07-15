import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'card_fetcher.dart';

class EditCardScreen extends StatefulWidget {
  final String deckId;
  final String cardId;

  EditCardScreen({required this.deckId, required this.cardId});

  @override
  _EditCardScreenState createState() => _EditCardScreenState();
}

class _EditCardScreenState extends State<EditCardScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _questionController;
  late TextEditingController _answerController;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _questionController = TextEditingController();
    _answerController = TextEditingController();
    _loadCardDetails();
  }

  Future<void> _loadCardDetails() async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('decks')
        .doc(widget.deckId)
        .collection('cards')
        .doc(widget.cardId)
        .get();

    if (doc.exists) {
      setState(() {
        _questionController.text = doc['question'];
        _answerController.text = doc['answer'];
        _isLoading = false;
      });
    }
  }

  Future<void> _saveCard() async {
    if (_formKey.currentState!.validate()) {
      await updateCard(
        widget.deckId,
        widget.cardId,
        _questionController.text,
        _answerController.text,
      );
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _questionController.dispose();
    _answerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Card'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _questionController,
                decoration: InputDecoration(labelText: 'Question'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a question';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _answerController,
                decoration: InputDecoration(labelText: 'Answer'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an answer';
                  }
                  return null;
                },
              ),
              SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: _saveCard,
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
