import 'package:intl/intl.dart';

final timeFormat = DateFormat.jm();
final dateFormat = DateFormat.yMEd();
enum Category {pill, drink, inhaler, eyeDrop, patches, powder}

const categoryImage = {
  Category.pill: 'assets/images/pill.jpg',
  Category.drink: 'assets/images/drink.png',
  Category.inhaler: 'assets/images/inhaler.jpg',
  Category.eyeDrop: 'assets/images/eye_drop.jpg',
  Category.patches: 'assets/images/patches.jpg',
  Category.powder: 'assets/images/powder.jpg',
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