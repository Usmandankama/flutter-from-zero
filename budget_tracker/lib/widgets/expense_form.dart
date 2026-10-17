import 'package:flutter/material.dart';

import '../models/expense.dart';

class ExpenseForm extends StatefulWidget {
  const ExpenseForm({super.key, required this.onSubmit});

  // Called with the new expense once everything is valid.
  final void Function(Expense expense) onSubmit;

  @override
  State<ExpenseForm> createState() => _ExpenseFormState();
}

class _ExpenseFormState extends State<ExpenseForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  ExpenseCategory _category = ExpenseCategory.food;

  @override
  void dispose() {
    // Controllers hold on to memory, so we clean them up.
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  // People type "2,500" as often as "2500", so we ignore commas and spaces.
  int? _parseAmount(String? text) {
    final cleaned = (text ?? '').replaceAll(',', '').replaceAll(' ', '');
    return int.tryParse(cleaned);
  }

  String? _validateTitle(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'What did you spend on?';
    }
    return null;
  }

  String? _validateAmount(String? value) {
    final amount = _parseAmount(value);
    if (amount == null) {
      return 'Enter the amount as a number, like 2500';
    }
    if (amount <= 0) {
      return 'The amount must be more than ₦0';
    }
    if (amount > 100000000) {
      return 'That looks too big. Check the amount.';
    }
    return null;
  }

  void _submit() {
    // validate() runs every validator and shows the error messages.
    if (!_formKey.currentState!.validate()) {
      return;
    }
    widget.onSubmit(
      Expense(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        title: _titleController.text.trim(),
        amount: _parseAmount(_amountController.text)!,
        category: _category,
        date: DateTime.now(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'What did you buy?',
                hintText: 'e.g. Suya',
              ),
              textCapitalization: TextCapitalization.sentences,
              maxLength: 40,
              validator: _validateTitle,
            ),
            TextFormField(
              controller: _amountController,
              decoration: const InputDecoration(
                labelText: 'Amount',
                prefixText: '₦ ',
              ),
              keyboardType: TextInputType.number,
              validator: _validateAmount,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<ExpenseCategory>(
              initialValue: _category,
              decoration: const InputDecoration(labelText: 'Category'),
              items: [
                for (final category in ExpenseCategory.values)
                  DropdownMenuItem(
                    value: category,
                    child: Text(category.label),
                  ),
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _category = value;
                  });
                }
              },
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: _submit,
              child: const Text('Save expense'),
            ),
          ],
        ),
      ),
    );
  }
}
