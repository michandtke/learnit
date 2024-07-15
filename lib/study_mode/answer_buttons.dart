import 'package:flutter/material.dart';

class AnswerButtons extends StatelessWidget {
  final Function(bool) onSaveAnswer;

  AnswerButtons({
    required this.onSaveAnswer,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20.0),
        ElevatedButton(
          onPressed: () => onSaveAnswer(true),
          child: Text('Correct'),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
        ),
        SizedBox(height: 10.0),
        ElevatedButton(
          onPressed: () => onSaveAnswer(false),
          child: Text('Incorrect'),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
        ),
      ],
    );
  }
}
