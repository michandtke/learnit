import 'package:flutter/material.dart';

class Constants {
  static const primaryColor = Color(0xFF6200EE);
  static const secondaryColor = Color(0xFF03DAC6);
  static const backgroundColor = Color(0xFFF6F6F6);
  static const textColor = Color(0xFF000000);

  static const double padding = 16.0;
  static const double margin = 16.0;
  static const double cardElevation = 4.0;

  static const String appTitle = "LearnIt";

  static const TextStyle cardTitleStyle = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle cardContentStyle = TextStyle(
    fontSize: 16.0,
  );

  static const TextStyle buttonTextStyle = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );

  static const BoxDecoration cardDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
    boxShadow: [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 8.0,
        offset: Offset(0, 4),
      ),
    ],
  );
}
