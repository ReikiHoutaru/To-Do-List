import 'package:flutter/material.dart';

enum EventType { event, task }
enum RepeatType { none, daily, weekly, monthly }

class EventModel {
  final String title;
  final DateTime date;
  final TimeOfDay? startTime;
  final bool isAllDay;
  final String category;
  final EventType type;
  final String? description;
  final DateTime? deadline; // Khusus task
  final RepeatType repeat;
  final bool isCompleted;

  EventModel({
    required this.title,
    required this.date,
    this.startTime,
    this.isAllDay = false,
    required this.category,
    required this.type,
    this.description,
    this.deadline,
    this.repeat = RepeatType.none,
    this.isCompleted = false,
  });
}