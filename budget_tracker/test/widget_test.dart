import 'package:flutter_test/flutter_test.dart';

import 'package:budget_tracker/main.dart';

void main() {
  testWidgets('App starts and shows its title', (WidgetTester tester) async {
    await tester.pumpWidget(const BudgetApp());

    expect(find.text('Budget App'), findsOneWidget);
    expect(find.text('Hello World!'), findsOneWidget);
  });
}
