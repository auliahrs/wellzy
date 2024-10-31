import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:wellzy/Views/AI/backPage.dart';
import 'package:wellzy/Views/AI/bullet_answer.dart';
import 'package:wellzy/Views/AI/elaborate_answer.dart';

class AiAnswer extends StatefulWidget {
  const AiAnswer({super.key, required this.prompt, required this.page});

  final String prompt;
  final int page;

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

  Future<String> generativeGeminiBulletAnswer(prompt) async {
    final model = GenerativeModel(
      model: 'gemini-1.5-pro',
      apiKey: 'AIzaSyBOA4Px0DUnSWYuW2bc4E2TQFQUGK1AjwU',
    );
    final response = await model.generateContent([Content.text(prompt)]);
    return response.text ?? 'No content received from the API';
  }

  Future<String> generativeGeminiElaborateAnswer(prompt) async {
    final model = GenerativeModel(
      model: 'gemini-1.5-pro',
      apiKey: 'AIzaSyBOA4Px0DUnSWYuW2bc4E2TQFQUGK1AjwU',
    );

    String completePrompt = "Please elaborate this point: $prompt";

    final response =
        await model.generateContent([Content.text(completePrompt)]);
    return response.text ?? 'No content received from the API';
  }

  // Method to generate text content using GenerativeModel

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    return SizedBox(
      child: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),
            child: widget.page == 1
                ? BulletAnswer(
                    prompt: widget.prompt,
                    generativeGeminiBulletAnswer: generativeGeminiBulletAnswer,
                    isKeyword: isKeyword,
                  )
                : widget.page == 2
                    ? ElaborateAnswer(
                        prompt: widget.prompt,
                        generativeGeminiElaborateAnswer:
                            generativeGeminiElaborateAnswer,
                        isKeyword: isKeyword,
                      )
                    : Backpage(
                        response: widget.prompt, isKeyword: isKeyword,
                      )),
      ),
    );
  }
}
