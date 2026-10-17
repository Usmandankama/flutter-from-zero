import 'package:flutter_test/flutter_test.dart';

import 'package:budget_tracker/main.dart';

void main() {
  testWidgets('The home screen lists the sample expenses', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const BudgetApp());

    expect(find.text('Groceries'), findsOneWidget);
    expect(find.text('Movie Tickets'), findsOneWidget);
    expect(find.text('Bus Fare'), findsOneWidget);
    expect(find.text('Entertainment'), findsOneWidget);
  });
}
