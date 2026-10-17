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

  // To save an expense we turn it into a Map of simple values (JSON)...
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'category': category.name, // e.g. "food"
      'date': date.toIso8601String(), // e.g. "2026-10-17T13:45:00.000"
    };
  }

  // ...and to load it, we turn that Map back into an Expense.
  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      id: json['id'] as String,
      title: json['title'] as String,
      amount: json['amount'] as int,
      // byName crashed on a category this version doesn't know, so we look
      // it up instead and fall back to Other.
      category:
          ExpenseCategory.values.asNameMap()[json['category']] ??
          ExpenseCategory.other,
      date: DateTime.parse(json['date'] as String),
    );
  }
}
