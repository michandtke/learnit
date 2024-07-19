import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:learnit/providers/deck_provider.dart';
import 'package:learnit/providers/card_provider.dart';
import 'package:learnit/screens/home/home_screen.dart';
import 'package:learnit/screens/deck/add_deck_screen.dart';
import 'package:learnit/screens/card/add_card_screen.dart';
import 'package:learnit/screens/study/study_screen.dart';
import 'package:learnit/screens/study/finished_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DeckProvider()),
        ChangeNotifierProvider(create: (_) => CardProvider()),
      ],
      child: MaterialApp(
        title: 'LearnIt',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeScreen(),
        routes: {
          // AddDeckScreen.routeName: (context) => AddDeckScreen(),
          // AddCardScreen.routeName: (context) => AddCardScreen(),
          // StudyScreen.routeName: (context) => StudyScreen(),
          // FinishedScreen.routeName: (context) => FinishedScreen(),
        },
      ),
    );
  }
}
