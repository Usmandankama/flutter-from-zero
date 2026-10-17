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
    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(child: Icon(expense.category.icon)),
      title: Text(expense.title),
      subtitle: Text(
        '${expense.category.label} · ${formatShortDate(expense.date)}',
      ),
      trailing: Text(
        context.watch<CurrencyStore>().format(expense.amount),
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }
}
