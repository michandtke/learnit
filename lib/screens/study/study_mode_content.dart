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
  TextEditingController _controller = TextEditingController();
  String? _feedback;

  @override
  void didUpdateWidget(StudyModeContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.question != widget.question) {
      setState(() {
        _showAnswer = false;
        _controller.clear();
        _feedback = null;
      });
    }
  }

  void _submitAnswer() {
    if (_controller.text.trim().toLowerCase() == widget.answer.trim().toLowerCase()) {
      setState(() {
        _feedback = 'Correct!';
        widget.onCorrect();
      });
    } else {
      setState(() {
        _feedback = 'Wrong. The correct answer is: ${widget.answer}';
        widget.onWrong();
      });
    }
    setState(() {
      _showAnswer = true;
    });
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
                  if (_showAnswer && _feedback != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Text(
                        _feedback!,
                        style: TextStyle(fontSize: 20, color: _feedback == 'Correct!' ? Colors.green : Colors.red),
                      ),
                    ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          if (!_showAnswer)
            Column(
              children: [
                TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    labelText: 'Your Answer',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _submitAnswer,
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
            ),
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