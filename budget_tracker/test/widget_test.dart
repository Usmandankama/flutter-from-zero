import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:budget_tracker/main.dart';

void main() {
  testWidgets('Tapping + adds \$10 to the total', (WidgetTester tester) async {
    await tester.pumpWidget(const BudgetApp());
    expect(find.text('\$0'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    expect(find.text('\$10'), findsOneWidget);
  });
}
