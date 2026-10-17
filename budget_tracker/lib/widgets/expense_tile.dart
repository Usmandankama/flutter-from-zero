import 'package:budget_tracker/models/expense.dart';
import 'package:flutter/material.dart';

// One row in the list: an icon, the title, the amount and date, and the category.
class ExpesnseTile extends StatelessWidget {
  const ExpesnseTile({super.key, required this.expense});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.deepOrange,
        child: Icon(expense.category.icon, color: Colors.white),
      ),
      title: Text(expense.title),
      subtitle: Text('\$${expense.amount} - ${expense.date.toLocal()}'),
      trailing: Text(expense.category.label),
    );
  }
}
