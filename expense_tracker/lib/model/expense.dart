import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

const uuid = Uuid();
final formatter = DateFormat.yMd();

enum Category { food, work, leisure, travel }

const categoryIcon = {
  Category.food: Icons.lunch_dining,
  Category.leisure: Icons.movie,
  Category.travel: Icons.flight_takeoff,
  Category.work: Icons.work,
};


class Expense{
  Expense({required this.amount, required this.title, required this.category, required this.date}): id = uuid.v4();
  final String id;
  final double amount;
  final String title;
  final Category category;
  final DateTime date;

  String get formattedDate {
    return formatter.format(date);
  }
}