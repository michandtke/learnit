import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'card_display.dart';
import 'navigation_buttons.dart';
import 'answer_buttons.dart';

class StudyModeContent extends StatelessWidget {
  final List<DocumentSnapshot> cards;
  final String userId;
  final String deckId;
  final int currentIndex;
  final bool showAnswer;
  final VoidCallback onNextCard;
  final VoidCallback onPreviousCard;
  final VoidCallback onRevealAnswer;
  final Function(bool) onSaveAnswer;

  StudyModeContent({
    required this.cards,
    required this.userId,
    required this.deckId,
    required this.currentIndex,
    required this.showAnswer,
    required this.onNextCard,
    required this.onPreviousCard,
    required this.onRevealAnswer,
    required this.onSaveAnswer,
  });

  @override
  Widget build(BuildContext context) {
    final currentCard = cards[currentIndex].data() as Map<String, dynamic>;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CardDisplay(
          question: currentCard['question'],
          answer: currentCard['answer'],
          showAnswer: showAnswer,
        ),
        SizedBox(height: 20.0),
        NavigationButtons(
          onNextCard: onNextCard,
          onPreviousCard: onPreviousCard,
          onRevealAnswer: onRevealAnswer,
          showAnswer: showAnswer,
          hasPrevious: currentIndex > 0,
          hasNext: currentIndex < cards.length - 1,
        ),
        if (showAnswer)
          AnswerButtons(
            onSaveAnswer: onSaveAnswer,
          ),
      ],
    );
  }
}
