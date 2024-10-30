import 'package:flutter/material.dart';
import 'package:wellzy/Views/reminder/reminders_item.dart';
import 'package:wellzy/models/reminder.dart';

class ListReminder extends StatelessWidget {
  const ListReminder(
      {super.key, required this.reminders, required this.onRemoveReminder});

  final List<Reminder> reminders;
  final void Function(Reminder reminder) onRemoveReminder;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: reminders.length,
      itemBuilder: (context, index) {
        return Dismissible(
          background: Container(
            color: Theme.of(context).colorScheme.error.withOpacity(0.5),
            margin: const EdgeInsets.symmetric(horizontal: 15),
          ),
          key: ValueKey(reminders[index]),
          onDismissed: (direction) {
            onRemoveReminder(reminders[index]);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: RemindersItem(reminder: reminders[index]),
          ),
        );
      },
    );
  }
}
