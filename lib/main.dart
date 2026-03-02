import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_flutter/ui/event_provider.dart';
import './ui/pages/dashboard_page.dart'; // Pastikan path import ini benar sesuai struktur folder
import './ui/pages/calendar_page.dart'; // Halaman baru
import './ui/pages/settings_page.dart';   // Halaman baru

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => EventProvider(),
      child: const ChronosApp(),
    )
  );
}

class ChronosApp extends StatelessWidget {
  const ChronosApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chronos AI Planner',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const MainNavigation(), // Gunakan widget navigasi
      debugShowCheckedModeBanner: false,
    );
  }
}

// Widget untuk Bottom Navigation
class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  // List halaman
  final List<Widget> _pages = [
    const DashboardPage(),
    const CalendarPage(),
    const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label: 'Kalender'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}