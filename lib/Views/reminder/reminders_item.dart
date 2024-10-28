import 'package:flutter/material.dart';
import 'package:wellzy/models/reminder.dart';

class RemindersItem extends StatelessWidget {
  const RemindersItem({super.key, required this.reminder});

  final Reminder reminder;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          children: [
            Row(
              children: [
                Icon(categoryIcons[reminder.category]),
                const SizedBox(
                  width: 15,
                ),
                Text(
                  reminder.name,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Color(0xFF294B29),
                    fontFamily: 'Baloo',
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const SizedBox(width: 38),
                Text(
                  reminder.dosage,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Color(0xFF294B29),
                    fontFamily: 'Baloo',
                  ),
                ),
                const SizedBox(width: 35),
                Text(
                  timeFormat.format(reminder.time),
                  style: const TextStyle(
                    fontSize: 18,
                    color: Color(0xFF294B29),
                    fontFamily: 'Baloo',
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
