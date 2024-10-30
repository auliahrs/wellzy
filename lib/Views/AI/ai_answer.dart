import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class AiAnswer extends StatefulWidget {
  const AiAnswer({
    super.key,
    required this.ageController,
    required this.nameController,
    required this.allergiesController,
    required this.healthConditionsController,
    required this.selectGender,
    required this.selectSeverity,
  });

  final TextEditingController ageController;
  final TextEditingController nameController;
  final TextEditingController allergiesController;
  final TextEditingController healthConditionsController;
  final String selectGender;
  final String selectSeverity;

  @override
  State<AiAnswer> createState() => _AiAnswerState();
}

class _AiAnswerState extends State<AiAnswer> {
  final String apiKey =
      const String.fromEnvironment('AIzaSyBOA4Px0DUnSWYuW2bc4E2TQFQUGK1AjwU');

  // Define the helper function here
  bool isKeyword(String line, List<String> keywords) {
    for (final keyword in keywords) {
      if (line.contains(keyword)) return true;
    }
    return false;
  }

  GeminiAPI() {
    if (apiKey.isEmpty) {
      throw Exception(
          'API Key not found! Set the API_KEY environment variable.');
    }
  }

  Future<String> generativeGeminiMethod(String age, String name,
      String allergies, String healthConditions) async {
    final model = GenerativeModel(
      model: 'gemini-1.5-pro',
      apiKey: 'AIzaSyBOA4Px0DUnSWYuW2bc4E2TQFQUGK1AjwU',
    );

    final prompt = '''
Please provide concise and accurate recommendations for the user based on medical research, focusing on the following categories:
- **Activities**: Suggest physical or mental activities beneficial for the user's condition.
- **Food and Nutrition**: Recommend foods and nutritional advice that support health improvement or symptom management.
- **Important Note**: Include any critical advice or precautions the user should be aware of.

User details:
- Age: $age
- Gender: ${widget.selectGender}
- Health Conditions: $name
- Allergies: $allergies
- Symptom Severity: ${widget.selectSeverity}
- Additional Health Conditions: $healthConditions

Please respond in bullet points for each category.
''';
    final response = await model.generateContent([Content.text(prompt)]);
    return response.text ?? 'No content received from the API';
  }

  // Method to generate text content using GenerativeModel

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    final String age = '${widget.ageController.text} years old';
    final String name = widget.nameController.text.isNotEmpty
        ? widget.nameController.text
        : 'no disease';
    final String allergies = widget.allergiesController.text.isNotEmpty
        ? widget.allergiesController.text
        : 'no allergies';
    final String healthConditions =
        widget.healthConditionsController.text.isNotEmpty
            ? widget.healthConditionsController.text
            : 'no other health conditions';

    return SizedBox(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),
          child: Column(
            children: [
              FutureBuilder<String>(
                future: generativeGeminiMethod(
                    age, name, allergies, healthConditions),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.hasData) {
                    // List of keywords to bold
                    final keywords = [
                      "**Activities:**",
                      "**Food and Nutrition:**",
                      "**Important Note:**"
                    ];

                    // Process the response by splitting lines and creating a list of formatted widgets
                    final responses = snapshot.data!
                        .split('\n')
                        .where((line) => line.isNotEmpty)
                        .toList();

                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Recommended Actions and Dietary Advice:',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 12),
                          // Display each line of the response with conditional bold formatting
                          ...responses.map((line) {
                            // Use the helper function to check if the line contains a keyword
                            final isBold = isKeyword(line, keywords);

                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 4.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    '• ',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Expanded(
                                    child: Text(
                                      line.trim(),
                                      style: TextStyle(
                                          fontSize: 16,
                                          height: 1.5,
                                          fontWeight: isBold
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                          fontFamily: 'Baloo'),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ],
                      ),
                    );
                  } else {
                    return const Center(child: Text('No data available'));
                  }
                },
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Close',
                          style: TextStyle(
                            color: Color(0xFF294B29),
                            fontFamily: 'Baloo',
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
