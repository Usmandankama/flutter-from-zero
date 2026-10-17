import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:budget_tracker/models/expense.dart';
import 'package:budget_tracker/services/expense_storage.dart';

import 'test_expenses.dart';
import 'widget_test.dart' show buildApp, savedOnPhone;

// A phone turned sideways: wide and short.
void turnPhoneSideways(WidgetTester tester) {
  tester.view.physicalSize = const Size(800, 360);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
}

void main() {
  testWidgets('Detail screen fits on a sideways phone', (tester) async {
    turnPhoneSideways(tester);
    savedOnPhone(testExpenses);
    await tester.pumpWidget(buildApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Suya'));
    await tester.pumpAndSettle();

    // An overflow would have failed the test already; check the button is there.
    expect(find.text('Delete expense'), findsOneWidget);
  });

  testWidgets('Empty message fits on a sideways phone', (tester) async {
    turnPhoneSideways(tester);
    savedOnPhone([]);
    await tester.pumpWidget(buildApp());
    await tester.pumpAndSettle();

    expect(find.text('No expenses yet'), findsOneWidget);
  });

  test(
    'Saved data the app cannot read gives an empty list, not a crash',
    () async {
      SharedPreferences.setMockInitialValues({'expenses': 'this is not JSON'});

      expect(await ExpenseStorage().load(), isEmpty);
    },
  );

  test('An unknown category is loaded as Other', () {
    final expense = Expense.fromJson({
      'id': '1',
      'title': 'Gym',
      'amount': 15000,
      'category': 'fitness', // a category this version doesn't have
      'date': '2026-10-17T09:00:00.000',
    });

    expect(expense.category, ExpenseCategory.other);
  });
}
