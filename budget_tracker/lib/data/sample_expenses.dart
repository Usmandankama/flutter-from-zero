import '../models/expense.dart';

// Made-up expenses so we have something to show while we build the list.
final sampleExpenses = <Expense>[
  Expense(
    id: '1',
    title: 'Suya',
    amount: 2500,
    category: ExpenseCategory.food,
    date: DateTime.now(),
  ),
  Expense(
    id: '2',
    title: 'Bolt to work',
    amount: 3200,
    category: ExpenseCategory.transport,
    date: DateTime.now().subtract(const Duration(days: 1)),
  ),
  Expense(
    id: '3',
    title: 'MTN data bundle',
    amount: 5000,
    category: ExpenseCategory.data,
    date: DateTime.now().subtract(const Duration(days: 2)),
  ),
  Expense(
    id: '4',
    title: 'NEPA bill',
    amount: 12000,
    category: ExpenseCategory.bills,
    date: DateTime.now().subtract(const Duration(days: 3)),
  ),
  Expense(
    id: '5',
    title: 'Jollof rice and chicken',
    amount: 4500,
    category: ExpenseCategory.food,
    date: DateTime.now().subtract(const Duration(days: 4)),
  ),
  Expense(
    id: '6',
    title: 'Keke to the market',
    amount: 800,
    category: ExpenseCategory.transport,
    date: DateTime.now().subtract(const Duration(days: 5)),
  ),
];
