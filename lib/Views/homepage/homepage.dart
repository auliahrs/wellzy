import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wellzy/Views/AI/ai_interface.dart';
import 'package:wellzy/Views/homepage/homepage_content.dart';
import 'package:wellzy/Views/reminder/reminders.dart';
import 'package:wellzy/models/reminder.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  late List<Widget> bodyList;
  int _selectedIndex = 0;
  List<Reminder> registerReminders = [];

  @override
  void initState() {
    super.initState(); // Load data from Firebase when the widget initializes
    _fetchReminders();
  }

  Future<List<Reminder>> _fetchReminders() async {
    var auth = FirebaseAuth.instance;

    // Get the current user's email
    final email = auth.currentUser?.email;

    if (email == null) {
      print("User is not logged in.");
      return []; // Return an empty list if the user is not logged in
    }
    print("Logged in user's email: $email");

    // Fetch data from the Firestore collection
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('reminders')
        .where('email', isEqualTo: email)
        .get();

    // Create a list to hold the reminders
    List<Reminder> remindersList = [];

    // Iterate through the documents and convert them to Reminder objects
    for (QueryDocumentSnapshot doc in snapshot.docs) {
      Reminder reminder =
          Reminder.fromFirestore(doc.data() as Map<String, dynamic>, doc.id);
      remindersList.add(reminder);
    }

    return remindersList; // Return the list of reminders
  }

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
      body: FutureBuilder<List<Reminder>>(
        future: _fetchReminders(), // Call the async function here
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // While loading, show a loading indicator
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Handle any errors that occur during fetching
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            // Data is available, update the registerReminders list
            registerReminders = snapshot.data!;
            // Rebuild bodyList with the new reminders
            bodyList = [
              Homepagecontent(reminders: registerReminders),
              const AiInterface(),
              Reminders(reminders: registerReminders),
            ];
            return bodyList
                .elementAt(_selectedIndex); // Display the selected page
          }
        },
      ),
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
