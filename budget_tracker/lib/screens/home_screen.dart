import 'package:flutter/material.dart';

import '../data/sample_expenses.dart';
import '../models/expense.dart';
import '../widgets/expense_tile.dart';
import '../widgets/summary_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // A copy of the sample list. In lesson 9 we'll add to it.
  final List<Expense> _expenses = [...sampleExpenses];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Budget Tracker'),
      ),
      body: Column(
        children: [
          SummaryCard(expenses: _expenses),
          Expanded(
            // ListView.builder only builds the rows you can see,
            // so it stays fast even with thousands of expenses.
            child: ListView.builder(
              itemCount: _expenses.length,
              itemBuilder: (context, index) {
                return ExpenseTile(expense: _expenses[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
