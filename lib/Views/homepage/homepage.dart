import 'package:flutter/material.dart';
import 'package:wellzy/Views/AI/ai_interface.dart';
import 'package:wellzy/Views/homepage/homepage_content.dart';
import 'package:wellzy/Views/reminder/reminders.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  
  
  @override
  State<HomePage> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage>{

  int _selectedIndex = 0;
  List<Widget> bodyList = [
    const Homepagecontent(),
    const AiInterface(),
    const Reminders(),
  ];
  
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
      ),

      body: bodyList.elementAt(_selectedIndex),

      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
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
