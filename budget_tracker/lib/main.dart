import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/home_screen.dart';
import 'services/expense_storage.dart';
import 'state/expense_store.dart';

void main() {
  runApp(
    // Everything below this can reach the ExpenseStore.
    ChangeNotifierProvider(
      // ..load() makes the store and starts loading the saved expenses.
      create: (context) => ExpenseStore(ExpenseStorage())..load(),
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
