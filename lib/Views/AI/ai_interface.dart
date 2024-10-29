import 'package:flutter/material.dart';
import 'package:wellzy/Views/AI/ai_answer.dart';

class AiInterface extends StatefulWidget {
  const AiInterface({super.key});

  @override
  State<AiInterface> createState() => _AiInterfaceState();
}

class _AiInterfaceState extends State<AiInterface> {
  final _ageController = TextEditingController();
  final _nameController = TextEditingController();
  final _allergiesController = TextEditingController();
  final _healthConditionsController = TextEditingController();
  String _selectGender = 'Male';
  List<String> gender = ['Male', 'Female'];
  String _selectSeverity = 'Mild';
  List<String> severity = ['Mild', 'Moderate', 'Severe'];

  _openAddReminderOverlay() {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      builder: (context) => AiAnswer(
        ageController: _ageController,
        nameController: _nameController,
        allergiesController: _allergiesController,
        healthConditionsController: _healthConditionsController,
        selectGender: _selectGender,
        selectSeverity: _selectSeverity,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 45),
      child: Column(
        children: [
          Row(
            children: [
              TextField(
                controller: _ageController,
                decoration: InputDecoration(
                  hintText: 'Age',
                  hintStyle: const TextStyle(fontFamily: 'Baloo'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
              const Spacer(),
              DropdownButton(
                value:
                    _selectGender, //this value is for the dropdown button, not the item. need to be set to be visible
                items: gender
                    .map(
                      (gender) => DropdownMenuItem(
                        value: gender,
                        child: Text(
                          gender.toUpperCase(),
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
                      _selectGender = value;
                    },
                  );
                },
              ),
            ],
          ),
          SizedBox(
            width: 400,
            child: TextField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: 'Name of the disease',
                hintStyle: const TextStyle(fontFamily: 'Baloo'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),
          DropdownButton(
            value: _selectSeverity,
            items: [
              ...severity.map(
                (severity) => DropdownMenuItem(
                  value: severity,
                  child: Text(
                    severity.toUpperCase(),
                  ),
                ),
              ),
            ],
            onChanged: (value) {
              if (value == null) {
                return;
              }
              setState(() {
                _selectSeverity = value;
              });
            },
          ),
          SizedBox(
            width: 400,
            child: TextField(
              controller: _allergiesController,
              decoration: InputDecoration(
                hintText: 'Allergies ',
                hintStyle: const TextStyle(fontFamily: 'Baloo'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 400,
            child: TextField(
              controller: _healthConditionsController,
              decoration: InputDecoration(
                hintText: 'Other Health Conditions',
                hintStyle: const TextStyle(fontFamily: 'Baloo'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _openAddReminderOverlay,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              backgroundColor: const Color(0xFF72B376),
            ),
            child: const Text(
              'Save',
              style: TextStyle(
                fontSize: 18,
                color: Color(0xFF294B29),
                fontFamily: 'Baloo',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
