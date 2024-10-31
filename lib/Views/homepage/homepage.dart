import 'package:flutter/material.dart';
import 'package:wellzy/Views/AI/ai_interface.dart';
import 'package:wellzy/Views/homepage/homepage_content.dart';
import 'package:wellzy/Views/reminder/reminders.dart';
import 'package:wellzy/models/reminder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../firebase_auth_implementation/firebase_auth_services.dart';
import '../auth/login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuthService _authService = FirebaseAuthService();
  late List<Widget> bodyList;

  @override
  void initState() {
    super.initState();
    bodyList = [
      Homepagecontent(
        reminders: _registerReminders,
      ),
      const AiInterface(),
      Reminders(
        reminders: _registerReminders,
      ),
    ];
  }

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

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Wellzy',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF294B29),
            fontFamily: 'Baloo',
          ),
        ),
        backgroundColor: const Color(0xFF72B376),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(
              FontAwesomeIcons.rightFromBracket,
              color: Color(0xFF294B29),
            ),
            onPressed: () async {
              await _authService.signOut();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
                    (route) => false,
              );
            },
          ),
        ],
      ),
      body: bodyList.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.lightbulb_outline_sharp),
            label: 'AI',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Reminder',
          ),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
