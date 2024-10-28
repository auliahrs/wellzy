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

  void _presentTimePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);

final pickTime = await showTimePicker(context: context, initialTime: initialTime);

    final pickDate = await showTimePicker(
      context: context,
      firstDate: firstDate,
      lastDate: now,
      initialDate: now,
    );

    setState(() {
      _selectedTime = pickDate;
    });
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
                  label: Text('Name'),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                controller: _dosageController,
                maxLength: 50,
                decoration: const InputDecoration(
                  label: Text('Dosage'),
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
                              category.name.toUpperCase(),
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
                        Text(_selectedTime == null
                            ? 'No date selected'
                            : timeFormat.format(_selectedTime!)),
                        IconButton(
                          onPressed: _presentTimePicker,
                          icon: const Icon(Icons.calendar_month),
                        )
                      ],
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
