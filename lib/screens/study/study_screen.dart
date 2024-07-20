import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:learnit/providers/card_provider.dart';
import 'package:learnit/widgets/custom_button.dart';
import 'package:learnit/widgets/loading_indicator.dart';
import 'package:learnit/screens/study/finished_screen.dart';

class StudyScreen extends StatefulWidget {
  final String deckId;

  StudyScreen({required this.deckId});

  @override
  _StudyScreenState createState() => _StudyScreenState();
}

class _StudyScreenState extends State<StudyScreen> with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  bool _showAnswer = false;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _nextCard() {
    setState(() {
      _showAnswer = false;
      if (_currentIndex < Provider.of<CardProvider>(context, listen: false).cards.length - 1) {
        _currentIndex++;
        _controller.forward(from: 0.0);
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => FinishedScreen(),
          ),
        );
      }
    });
  }

  void _previousCard() {
    setState(() {
      _showAnswer = false;
      if (_currentIndex > 0) {
        _currentIndex--;
        _controller.forward(from: 0.0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final cardProvider = Provider.of<CardProvider>(context);
    final cards = cardProvider.cards;

    return Scaffold(
      appBar: AppBar(
        title: Text('Study Mode'),
      ),
      body: cards.isEmpty
          ? LoadingIndicator()
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: FadeTransition(
                opacity: _animation,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      cards[_currentIndex].question,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    if (_showAnswer)
                      Text(
                        cards[_currentIndex].answer,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20.0, color: Colors.green),
                      )
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            CustomButton(
              text: _showAnswer ? 'Next' : 'Show Answer',
              onPressed: _showAnswer ? _nextCard : () {
                setState(() {
                  _showAnswer = true;
                });
              },
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (_currentIndex > 0)
                  CustomButton(
                    text: 'Previous',
                    onPressed: _previousCard,
                  ),
                if (_currentIndex == cards.length - 1 && _showAnswer)
                  CustomButton(
                    text: 'Finish',
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FinishedScreen(),
                        ),
                      );
                    },
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
