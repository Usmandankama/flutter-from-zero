import 'package:budget_tracker/widgets/summary_card.dart';
import 'package:flutter/material.dart';

import '../data/sampl_expeses.dart';
import '../models/expense.dart';
import '../widgets/expense_tile.dart';

// Stateful: the total changes while the app is running.
class HomeScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // The three dots copy the sample expenses into our own list.
  final List<Expense> _expenses = [...SampleExpense];

  int _total = 0;
  int _count = 0;

  void _addSpending(int amount) {
    // setState tells Flutter "something changed, build the screen again".
    setState(() {
      _total += amount;
      _count += 1;
    });

    // _total += amount;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Budget App')),
      body: Column(
        children: [
          Summarycard(total: _total, count: _count),
          // Expanded gives the list all the space below the card.
          Expanded(
            // ListView.builder only builds the rows you can see.
            child: ListView.builder(
              itemCount: _expenses.length,
              itemBuilder: (context, index) {
                final expense = _expenses[index];
                return ExpesnseTile(expense: expense);
              },
            ),
          ),
        ],
      ),
    );
  }
}
