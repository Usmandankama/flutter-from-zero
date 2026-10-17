import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/currency_store.dart';
import '../state/expense_store.dart';
import '../widgets/expense_tile.dart';
import '../widgets/summary_card.dart';
import 'add_expense_screen.dart';
import 'expense_detail_screen.dart';

// No longer stateful: the expenses live in the ExpenseStore now.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> _toggleCurrency(BuildContext context) async {
    final worked = await context.read<CurrencyStore>().toggle();
    if (!worked && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Couldn't get today's rate. Check your internet and try again.",
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // watch: rebuild this screen whenever the store changes.
    final store = context.watch<ExpenseStore>();
    final currency = context.watch<CurrencyStore>();
    final expenses = store.expenses;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Budget Tracker'),
        actions: [
          TextButton.icon(
            // null switches the button off while the rate is loading.
            onPressed: currency.isLoading
                ? null
                : () => _toggleCurrency(context),
            icon: currency.isLoading
                ? const SizedBox.square(
                    dimension: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.currency_exchange),
            label: Text(currency.showDollars ? 'USD' : 'NGN'),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: store.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                SummaryCard(expenses: expenses),
                Expanded(
                  child: expenses.isEmpty
                      ? const _EmptyState()
                      : ListView.builder(
                          // Room at the bottom so the button never hides the last row.
                          padding: const EdgeInsets.only(bottom: 96),
                          itemCount: expenses.length,
                          itemBuilder: (context, index) {
                            final expense = expenses[index];
                            return ExpenseTile(
                              expense: expense,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ExpenseDetailScreen(expense: expense),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddExpenseScreen()),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Add expense'),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    // SingleChildScrollView: on a short screen the message scrolls
    // instead of overflowing.
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.receipt_long,
              size: 64,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 16),
            Text(
              'No expenses yet',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 4),
            const Text(
              'Tap "Add expense" to add the first thing you spent money on.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
