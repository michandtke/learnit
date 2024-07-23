import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/study_mode_service.dart';

class StudyModeContent extends StatelessWidget {
  final String question;
  final String answer;
  final VoidCallback onNext;
  final VoidCallback onPrevious;

  final TextEditingController _controller = TextEditingController();

  StudyModeContent({
    required this.question,
    required this.answer,
    required this.onNext,
    required this.onPrevious,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<StudyModeService>(
      builder: (context, studyModeService, child) {
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
                        question,
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      if (studyModeService.showAnswer &&
                          studyModeService.feedback != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Text(
                            studyModeService.feedback!,
                            style: TextStyle(
                              fontSize: 20,
                              color: studyModeService.feedback == 'Correct!'
                                  ? Colors.green
                                  : Colors.red,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              if (!studyModeService.showAnswer)
                Column(
                  children: [
                    TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        labelText: 'Your Answer',
                        border: OutlineInputBorder(),
                      ),
                      onSubmitted: (userAnswer) {
                        studyModeService.submitAnswer(userAnswer, answer);
                      },
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        studyModeService.submitAnswer(
                          _controller.text,
                          answer,
                        );
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
                ),
              if (studyModeService.showAnswer)
                ElevatedButton(
                  onPressed: () {
                    if (studyModeService.feedback == 'Correct!') {
                      studyModeService.resetState(false);
                      _controller.clear();
                      onNext();
                    } else {
                      studyModeService.resetState(true);
                      _controller.clear();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: studyModeService.feedback == 'Correct!'
                        ? Colors.green
                        : Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                  ),
                  child: Text(
                    studyModeService.feedback == 'Correct!'
                        ? 'Next Card'
                        : 'Try Again',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: onPrevious,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 24.0),
                    ),
                    child: Text('Previous'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
