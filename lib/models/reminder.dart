import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

final timeFormat = DateFormat.jm();
final dateFormat = DateFormat.yMEd();
enum Category {pill, drink, inhaler, eyeDrop, patches, powder}

const categoryIcons = {
  Category.pill: Icons.medication,
  Category.drink: Icons.water_drop,
  Category.inhaler: Icons.air,
  Category.eyeDrop: Icons.visibility,
  Category.patches: Icons.sticky_note_2,
  Category.powder: Icons.science,
};

class Reminder {
  final String name;
  final String dosage;
  final Category category;
  final DateTime time;
  final DateTime startDate;
  final DateTime endDate;
  String? notes;


  Reminder({
    required this.name,
    required this.dosage,
    required this.category,
    required this.time,
    required this.startDate,
    required this.endDate,
    this.notes,
    });
  
}