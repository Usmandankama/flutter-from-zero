import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/expense.dart';
import '../state/currency_store.dart';

class SummaryCard extends StatelessWidget {
  const SummaryCard({super.key, required this.expenses});

  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    // Take colours and text styles from the theme instead of typing them in,
    // so the card looks right in both light and dark mode.
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final currency = context.watch<CurrencyStore>();

    final total = expenses.fold<int>(0, (sum, e) => sum + e.amount);
    final count = expenses.length;
    final average = count == 0 ? 0 : total ~/ count;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colors.primary,
        borderRadius: BorderRadius.circular(20),
      ),
      // DefaultTextStyle: every Text inside uses this colour unless told otherwise.
      child: DefaultTextStyle.merge(
        style: TextStyle(color: colors.onPrimary),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Total spent',
              style: TextStyle(color: colors.onPrimary.withValues(alpha: 0.8)),
            ),
            const SizedBox(height: 4),
            Text(
              currency.format(total),
              style: textTheme.headlineLarge?.copyWith(
                color: colors.onPrimary,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _Stat(label: 'Expenses', value: '$count'),
                ),
                Expanded(
                  child: _Stat(
                    label: 'Average',
                    value: currency.format(average),
                  ),
                ),
              ],
            ),
            if (currency.showDollars) ...[
              const SizedBox(height: 12),
              Text(
                'Rates by exchangerate-api.com',
                style: textTheme.labelSmall?.copyWith(
                  color: colors.onPrimary.withValues(alpha: 0.8),
                ),
              ),
            ],
          ],
        ),
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
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: textTheme.labelMedium?.copyWith(
            color: colors.onPrimary.withValues(alpha: 0.8),
          ),
        ),
        Text(
          value,
          style: textTheme.titleMedium?.copyWith(
            color: colors.onPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
