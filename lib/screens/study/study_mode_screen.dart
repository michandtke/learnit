import 'package:flutter/material.dart';
import 'package:learnit/screens/study/finished_screen.dart';
import 'package:provider/provider.dart';
import 'package:learnit/providers/study_mode_service.dart';
import 'package:learnit/screens/study/study_mode_content.dart';

class StudyModeScreen extends StatelessWidget {
  final String deckId;

  StudyModeScreen({required this.deckId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => StudyModeService()..loadCards(deckId),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Study Mode'),
        ),
        body: Consumer<StudyModeService>(
          builder: (context, studyModeService, child) {
            if (studyModeService.cards.isEmpty) {
              return Center(child: CircularProgressIndicator());
            }

            return StudyModeContent(
                question: studyModeService.currentCard.question,
                answer: studyModeService.currentCard.answer,
                onNext: () {
                  if (!studyModeService.nextCard()) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FinishedScreen(),
                      ),
                    );
                  }
                });
          },
        ),
      ),
    );
  }
}
