import 'package:flutter/material.dart';
import 'package:wellzy/Views/AI/ai_answer.dart';

class Backpage extends StatelessWidget {
  const Backpage({super.key, required this.response, required this.isKeyword});

  final String response;
  final bool Function(String line, List<String> keywords) isKeyword;

  // Modify _continueElaborate to take List<String> as a parameter
  AiAnswer _continueElaborate(List<String> responses) {
    final combinedText = responses.join('\n');

    return AiAnswer(prompt: combinedText, page: 2,);
  }

  @override
  Widget build(BuildContext context) {
    final keywords = [
                "**Activities:**",
                "**Food and Nutrition:**",
                "**Important Note:**"
              ];
    final responses =
        response.split('\n').where((line) => line.isNotEmpty).toList();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Recommended Actions and Dietary Advice:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              ...responses.map((line) {
                final isBold = isKeyword(line, keywords);
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
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
                            fontWeight:
                                isBold ? FontWeight.bold : FontWeight.normal,
                            fontFamily: 'Baloo',
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
              // Add the Continue button here after the response list
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
                  TextButton(
                    onPressed: () {
                      _continueElaborate(responses);
                    },
                    child: const Text(
                      'Continue',
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
      ],
    );
  }
}
