import 'package:flutter/material.dart';
import 'package:wellzy/Views/reminder/list_reminder.dart';
import 'package:wellzy/Views/reminder/new_reminder.dart';
import 'package:wellzy/models/reminder.dart';

class Reminders extends StatefulWidget {
  const Reminders({super.key, required this.reminders});

  final List<Reminder> reminders;

  @override
  State<Reminders> createState() => _RemindersState();
}

class _RemindersState extends State<Reminders> {
  final List<Reminder> _registerReminders = [
    Reminder(
      name: 'panadol',
      dosage: '2 biji',
      category: Category.pill,
      time: DateTime.now(),
      startDate: DateTime.now(),
      endDate: DateTime.now(),
    ),
    Reminder(
      name: 'Ubat Batuk',
      dosage: '10 ml',
      category: Category.drink,
      time: DateTime.now(),
      startDate: DateTime.now(),
      endDate: DateTime.now(),
    ),
  ];

  _openAddReminderOverlay() {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      builder: (context) => NewReminder(
        onAddReminder: _addReminder,
      ),
    );
  }

  void _addReminder(Reminder reminder) {
    setState(() {
      _registerReminders.add(reminder);
    });
  }

  void _removeReminder(Reminder reminder) {
    final reminderIndex = _registerReminders.indexOf(reminder);
    setState(() {
      _registerReminders.remove(reminder);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Reminder Deleted.'),
        action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              setState(() {
                _registerReminders.insert(reminderIndex, reminder);
              });
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
                child: ElevatedButton(
                  onPressed: _openAddReminderOverlay,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF72B376),
                  ),
                  child: const Text(
                    'Create',
                    style: TextStyle(
                      color: Color(0xFF294B29),
                      fontFamily: 'Baloo',
                    ),
                  ),
                ),
              ),
          ],
        ),
        _registerReminders.isEmpty
            ? const Row(
                children: [Text('No reminder found, start adding some')],
              )
            : Expanded(
                child: ListReminder(
                reminders: _registerReminders,
                onRemoveReminder: _removeReminder,
              )),
      ],
    );
  }
}
