import 'package:flutter/material.dart';

import '../../widgets/primary_button.dart';

class FinishedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Study Completed'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Congratulations! You have completed the study session.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24.0),
            ),
            SizedBox(height: 20),
            Text(
              'Statistics will be shown here.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 20),
            PrimaryButton(
              action: () {
                Navigator.pop(context);
              },
              text: 'Back to Home',
            ),
          ],
        ),
      ),
    );
  }
}
