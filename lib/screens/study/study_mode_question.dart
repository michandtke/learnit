import 'package:flutter/material.dart';

class StudyModeQuestion extends StatelessWidget {
  final String question;

  const StudyModeQuestion({super.key, required this.question});

  @override
  Widget build(BuildContext context) {
    return Text(
      question,
      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    );
  }
}
