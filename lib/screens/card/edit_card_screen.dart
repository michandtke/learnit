import 'package:flutter/material.dart';
import 'package:learnit/models/card_model.dart';
import 'package:learnit/providers/card_provider.dart';
import 'package:learnit/utils/constants.dart';
import 'package:learnit/widgets/primary_button.dart';
import 'package:provider/provider.dart';

class EditCardScreen extends StatefulWidget {
  final String deckId;
  final CardModel card;

  const EditCardScreen({Key? key, required this.deckId, required this.card})
      : super(key: key);

  @override
  _EditCardScreenState createState() => _EditCardScreenState();
}

class _EditCardScreenState extends State<EditCardScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _questionController;
  late TextEditingController _answerController;

  @override
  void initState() {
    super.initState();
    _questionController = TextEditingController(text: widget.card.question);
    _answerController = TextEditingController(text: widget.card.answer);
  }

  @override
  void dispose() {
    _questionController.dispose();
    _answerController.dispose();
    super.dispose();
  }

  void _saveCard() {
    if (_formKey.currentState!.validate()) {
      final updatedCard = CardModel(
        id: widget.card.id,
        question: _questionController.text,
        answer: _answerController.text,
        createdAt: widget.card.createdAt,
      );

      Provider.of<CardProvider>(context, listen: false)
          .updateCard(widget.deckId, updatedCard);

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Card'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
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
              PrimaryButton(action: _saveCard, text: 'Save Card'),
            ],
          ),
        ),
      ),
    );
  }
}
