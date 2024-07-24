import 'package:flutter/material.dart';

class StudyModeInput extends StatefulWidget {

  final void Function(String) submit;

  const StudyModeInput({super.key, required this.submit});

  @override
  State createState() => _StudyModeInputState();
}

class _StudyModeInputState extends State<StudyModeInput> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _controller,
          decoration: InputDecoration(
            labelText: 'Your Answer',
            border: OutlineInputBorder(),
          ),
          onSubmitted: (userAnswer) {
            widget.submit(userAnswer);
          },
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            widget.submit(_controller.text);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: EdgeInsets.symmetric(vertical: 16.0),
          ),
          child: Text(
            'Submit Answer',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}