import 'package:flutter/material.dart';

class CardDisplay extends StatelessWidget {
  final String question;
  final String answer;
  final bool showAnswer;

  CardDisplay({
    required this.question,
    required this.answer,
    required this.showAnswer,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          question,
          style: TextStyle(fontSize: 24.0),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 20.0),
        if (showAnswer)
          Text(
            answer,
            style: TextStyle(fontSize: 20.0, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
      ],
    );
  }
}
