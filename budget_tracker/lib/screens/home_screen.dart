import 'package:flutter/material.dart';

import '../data/sample_expenses.dart';
import '../models/expense.dart';
import '../widgets/expense_tile.dart';
import '../widgets/summary_card.dart';
import 'add_expense_screen.dart';
import 'expense_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // A copy of the sample list, so we can add to it and delete from it.
  final List<Expense> _expenses = [...sampleExpenses];

  Future<void> _openAddExpense() async {
    // push opens a new screen on top. await waits until it closes,
    // and gives us whatever that screen passed to Navigator.pop.
    final expense = await Navigator.push<Expense>(
      context,
      MaterialPageRoute(builder: (context) => const AddExpenseScreen()),
    );
    if (expense == null) {
      return; // they went back without saving
    }
    setState(() {
      _expenses.insert(0, expense); // newest first
    });
  }

  Future<void> _openExpense(Expense expense) async {
    final deleted = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (context) => ExpenseDetailScreen(expense: expense),
      ),
    );
    if (deleted != true) {
      return;
    }
    setState(() {
      _expenses.removeWhere((e) => e.id == expense.id);
    });
  }

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
                final expense = _expenses[index];
                return ExpenseTile(
                  expense: expense,
                  onTap: () => _openExpense(expense),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddExpense,
        tooltip: 'Add expense',
        child: const Icon(Icons.add),
      ),
    );
  }
}
