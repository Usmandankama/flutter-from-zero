import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:budget_tracker/main.dart';

void main() {
  testWidgets('The card shows the total, the count and the average', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const BudgetApp());

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    expect(find.text('\$20'), findsOneWidget);
    expect(find.text('2'), findsOneWidget); // Income: the count
    expect(find.text('10'), findsOneWidget); // Expenses: the average
  });
}
