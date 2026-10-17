import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/sample_expenses.dart';
import 'screens/home_screen.dart';
import 'state/expense_store.dart';

void main() {
  runApp(
    // Everything below this can reach the ExpenseStore.
    ChangeNotifierProvider(
      create: (context) => ExpenseStore(sampleExpenses),
      child: const BudgetApp(),
    ),
  );
}

class BudgetApp extends StatelessWidget {
  const BudgetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Budget Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      home: const HomeScreen(),
    );
  }
}
