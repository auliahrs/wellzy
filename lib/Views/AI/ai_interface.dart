import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 45),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _ageController,
                    decoration: InputDecoration(
                      label: const Text(
                        'Age',
                        style: TextStyle(fontFamily: 'Baloo'),
                      ),
                      hintText: 'Number only',
                      hintStyle: const TextStyle(
                          fontFamily: 'Baloo',
                          color: Color.fromARGB(100, 0, 0, 0)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                  ),
                ),
                const SizedBox(width: 50),
                DropdownButton(
                  value:
                      _selectGender, //this value is for the dropdown button, not the item. need to be set to be visible
                  items: gender
                      .map(
                        (gender) => DropdownMenuItem(
                          value: gender,
                          child: Text(
                            gender,
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
                        _selectGender = value;
                      },
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 25),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    child: TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        label: const Text(
                          'Name of the disease',
                          style: TextStyle(fontFamily: 'Baloo'),
                        ),
                        hintText: 'Ex: Asthma, Diabetes',
                        hintStyle: const TextStyle(
                            fontFamily: 'Baloo',
                            color: Color.fromARGB(100, 0, 0, 0)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 30),
                DropdownButton(
                  value: _selectSeverity,
                  items: [
                    ...severity.map(
                      (severity) => DropdownMenuItem(
                        value: severity,
                        child: Text(
                          severity,
                          style: TextStyle(fontFamily: 'Baloo'),
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
              ],
            ),
            const SizedBox(height: 25),
            SizedBox(
              child: TextField(
                controller: _allergiesController,
                decoration: InputDecoration(
                  label: const Text(
                    'Allergies',
                    style: TextStyle(fontFamily: 'Baloo'),
                  ),
                  hintText: 'Ex: Shellfish ',
                  hintStyle: const TextStyle(
                      fontFamily: 'Baloo', color: Color.fromARGB(100, 0, 0, 0)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 25),
            SizedBox(
              child: TextField(
                controller: _healthConditionsController,
                decoration: InputDecoration(
                  label: const Text(
                    'Other Health Conditions',
                    style: TextStyle(fontFamily: 'Baloo'),
                  ),
                  hintText: 'Ex: Hypertension, High cholesterol ',
                  hintStyle: const TextStyle(
                      fontFamily: 'Baloo', color: Color.fromARGB(100, 0, 0, 0)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: _openAddReminderOverlay,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF72B376),
                  ),
                  child: const Text(
                    'Save',
                    style: TextStyle(
                      color: Color(0xFF294B29),
                      fontFamily: 'Baloo',
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
