import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:budget_tracker/main.dart';
import 'package:budget_tracker/utils/format.dart';

void main() {
  test('formatNaira adds the symbol and commas', () {
    expect(formatNaira(0), '₦0');
    expect(formatNaira(800), '₦800');
    expect(formatNaira(2500), '₦2,500');
    expect(formatNaira(1234567), '₦1,234,567');
  });

  testWidgets('Home screen lists the expenses and the total', (WidgetTester tester) async {
    await tester.pumpWidget(const BudgetApp());

    expect(find.text('Suya'), findsOneWidget);
    expect(find.text('₦28,000'), findsOneWidget); // total of the samples
  });

  testWidgets('Adding an expense checks the form and updates the list', (WidgetTester tester) async {
    await tester.pumpWidget(const BudgetApp());

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    // Saving an empty form shows the error messages.
    await tester.tap(find.text('Save expense'));
    await tester.pump();
    expect(find.text('What did you spend on?'), findsOneWidget);
    expect(find.text('Enter the amount as a number, like 2500'), findsOneWidget);

    await tester.enterText(find.byType(TextFormField).at(0), 'Shawarma');
    await tester.enterText(find.byType(TextFormField).at(1), '3,000');
    await tester.tap(find.text('Save expense'));
    await tester.pumpAndSettle();

    expect(find.text('Shawarma'), findsOneWidget);
    expect(find.text('₦31,000'), findsOneWidget); // 28,000 + 3,000
  });

  testWidgets('Deleting an expense removes it from the list', (WidgetTester tester) async {
    await tester.pumpWidget(const BudgetApp());

    await tester.tap(find.text('Suya'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Delete expense'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Delete'));
    await tester.pumpAndSettle();

    expect(find.text('Suya'), findsNothing);
    expect(find.text('₦25,500'), findsOneWidget); // 28,000 - 2,500
  });
}
