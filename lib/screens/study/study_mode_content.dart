import 'package:flutter/material.dart';

class StudyModeContent extends StatefulWidget {
  final String question;
  final String answer;
  final VoidCallback onNext;
  final VoidCallback onPrevious;
  final VoidCallback onCorrect;
  final VoidCallback onWrong;

  StudyModeContent({
    required this.question,
    required this.answer,
    required this.onNext,
    required this.onPrevious,
    required this.onCorrect,
    required this.onWrong,
  });

  @override
  _StudyModeContentState createState() => _StudyModeContentState();
}

class _StudyModeContentState extends State<StudyModeContent> {
  bool _showAnswer = false;

  @override
  void didUpdateWidget(StudyModeContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.question != widget.question) {
      setState(() {
        _showAnswer = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            elevation: 4.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text(
                    widget.question,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  if (_showAnswer)
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Text(
                        widget.answer,
                        style: TextStyle(fontSize: 20, color: Colors.green),
                      ),
                    ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          if (!_showAnswer)
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _showAnswer = true;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: EdgeInsets.symmetric(vertical: 16.0),
              ),
              child: Text(
                'Show Answer',
                style: TextStyle(fontSize: 16),
              ),
            ),
          if (_showAnswer) ...[
            ElevatedButton(
              onPressed: widget.onCorrect,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: EdgeInsets.symmetric(vertical: 16.0),
              ),
              child: Text(
                'Correct',
                style: TextStyle(fontSize: 16),
              ),
            ),
            ElevatedButton(
              onPressed: widget.onWrong,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: EdgeInsets.symmetric(vertical: 16.0),
              ),
              child: Text(
                'Wrong',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: widget.onPrevious,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
                ),
                child: Text('Previous'),
              ),
              ElevatedButton(
                onPressed: widget.onNext,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
                ),
                child: Text('Next'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
