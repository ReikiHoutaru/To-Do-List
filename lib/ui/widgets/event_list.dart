import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../event_provider.dart';

class EventList extends StatelessWidget {
  final DateTime selectedDay;

  const EventList({super.key, required this.selectedDay});

  @override
  Widget build(BuildContext context) {
    // Akses provider di dalam widget ini
    final eventProvider = Provider.of<EventProvider>(context);
    final eventsForDay = eventProvider.getEventsForDay(selectedDay);

    return ListView.builder(
      itemCount: eventsForDay.length,
      itemBuilder: (context, index) {
        final event = eventsForDay[index];
        return ListTile(
          leading: const Icon(Icons.bookmark, color: Colors.blue),
          title: Text(event.title),
          subtitle: Text(event.category),
        );
      },
    );
  }
}