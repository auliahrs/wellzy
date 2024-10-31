import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

final timeFormat = DateFormat.jm();
final dateFormat = DateFormat.yMEd();

enum Category { pill, drink, inhaler, eyeDrop, patches, powder }

const categoryImage = {
  Category.pill: 'assets/images/pill.jpg',
  Category.drink: 'assets/images/drink.png',
  Category.inhaler: 'assets/images/inhaler.jpg',
  Category.eyeDrop: 'assets/images/eye_drop.jpg',
  Category.patches: 'assets/images/patches.jpg',
  Category.powder: 'assets/images/powder.jpg',
};

const categoryName = {
  'pill': Category.pill,
  'drink': Category.drink,
  'inhaler': Category.inhaler,
  'eyeDrop': Category.eyeDrop,
  'patches': Category.patches,
  'powder': Category.powder,
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

  // Create a factory method to create a Reminder from Firestore data
  factory Reminder.fromFirestore(Map<String, dynamic> data, String id) {

    Category? typeCategory = categoryName[data['category']];
    return Reminder(
      name: data['name'],
      dosage: data['dosage'],
      category: typeCategory!,
      time: (data['time'] as Timestamp).toDate(), // Convert Timestamp to DateTime
      startDate: (data['startDate'] as Timestamp).toDate(), // Convert Timestamp to DateTime
      endDate: (data['endDate'] as Timestamp).toDate(), // Convert Timestamp to DateTime
      notes: data['notes']
    );
  }
}
