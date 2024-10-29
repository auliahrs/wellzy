import 'package:flutter/material.dart';
import 'dart:io';
import 'package:google_generative_ai/google_generative_ai.dart';

class AiAnswer extends StatelessWidget {
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

  Future<List<String>> generativeGeminiMethod(String age, String name, String allergies, String healthConditions) async {
    final apiKey = Platform.environment['GEMINI_API_KEY'];
    if (apiKey == null) {
      stderr.writeln('No GEMINI_API_KEY environment variable');
      exit(1);
    }

    final model = GenerativeModel(
      model: 'gemini-1.5-pro',
      apiKey: apiKey, // Use the API key from environment variables
      generationConfig: GenerationConfig(
        temperature: 0.5,
        topK: 64,
        topP: 0.95,
        maxOutputTokens: 8192,
        responseMimeType: 'text/plain',
      ),
      systemInstruction: Content.system(
          'just give the answer in bullet point. The system should give what activities user can do and what food and nutrition user should get based on medical research.'),
    );

    final chat = model.startChat(history: [
      Content.multi([TextPart(
        'I am $age, $selectGender, having $healthConditions, Allergic to $allergies, Severity of Symptoms is $selectSeverity.'
      )]),
    ]);

    final response = await chat.sendMessage(Content.text(''));
    return [response.text!];
  }

  @override
  Widget build(BuildContext context) {
    final String age = '${ageController.text} years old';
    final String name = nameController.text.isNotEmpty ? nameController.text : 'no disease';
    final String allergies = allergiesController.text.isNotEmpty ? allergiesController.text : 'no allergies';
    final String healthConditions = healthConditionsController.text.isNotEmpty ? healthConditionsController.text : 'no other health conditions';

    return FutureBuilder<List<String>>(
      future: generativeGeminiMethod(age, name, allergies, healthConditions),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final responseText = snapshot.data!.first; // Assuming the first element is the desired response
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              responseText,
              style: const TextStyle(fontSize: 16),
            ),
          );
        } else {
          return const Center(child: Text('No data available'));
        }
      },
    );
  }
}
