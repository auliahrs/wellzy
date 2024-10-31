import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wellzy/models/reminder.dart';

class NewReminder extends StatefulWidget {
  const NewReminder({super.key, required this.onAddReminder});

  final void Function(Reminder reminder) onAddReminder;

  @override
  State<NewReminder> createState() => _NewReminderState();
}

class _NewReminderState extends State<NewReminder> {
  final _nameController = TextEditingController();
  final _dosageController = TextEditingController();
  final _notesController = TextEditingController();
  DateTime? _selectedTime;
  DateTime? _selectedStartDate;
  DateTime? _selectedEndDate;
  Category _selectedCategory = Category.pill;

  void _timePicker() async {
    final now = DateTime.now();

    final pickTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    final pickedDateTime = DateTime(
      now.year,
      now.month,
      now.day,
      pickTime!.hour,
      pickTime.minute,
    );

    setState(() {
      _selectedTime = pickedDateTime;
    });
  }

  void _dateStartPicker() async {
    final now = DateTime.now();
    final lastDate = DateTime(now.year + 1, now.month, now.day);

    final pickDate = await showDatePicker(
      context: context,
      firstDate: now,
      lastDate: lastDate,
      initialDate: now,
    );

    setState(() {
      _selectedStartDate = pickDate;
    });
  }

  void _dateEndPicker() async {
    final now = DateTime.now();
    final lastDate = DateTime(now.year + 1, now.month, now.day);

    final pickDate = await showDatePicker(
      context: context,
      firstDate: now,
      lastDate: lastDate,
      initialDate: now,
    );

    setState(() {
      _selectedEndDate = pickDate;
    });
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Invalid input'),
        content: const Text('Please make sure a valid information.'),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Okay'))
        ],
      ),
    );
  }

  Future<void> _submitExpenseData() async {
    var auth = FirebaseAuth.instance;

    if (_nameController.text.trim().isEmpty ||
        _dosageController.text.trim().isEmpty ||
        _selectedTime == null ||
        _selectedStartDate == null ||
        _selectedEndDate == null) {
      _showDialog();
      return;
    }

    // Get the current user's email
    final email = auth.currentUser?.email;
    print(email);

    if (email == null) {
      print("User is not logged in.");
      return;
    }

    // Create a new user with a first and last name
    final reminder = <String, dynamic>{
      "email": email,
      "name": _nameController.text,
      "dosage": _dosageController.text,
      "category": _selectedCategory.name,
      "time": _selectedTime!,
      "startDate": _selectedStartDate!,
      "endDate": _selectedEndDate!,
    };

    // Add a new document with a generated ID and retrieve the document reference
    DocumentReference docRef = await FirebaseFirestore.instance
        .collection('reminders')
        .add(reminder);

    widget.onAddReminder(
      Reminder(
        name: _nameController.text,
        dosage: _dosageController.text,
        category: _selectedCategory,
        time: _selectedTime!,
        startDate: _selectedStartDate!,
        endDate: _selectedEndDate!,
        id: docRef.id,
      ),
    );

    Navigator.pop(context);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _dosageController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),
          child: Column(
            children: [
              TextField(
                controller: _nameController,
                maxLength: 50,
                decoration: const InputDecoration(
                  label: Text(
                    'Name',
                    style: TextStyle(fontFamily: 'Baloo'),
                  ),
                  hintText: "Medicine's name",
                  hintStyle: TextStyle(
                      fontFamily: 'Baloo', color: Color.fromARGB(100, 0, 0, 0)),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                controller: _dosageController,
                maxLength: 20,
                decoration: const InputDecoration(
                  label: Text(
                    'Dosage',
                    style: TextStyle(fontFamily: 'Baloo'),
                  ),
                  hintText: "Ex: 10 ml, 3 pills",
                  hintStyle: TextStyle(
                      fontFamily: 'Baloo', color: Color.fromARGB(100, 0, 0, 0)),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  DropdownButton(
                    value:
                        _selectedCategory, //this value is for the dropdown button, not the item. need to be set to be visible
                    items: Category.values
                        .map(
                          (category) => DropdownMenuItem(
                            value:
                                category, //this is value for each item, and it will be use in onChange
                            child: Text(
                              category.name,
                              style: TextStyle(fontFamily: 'Baloo'),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      //this value name can change. Instead of value, you can use item if u want
                      if (value == null) {
                        return;
                      }
                      setState(
                        () {
                          _selectedCategory = value;
                        },
                      );
                    },
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          _selectedTime == null
                              ? 'Select the time'
                              : timeFormat.format(_selectedTime!),
                          style: TextStyle(fontFamily: 'Baloo'),
                        ),
                        IconButton(
                          onPressed: _timePicker,
                          icon: const Icon(Icons.timer_sharp),
                        )
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          _selectedStartDate == null
                              ? 'Select the start date'
                              : dateFormat.format(_selectedStartDate!),
                          style: TextStyle(fontFamily: 'Baloo'),
                        ),
                        IconButton(
                          onPressed: _dateStartPicker,
                          icon: const Icon(Icons.calendar_month_outlined),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          _selectedEndDate == null
                              ? 'Select the end date'
                              : dateFormat.format(_selectedEndDate!),
                          style: TextStyle(fontFamily: 'Baloo'),
                        ),
                        IconButton(
                          onPressed: _dateEndPicker,
                          icon: const Icon(Icons.calendar_month_outlined),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(fontFamily: 'Baloo'),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _submitExpenseData,
                    child: const Text(
                      'Save Reminder',
                      style: TextStyle(fontFamily: 'Baloo'),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
