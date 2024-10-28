import 'package:flutter/material.dart';
import 'package:wellzy/models/reminder.dart';

class NewReminder extends StatefulWidget {
  const NewReminder({super.key, required this.onAddReminder});

  final void Function(Reminder reminder) onAddReminder;

  @override
  State<NewReminder> createState() => _NewReminderState();
}

class _NewReminderState extends State<NewReminder> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}