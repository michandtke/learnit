import 'package:flutter/material.dart';
import 'package:learnit/statistics_fetcher.dart';

class StatisticsDetailPage extends StatelessWidget {
  final String userId;

  StatisticsDetailPage({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detailed Statistics'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: fetchStatisticsDetailed(userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data available'));
          } else {
            final data = snapshot.data!;
            final details = data['details'] as Map<String, Map<String, dynamic>>;
            return ListView.builder(
              itemCount: details.length,
              itemBuilder: (context, index) {
                final word = details.keys.elementAt(index);
                final dailyStats = details[word]!;
                return ExpansionTile(
                  title: Text(word, style: TextStyle(fontWeight: FontWeight.bold)),
                  children: dailyStats.entries.map((entry) {
                    final date = entry.key;
                    final stats = entry.value;
                    return ListTile(
                      title: Text(date),
                      subtitle: Text('Correct: ${stats['correct']}, Incorrect: ${stats['incorrect']}'),
                    );
                  }).toList(),
                );
              },
            );
          }
        },
      ),
    );
  }
}
