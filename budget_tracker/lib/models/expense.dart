import 'package:flutter/material.dart';

// An enhanced enum: each category carries its own label and icon.
enum ExpenseCategory {
  food('Food', Icons.restaurant),
  transport('Transport', Icons.directions_bus),
  data('Data & airtime', Icons.wifi),
  bills('Bills', Icons.receipt_long),
  other('Other', Icons.more_horiz);

  const ExpenseCategory(this.label, this.icon);

  final String label;
  final IconData icon;
}

class Expense {
  Expense({
    required this.id,
    required this.title,
    required this.amount,
    required this.category,
    required this.date,
  });

  final String id;
  final String title;
  final int amount; // whole naira
  final ExpenseCategory category;
  final DateTime date;
}
