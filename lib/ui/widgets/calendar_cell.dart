import 'package:flutter/material.dart';
import '../../data/models/event_model.dart';

class CalendarCell extends StatelessWidget {
  final DateTime day;
  final List<EventModel> events;
  final bool isSelected;

  const CalendarCell({
    super.key,
    required this.day,
    required this.events,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue.withOpacity(0.3) : Colors.transparent,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        children: [
          Text(
            '${day.day}',
            style: TextStyle(
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? Colors.blue : Colors.black,
            ),
          ),
          if (events.isNotEmpty)
            ...events.take(1).map((event) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 1),
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade700,
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: Text(
                    event.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                )),
        ],
      ),
    );
  }
}