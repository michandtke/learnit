import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app_state.dart';
import '../loading_screen.dart';
import 'study_mode_content.dart';

class StudyModeScreen extends StatelessWidget {
  final String deckId;

  StudyModeScreen({required this.deckId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppState()..loadCards(deckId),
      child: Consumer<AppState>(
        builder: (context, appState, child) {
          if (appState.isLoading) {
            return LoadingScreen();
          }

          if (appState.cards.isEmpty) {
            return Scaffold(
              appBar: AppBar(
                title: Text('Study Mode'),
              ),
              body: Center(
                child: Text('No cards available'),
              ),
            );
          }

          return Scaffold(
            appBar: AppBar(
              title: Text('Study Mode'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: StudyModeContent(
                cards: appState.cards,
                userId: 'yourUserId', // replace with actual user ID
                deckId: deckId,
                currentIndex: appState.currentIndex,
                showAnswer: appState.showAnswer,
                onNextCard: appState.nextCard,
                onPreviousCard: appState.previousCard,
                onRevealAnswer: appState.revealAnswer,
                onSaveAnswer: (isCorrect) => appState.saveAnswer('yourUserId', isCorrect),
              ),
            ),
          );
        },
      ),
    );
  }
}
