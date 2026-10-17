import 'package:flutter/material.dart';

// An enum with values: each category carries a label and an icon.
enum ExpenseCategory {
  food('Food', Icons.fastfood),
  transport('Transport', Icons.directions_car),
  entertainment('Entertainment', Icons.movie),
  shopping('Shopping', Icons.shopping_cart),
  bills('Bills', Icons.receipt),
  others('Others', Icons.category);

  const ExpenseCategory(this.label, this.icon);

  final String label;
  final IconData icon;
}

// The model: the shape every expense in the app follows.
class Expense {
  Expense({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  });

  final String id;
  final String title;
  final int amount; // whole numbers only
  final DateTime date;
  final ExpenseCategory category;
}
