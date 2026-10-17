import 'package:flutter/material.dart';

import '../models/expense.dart';
import '../utils/format.dart';

class SummaryCard extends StatelessWidget {
  const SummaryCard({super.key, required this.expenses});

  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final total = expenses.fold<int>(0, (sum, e) => sum + e.amount);
    final count = expenses.length;
    final average = count == 0 ? 0 : total ~/ count;

    // Container: one box we can give a size, padding, colour and corners.
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colors.primaryContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      // Column: children stacked top to bottom.
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Total spent'),
          Text(
            formatNaira(total),
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(height: 16),
          // Row: children side by side. Expanded makes each take an equal share.
          Row(
            children: [
              Expanded(child: _Stat(label: 'Expenses', value: '$count')),
              Expanded(child: _Stat(label: 'Average', value: formatNaira(average))),
            ],
          ),
        ],
      ),
    );
  }
}

// The _ at the start means only this file can use it.
class _Stat extends StatelessWidget {
  const _Stat({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.labelMedium),
        Text(value, style: Theme.of(context).textTheme.titleMedium),
      ],
    );
  }
}
