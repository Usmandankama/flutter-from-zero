import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/home_screen.dart';
import 'services/expense_storage.dart';
import 'services/rates_service.dart';
import 'state/currency_store.dart';
import 'state/expense_store.dart';

void main() {
  runApp(
    // Everything below this can reach both stores.
    MultiProvider(
      providers: [
        // ..load() makes the store and starts loading the saved expenses.
        ChangeNotifierProvider(
          create: (context) => ExpenseStore(ExpenseStorage())..load(),
        ),
        ChangeNotifierProvider(
          create: (context) => CurrencyStore(RatesService()),
        ),
      ],
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
