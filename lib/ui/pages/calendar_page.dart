import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../data/models/event_model.dart';
import '../event_provider.dart';
import '../widgets/calendar_cell.dart'; 
import '../widgets/event_list.dart'; 
import '../widgets/add_event_dialog.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
  }

  // --- Fungsi Menampilkan Dialog Tambah Event (Bisa dipindah ke widget terpisah juga) ---
  void _showAddEventDialog() {
    showDialog(
      context: context,
      builder: (context) => AddEventDialog(selectedDay: _selectedDay!),
    );
    
  }

  @override
  Widget build(BuildContext context) {
    final eventProvider = Provider.of<EventProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Kalender & Agenda")),
      body: Column(
        children: [
          TableCalendar<EventModel>(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            eventLoader: eventProvider.getEventsForDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, day, focusedDay) {
                final events = eventProvider.getEventsForDay(day);
                return CalendarCell(day: day, events: events, isSelected: false);
              },
              selectedBuilder: (context, day, focusedDay) {
                final events = eventProvider.getEventsForDay(day);
                return CalendarCell(day: day, events: events, isSelected: true);
              },
            ),
          ),
          const Divider(),
          // Panggil Widget Event List
          Expanded(
            child: EventList(selectedDay: _selectedDay!),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddEventDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}