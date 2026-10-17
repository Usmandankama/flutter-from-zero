import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/expense_store.dart';
import '../widgets/expense_form.dart';

class AddExpenseScreen extends StatelessWidget {
  const AddExpenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add expense')),
      body: SingleChildScrollView(
        child: ExpenseForm(
          onSubmit: (expense) {
            // read: use the store once, without rebuilding when it changes.
            context.read<ExpenseStore>().add(expense);
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
