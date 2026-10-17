import 'package:flutter/material.dart';

import '../widgets/expense_form.dart';

class AddExpenseScreen extends StatelessWidget {
  const AddExpenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add expense'),
      ),
      body: SingleChildScrollView(
        child: ExpenseForm(
          onSubmit: (expense) {
            // Close this screen and hand the new expense back.
            Navigator.pop(context, expense);
          },
        ),
      ),
    );
  }
}
