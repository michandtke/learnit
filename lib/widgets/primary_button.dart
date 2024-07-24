import 'package:flutter/material.dart';

import '../utils/constants.dart';

class PrimaryButton extends StatelessWidget {
  final VoidCallback? action;
  final String text;

  const PrimaryButton({super.key, required this.action, required this.text});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: action,
      style: ElevatedButton.styleFrom(
        backgroundColor: Constants.primaryColor,
      ),
      child:
          Text(text, style: const TextStyle(color: Constants.backgroundColor)),
    );
  }
}
