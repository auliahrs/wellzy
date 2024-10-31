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
  List<Reminder> reminders = [];

  @override
  void initState() {
    super.initState();
    reminders = List.from(widget.reminders); // Initialize a local list
  }

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
      reminders.add(reminder);
    });
  }

  void _removeReminder(Reminder reminder) {
    final reminderIndex = reminders.indexOf(reminder);
    setState(() {
      reminders.remove(reminder);
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
                reminders.insert(reminderIndex, reminder);
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
        reminders.isEmpty
            ? Expanded(
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Center(
                          child: Text(
                            'No reminder found, start adding some',
                            style: TextStyle(
                              color: Color(0xFF294B29),
                              fontFamily: 'Baloo',
                              fontSize: 20,
                              
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Expanded(
                child: ListReminder(
                  reminders: reminders,
                  onRemoveReminder: _removeReminder,
                ),
              ),
      ],
    );
  }
}
