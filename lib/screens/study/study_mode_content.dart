import 'package:flutter/material.dart';
import 'package:learnit/screens/study/study_mode_feedback.dart';
import 'package:learnit/screens/study/study_mode_input.dart';
import 'package:learnit/screens/study/study_mode_question.dart';
import 'package:provider/provider.dart';
import 'package:learnit/providers/study_mode_service.dart';

class StudyModeContent extends StatelessWidget {
  final String question;
  final String answer;
  final VoidCallback onNext;

  StudyModeContent({
    required this.question,
    required this.answer,
    required this.onNext,
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
                      StudyModeQuestion(question: question),
                      if (studyModeService.showAnswer &&
                          studyModeService.feedback != null)
                        StudyModeFeedback(
                            feedback: studyModeService.feedback!,
                            correct: studyModeService.feedback == 'Correct!'),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              if (!studyModeService.showAnswer)
                StudyModeInput(submit: studyModeService.submitAnswer),
              if (studyModeService.showAnswer)
                ElevatedButton(
                  onPressed: studyModeService.feedback == 'Correct!'
                      ? onNext
                      : studyModeService.resetState,
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
            ],
          ),
        );
      },
    );
  }
}
