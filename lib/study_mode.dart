import 'package:flutter/material.dart';

class StudyModeScreen extends StatefulWidget {
  final List<Map<String, String>> cards;
  final int initialCardIndex;

  StudyModeScreen({
    required this.cards,
    required this.initialCardIndex,
  });

  @override
  _StudyModeScreenState createState() => _StudyModeScreenState();
}

class _StudyModeScreenState extends State<StudyModeScreen> {
  int currentIndex = 0;
  bool showAnswer = false;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialCardIndex;
  }

  void goToNextCard() {
    setState(() {
      if (currentIndex < widget.cards.length - 1) {
        currentIndex++;
        showAnswer = false; // Reset showAnswer when moving to the next card
      } else {
        // Handle end of list
        currentIndex = 0; // Optionally, wrap around to the first card
        showAnswer = false; // Reset showAnswer when moving to the next card
      }
    });
  }

  void goToPreviousCard() {
    setState(() {
      if (currentIndex > 0) {
        currentIndex--;
        showAnswer = false; // Reset showAnswer when moving to the next card
      } else {
        // Handle beginning of list
        currentIndex =
            widget.cards.length - 1; // Optionally, wrap around to the last card
        showAnswer = false; // Reset showAnswer when moving to the next card
      }
    });
  }

  void toggleAnswer() {
    setState(() {
      showAnswer = !showAnswer;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Study Mode'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              widget.cards[currentIndex]['question']!,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              showAnswer
                  ? widget.cards[currentIndex]['answer']!
                  : "",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: toggleAnswer,
            child: Text(showAnswer ? 'Show Question' : 'Show Answer'),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: goToPreviousCard,
                child: Text('Previous'),
              ),
              ElevatedButton(
                onPressed: goToNextCard,
                child: Text('Next'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
