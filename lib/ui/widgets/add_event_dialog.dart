import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/models/event_model.dart';
import '../event_provider.dart';
import 'package:intl/intl.dart'; // Tambahkan package intl di pubspec untuk format tanggal

class AddEventDialog extends StatefulWidget {
  final DateTime selectedDay;

  const AddEventDialog({super.key, required this.selectedDay});

  @override
  State<AddEventDialog> createState() => _AddEventDialogState();
}

class _AddEventDialogState extends State<AddEventDialog> {
  final titleController = TextEditingController();
  final descController = TextEditingController();
  
  DateTime selectedDate = DateTime.now();
  TimeOfDay? selectedTime;
  DateTime? deadlineDate;
  bool isAllDay = true;
  RepeatType repeatType = RepeatType.none;
  String selectedCategory = "Personal";

  @override
  void initState() {
    super.initState();
    selectedDate = widget.selectedDay; // Default ke tanggal yang diklik
  }

  // Helper untuk memilih tanggal
  Future<DateTime?> _pickDate(BuildContext context, DateTime initialDate) async {
    return showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
  }

  // Helper untuk memilih waktu
  Future<TimeOfDay?> _pickTime(BuildContext context) async {
    return showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: AlertDialog(
        title: const TabBar(
          tabs: [
            Tab(icon: Icon(Icons.event), text: "Event"),
            Tab(icon: Icon(Icons.task_alt), text: "Task"),
          ],
        ),
        content: StatefulBuilder( // PENTING: Agar setState bekerja di dialog
          builder: (context, setStateDialog) {
            return SizedBox(
              width: double.maxFinite,
              height: 450,
              child: TabBarView(
                children: [
                  _buildForm(setStateDialog, isEvent: true),
                  _buildForm(setStateDialog, isEvent: false),
                ],
              ),
            );
          }
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Batal"),
          ),
          ElevatedButton(
            onPressed: () {
              if (titleController.text.isNotEmpty) {
                final tabController = DefaultTabController.of(context);
                final type = tabController.index == 0 ? EventType.event : EventType.task;

                Provider.of<EventProvider>(context, listen: false).addEvent(
                  EventModel(
                    title: titleController.text,
                    date: selectedDate,
                    startTime: isAllDay ? null : selectedTime,
                    isAllDay: isAllDay,
                    category: selectedCategory,
                    type: type,
                    description: descController.text,
                    deadline: deadlineDate,
                    repeat: repeatType,
                  ),
                );
                Navigator.pop(context);
              }
            },
            child: const Text("Tambah"),
          ),
        ],
      ),
    );
  }

  Widget _buildForm(StateSetter setStateDialog, {required bool isEvent}) {
    return SingleChildScrollView(
      child: Column(
        children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(labelText: isEvent ? "Judul Event" : "Judul Task"),
          ),
          const SizedBox(height: 10),
          
          // --- DATE PICKER ---
          ListTile(
            title: Text("Tanggal: ${DateFormat('dd MMM yyyy').format(selectedDate)}"),
            trailing: const Icon(Icons.calendar_today),
            onTap: () async {
              final picked = await _pickDate(context, selectedDate);
              if (picked != null) setStateDialog(() => selectedDate = picked);
            },
          ),

          // --- ALL DAY & TIME PICKER ---
          if (isEvent) ...[
            SwitchListTile(
              title: const Text("All Day"),
              value: isAllDay,
              onChanged: (val) => setStateDialog(() => isAllDay = val),
            ),
            if (!isAllDay)
              ListTile(
                title: Text("Mulai jam: ${selectedTime?.format(context) ?? 'Pilih'}"),
                trailing: const Icon(Icons.access_time),
                onTap: () async {
                  final picked = await _pickTime(context);
                  if (picked != null) setStateDialog(() => selectedTime = picked);
                },
              ),
          ],

          // --- REPEAT OPTION ---
          DropdownButtonFormField<RepeatType>(
            value: repeatType,
            decoration: const InputDecoration(labelText: "Pengulangan"),
            items: RepeatType.values.map((type) {
              return DropdownMenuItem(
                value: type,
                child: Text(type.toString().split('.').last),
              );
            }).toList(),
            onChanged: (val) => setStateDialog(() => repeatType = val!),
          ),

          // --- DEADLINE (Khusus Task) ---
          if (!isEvent)
            ListTile(
              title: Text(deadlineDate == null 
                ? "Set Deadline" 
                : "Deadline: ${DateFormat('dd MMM yyyy').format(deadlineDate!)}"),
              trailing: const Icon(Icons.timer_off),
              onTap: () async {
                final picked = await _pickDate(context, deadlineDate ?? selectedDate);
                if (picked != null) setStateDialog(() => deadlineDate = picked);
              },
            ),
        ],
      ),
    );
  }
}