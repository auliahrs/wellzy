import 'package:flutter/material.dart';
import 'package:wellzy/Views/reminder/new_reminder.dart';
import 'package:wellzy/models/reminder.dart';

class ListReminder extends StatefulWidget {
  const ListReminder({super.key});

  @override
  State<ListReminder> createState() => _ListReminderState();
}

class _ListReminderState extends State<ListReminder> {
  final List<Reminder> _registerReminders = [
    Reminder(
      name: 'Penaldo',
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
      builder: (context) => NewReminder(),
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
              padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 15),
              child: SizedBox(
                width: 150,
                child: ElevatedButton(
                  onPressed: () {
                    _openAddReminderOverlay;
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    backgroundColor: const Color(0xFF72B376),
                  ),
                  child: const Text(
                    'Create',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF294B29),
                      fontFamily: 'Baloo',
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
