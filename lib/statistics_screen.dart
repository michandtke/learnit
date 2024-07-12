import 'package:flutter/material.dart';

class StatisticsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Statistics'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Progress',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            LinearProgressIndicator(value: 0.7),
            SizedBox(height: 20),
            Text(
              'Mastered Cards: 70%',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 40),
            Text(
              'Detailed Statistics',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            // Add graphs or charts here
          ],
        ),
      ),
    );
  }
}
