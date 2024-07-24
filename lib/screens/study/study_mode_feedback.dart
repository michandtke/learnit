import 'package:flutter/material.dart';

class StudyModeFeedback extends StatelessWidget {

  final String feedback;
  final bool correct;

  const StudyModeFeedback({super.key, required this.feedback, required this.correct});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Text(
        feedback,
        style: TextStyle(
          fontSize: 20,
          color: correct
              ? Colors.green
              : Colors.red,
        ),
      ),
    );
  }
}