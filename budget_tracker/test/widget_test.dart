import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:budget_tracker/main.dart';
import 'package:budget_tracker/services/expense_storage.dart';
import 'package:budget_tracker/services/rates_service.dart';
import 'package:budget_tracker/state/currency_store.dart';
import 'package:budget_tracker/state/expense_store.dart';
import 'package:budget_tracker/utils/format.dart';

import 'test_expenses.dart';

// Tests mustn't depend on the internet, so these stand in for the real rates.
class FakeRates extends RatesService {
  @override
  Future<double> nairaToDollar() async => 0.001; // ₦1,000 = $1
}

class BrokenRates extends RatesService {
  @override
  Future<double> nairaToDollar() async => throw Exception('No internet');
}

// The app the same way main() builds it, with fresh stores for each test.
Widget buildApp({RatesService? rates}) {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => ExpenseStore(ExpenseStorage())..load(),
      ),
      ChangeNotifierProvider(
        create: (context) => CurrencyStore(rates ?? FakeRates()),
      ),
    ],
    child: const BudgetApp(),
  );
}

// Pretend the phone already has these expenses saved.
void savedOnPhone(List<Object> expenses) {
  SharedPreferences.setMockInitialValues({'expenses': jsonEncode(expenses)});
}

void main() {
  test('formatNaira adds the symbol and commas', () {
    expect(formatNaira(0), '₦0');
    expect(formatNaira(800), '₦800');
    expect(formatNaira(2500), '₦2,500');
    expect(formatNaira(1234567), '₦1,234,567');
  });

  test('formatDollars shows cents', () {
    expect(formatDollars(0), '\$0.00');
    expect(formatDollars(1.6), '\$1.60');
    expect(formatDollars(28), '\$28.00');
    expect(formatDollars(1234.567), '\$1,234.57');
  });

  test('Dates are short in the list and long on the detail screen', () {
    final date = DateTime(2026, 10, 17, 13, 45);
    expect(formatShortDate(date), '17 Oct');
    expect(formatLongDate(date), 'Saturday 17 October 2026, 1:45 PM');
  });

  testWidgets('The currency button switches totals to dollars and back', (
    WidgetTester tester,
  ) async {
    savedOnPhone(testExpenses);
    await tester.pumpWidget(buildApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('NGN'));
    await tester.pumpAndSettle();
    expect(find.text('\$28.00'), findsOneWidget);

    await tester.tap(find.text('USD'));
    await tester.pumpAndSettle();
    expect(find.text('₦28,000'), findsOneWidget);
  });

  testWidgets('No internet shows a message and stays in naira', (
    WidgetTester tester,
  ) async {
    savedOnPhone(testExpenses);
    await tester.pumpWidget(buildApp(rates: BrokenRates()));
    await tester.pumpAndSettle();

    await tester.tap(find.text('NGN'));
    await tester.pumpAndSettle();

    expect(find.textContaining("Couldn't get today's rate"), findsOneWidget);
    expect(find.text('₦28,000'), findsOneWidget);
  });

  testWidgets('Home screen lists the expenses and the total', (
    WidgetTester tester,
  ) async {
    savedOnPhone(testExpenses);
    await tester.pumpWidget(buildApp());
    await tester.pumpAndSettle();

    expect(find.text('Suya'), findsOneWidget);
    expect(find.text('₦28,000'), findsOneWidget);
  });

  testWidgets('A new install shows the empty message', (
    WidgetTester tester,
  ) async {
    savedOnPhone([]);
    await tester.pumpWidget(buildApp());
    await tester.pumpAndSettle();

    expect(find.text('No expenses yet'), findsOneWidget);
  });

  testWidgets('Adding an expense checks the form and updates the list', (
    WidgetTester tester,
  ) async {
    savedOnPhone(testExpenses);
    await tester.pumpWidget(buildApp());
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    // Saving an empty form shows the error messages.
    await tester.tap(find.text('Save expense'));
    await tester.pump();
    expect(find.text('What did you spend on?'), findsOneWidget);
    expect(
      find.text('Enter the amount as a number, like 2500'),
      findsOneWidget,
    );

    await tester.enterText(find.byType(TextFormField).at(0), 'Shawarma');
    await tester.enterText(find.byType(TextFormField).at(1), '3,000');
    await tester.tap(find.text('Save expense'));
    await tester.pumpAndSettle();

    expect(find.text('Shawarma'), findsOneWidget);
    expect(find.text('₦31,000'), findsOneWidget); // 28,000 + 3,000
  });

  testWidgets('Deleting an expense removes it from the list', (
    WidgetTester tester,
  ) async {
    savedOnPhone(testExpenses);
    await tester.pumpWidget(buildApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Suya'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Delete expense'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Delete'));
    await tester.pumpAndSettle();

    expect(find.text('Suya'), findsNothing);
    expect(find.text('₦25,500'), findsOneWidget); // 28,000 - 2,500
  });

  test('Expenses are still there after the app restarts', () async {
    savedOnPhone([]);
    final before = ExpenseStore(ExpenseStorage());
    await before.load();
    await before.add(testExpenses.first);

    // A brand-new store, like opening the app again.
    final after = ExpenseStore(ExpenseStorage());
    await after.load();

    expect(after.expenses.single.title, testExpenses.first.title);
    expect(after.expenses.single.amount, testExpenses.first.amount);
  });
}
