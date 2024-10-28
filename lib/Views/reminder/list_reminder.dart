import 'package:flutter/material.dart';
import 'package:wellzy/Views/reminder/new_reminder.dart';

class ListReminder extends StatefulWidget {
  const ListReminder({super.key});

  @override
  State<ListReminder> createState() => _ListReminderState();
}

class _ListReminderState extends State<ListReminder> {
  _openAddReminderOverlay() {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      builder: (context) => NewReminder(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
            onPressed: _openAddReminderOverlay, child: Text('Create'))
      ],
    );
  }
}
