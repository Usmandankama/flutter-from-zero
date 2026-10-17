import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/expense.dart';
import '../state/currency_store.dart';
import '../utils/format.dart';

class ExpenseTile extends StatelessWidget {
  const ExpenseTile({super.key, required this.expense, this.onTap});

  final Expense expense;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(
        backgroundColor: colors.secondaryContainer,
        foregroundColor: colors.onSecondaryContainer,
        child: Icon(expense.category.icon),
      ),
      // One line only: a long title ends in "..." instead of pushing
      // the amount around.
      title: Text(expense.title, maxLines: 1, overflow: TextOverflow.ellipsis),
      subtitle: Text(
        '${expense.category.label} · ${formatShortDate(expense.date)}',
      ),
      trailing: Text(
        context.watch<CurrencyStore>().format(expense.amount),
        style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
      ),
    );
  }
}
