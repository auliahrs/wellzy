import 'package:flutter/material.dart';
import 'package:wellzy/Views/AI/ai_answer.dart';

class ElaborateAnswer extends StatelessWidget {
  const ElaborateAnswer(
      {super.key,
      required this.prompt,
      required this.generativeGeminiElaborateAnswer,
      required this.isKeyword});

  final String prompt;
  final Future<String> Function(String prompt) generativeGeminiElaborateAnswer;
  final bool Function(String line, List<String> keywords) isKeyword;

  _backPage(BuildContext context) {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      builder: (context) => AiAnswer(
        prompt: prompt,
        page: 3,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder<String>(
          future: generativeGeminiElaborateAnswer(prompt),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              final keywords = [
                "**Activities:**",
                "**Food and Nutrition:**",
                "**Important Note:**"
              ];

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
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                                  fontWeight: isBold
                                      ? FontWeight.bold
                                      : FontWeight.normal,
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
                        // TextButton(
                        //   onPressed: () {
                        //     _backPage(context);
                        //   },
                        //   child: const Text(
                        //     'Back',
                        //     style: TextStyle(
                        //       color: Color(0xFF294B29),
                        //       fontFamily: 'Baloo',
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ],
                ),
              );
            } else {
              return Column(
                children: [
                  Text('No data available'),
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
              );
            }
          },
        ),
      ],
    );
  }
}
