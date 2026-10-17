import '../models/expense.dart';

// Made-up expenses, until we build a form in the next lesson.
final SampleExpense = <Expense>{
  Expense(
    id: '1',
    title: 'Groceries',
    amount: 50,
    date: DateTime.now(),
    category: ExpenseCategory.food,
  ),

  Expense(
    id: '2',
    title: 'Movie Tickets',
    amount: 30,
    date: DateTime.now(),
    category: ExpenseCategory.entertainment,
  ),
  Expense(
    id: '3',
    title: 'Bus Fare',
    amount: 10,
    date: DateTime.now(),
    category: ExpenseCategory.transport,
  ),
};
