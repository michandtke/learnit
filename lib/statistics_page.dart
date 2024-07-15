import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'statistics_detail_page.dart';
import 'statistics_fetcher.dart';

class StatisticsPage extends StatefulWidget {
  final String userId;

  StatisticsPage({required this.userId});

  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  late Future<Map<String, dynamic>> statisticsFuture;

  @override
  void initState() {
    super.initState();
    statisticsFuture = fetchStatistics(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Statistics'),
        actions: [
          IconButton(
            icon: Icon(Icons.bar_chart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StatisticsDetailPage(userId: widget.userId),
                ),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: statisticsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data available'));
          } else {
            final data = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Guesses: ${data['totalGuesses']}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Correct Guesses: ${data['correctGuesses']}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Accuracy: ${data['accuracy'].toStringAsFixed(2)}%',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: PieChart(
                      PieChartData(
                        sections: [
                          PieChartSectionData(
                            value: data['correctGuesses'].toDouble(),
                            color: Colors.green,
                            title: '${data['correctGuesses']}',
                          ),
                          PieChartSectionData(
                            value:
                                (data['totalGuesses'] - data['correctGuesses'])
                                    .toDouble(),
                            color: Colors.red,
                            title:
                                '${data['totalGuesses'] - data['correctGuesses']}',
                          ),
                        ],
                        sectionsSpace: 2,
                        centerSpaceRadius: 40,
                        borderData: FlBorderData(show: false),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to more detailed statistics or other actions
                    },
                    child: Text('More Details'),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
