import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:learnit/screens/study/study_mode_content.dart';

import 'finished_screen.dart';

class StudyModeScreen extends StatefulWidget {
  final String deckId;

  StudyModeScreen({required this.deckId});

  @override
  _StudyModeScreenState createState() => _StudyModeScreenState();
}

class _StudyModeScreenState extends State<StudyModeScreen> {
  List<DocumentSnapshot> _cards = [];
  int _currentIndex = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCards();
  }

  void _loadCards() async {
    var querySnapshot = await FirebaseFirestore.instance
        .collection('decks')
        .doc(widget.deckId)
        .collection('cards')
        .get();
    setState(() {
      _cards = querySnapshot.docs;
      _isLoading = false;
    });
  }

  void _nextCard() {
    if (_currentIndex < _cards.length - 1) {
      setState(() {
        _currentIndex++;
      });
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FinishedScreen(),
        ),
      );
    }
  }

  void _previousCard() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
      });
    }
  }

  void _markAsCorrect() {
    // Handle marking the card as correct (e.g., update statistics)
    // For now, we just move to the next card
  }

  void _markAsWrong() {
    // Handle marking the card as wrong (e.g., update statistics)
    // For now, we just move to the next card
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_cards.isEmpty) {
      return Scaffold(
        body: Center(child: Text('No cards available')),
      );
    }

    var card = _cards[_currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('Study Mode'),
      ),
      body: StudyModeContent(
        question: card['question'],
        answer: card['answer'],
        onNext: _nextCard,
        onPrevious: _previousCard,
        onCorrect: _markAsCorrect,
        onWrong: _markAsWrong,
      ),
    );
  }
}
