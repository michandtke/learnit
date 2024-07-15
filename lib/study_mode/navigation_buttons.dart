import 'package:flutter/material.dart';

class NavigationButtons extends StatelessWidget {
  final VoidCallback onNextCard;
  final VoidCallback onPreviousCard;
  final VoidCallback onRevealAnswer;
  final bool showAnswer;
  final bool hasPrevious;
  final bool hasNext;

  NavigationButtons({
    required this.onNextCard,
    required this.onPreviousCard,
    required this.onRevealAnswer,
    required this.showAnswer,
    required this.hasPrevious,
    required this.hasNext,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
          onPressed: hasPrevious ? onPreviousCard : null,
          child: Text('Previous'),
        ),
        ElevatedButton(
          onPressed: showAnswer ? null : onRevealAnswer,
          child: Text('Reveal Answer'),
        ),
        ElevatedButton(
          onPressed: hasNext ? onNextCard : null,
          child: Text('Next'),
        ),
      ],
    );
  }
}
