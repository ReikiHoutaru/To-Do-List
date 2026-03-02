import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart'; 

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chronos Dashboard'),
        actions: [
          IconButton(icon: const Icon(Icons.person_outline), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Section 1: AI Prompt Box (Notion Style) ---
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Row(
                children: [
                  const Icon(Icons.auto_awesome, color: Colors.blue),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Perintah AI (ex: Buat event seminar Sabtu)',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send, color: Colors.blue),
                    onPressed: () {
                      // Trigger AI
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // --- Section 2: Ringkasan Waktu (Pie Chart) ---
            const Text(
              'Ringkasan Waktu Hari Ini',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Container(
              height: 200,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(
                      value: 50,
                      color: Colors.blue,
                      title: 'PBO',
                      radius: 50,
                      titleStyle: const TextStyle(fontSize: 12, color: Colors.white),
                    ),
                    PieChartSectionData(
                      value: 30,
                      color: Colors.orange,
                      title: 'Rapat',
                      radius: 50,
                      titleStyle: const TextStyle(fontSize: 12, color: Colors.white),
                    ),
                    PieChartSectionData(
                      value: 20,
                      color: Colors.green,
                      title: 'Lainnya',
                      radius: 50,
                      titleStyle: const TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ],
                  sectionsSpace: 2,
                  centerSpaceRadius: 40,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // --- Section 3: Agenda Hari Ini ---
            const Text(
              'Agenda Terdekat',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Card(
              elevation: 0,
              color: Colors.grey.shade100,
              child: const ListTile(
                leading: Icon(Icons.event_note, color: Colors.blue),
                title: Text("Presentasi PBO"),
                subtitle: Text("14:00 - 15:00"),
                trailing: Icon(Icons.chevron_right),
              ),
            ),
          ],
        ),
      ),
    );
  }
}