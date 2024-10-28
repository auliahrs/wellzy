import 'package:flutter/material.dart';

class AiInterface extends StatelessWidget {
  const AiInterface({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 45),
      child: Column(
        children: [
          SizedBox(
            width: 400,
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Name of the disease',
                hintStyle: const TextStyle(fontFamily: 'Baloo'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
