import 'package:flutter/material.dart';
import 'package:wellzy/Views/reminder/reminders_item.dart';
import 'package:wellzy/models/reminder.dart';

class Homepagecontent extends StatelessWidget {
  const Homepagecontent({super.key, required this.reminders});

  final List<Reminder> reminders;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 35),
          child: Card(
            elevation: 15,
            color: const Color.fromARGB(255, 105, 219, 191),
            borderOnForeground: true,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              child: Row(
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'About Medicines',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17.0,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          child: Text(
                            'Why is it important to monitor what and when you take',
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 17.0,
                              color: Colors.black,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Image.asset(
                    'assets/images/homepage_image.png',
                    width: 120,
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 30),
        const Text(
          "Today's Medicine",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25.0,
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: ListView.builder(
            itemCount: reminders.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: RemindersItem(reminder: reminders[index]),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
