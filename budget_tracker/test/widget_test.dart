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
}
