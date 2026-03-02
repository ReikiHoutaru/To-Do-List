import 'package:flutter/material.dart';
import '../../data/models/event_model.dart';
import 'dart:collection';
import 'package:table_calendar/table_calendar.dart';

class EventProvider extends ChangeNotifier {
  // Penyimpanan data utama
  List<EventModel> _allEvents = [];

  // Data yang diformat untuk TableCalendar
  LinkedHashMap<DateTime, List<EventModel>> _groupedEvents = LinkedHashMap(
    equals: isSameDay,
    hashCode: (DateTime key) => key.day * 1000000 + key.month * 10000 + key.year,
  );

  List<EventModel> get allEvents => _allEvents;
  LinkedHashMap<DateTime, List<EventModel>> get groupedEvents => _groupedEvents;

  // Fungsi untuk menambah event
  void addEvent(EventModel event) {
    _allEvents.add(event);
    _groupEvents();
    notifyListeners();
  }

  // Fungsi untuk mengelompokkan event berdasarkan tanggal (untuk kalender)
  void _groupEvents() {
    _groupedEvents.clear();
    for (var event in _allEvents) {
      DateTime date = DateTime(event.date.year, event.date.month, event.date.day);
      if (_groupedEvents[date] == null) {
        _groupedEvents[date] = [];
      }
      _groupedEvents[date]!.add(event);
    }
  }

  // Helper untuk mengambil event di tanggal tertentu
  List<EventModel> getEventsForDay(DateTime day) {
    return _groupedEvents[day] ?? [];
  }
}