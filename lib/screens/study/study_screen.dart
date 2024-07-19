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

class _StudyScreenState extends State<StudyScreen> {
  int _currentIndex = 0;

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
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              cards[_currentIndex].question,
              style: TextStyle(fontSize: 24.0),
            ),
            SizedBox(height: 20),
            CustomButton(
              text: 'Show Answer',
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    content: Text(cards[_currentIndex].answer),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('Close'),
                      ),
                    ],
                  ),
                );
              },
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _currentIndex > 0
                    ? CustomButton(
                  text: 'Previous',
                  onPressed: () {
                    setState(() {
                      _currentIndex--;
                    });
                  },
                )
                    : Container(),
                _currentIndex < cards.length - 1
                    ? CustomButton(
                  text: 'Next',
                  onPressed: () {
                    setState(() {
                      _currentIndex++;
                    });
                  },
                )
                    : CustomButton(
                  text: 'Finish',
                  onPressed: () {
                    Navigator.push(
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
