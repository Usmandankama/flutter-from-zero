import 'package:flutter/foundation.dart';

import '../models/expense.dart';

// One place that owns the expenses. Any screen can read it, and when it
// changes, notifyListeners() tells every screen that's watching to rebuild.
class ExpenseStore extends ChangeNotifier {
  ExpenseStore(List<Expense> initial) : _expenses = [...initial];

  final List<Expense> _expenses;

  // Screens get a read-only copy, so add and remove are the only ways to
  // change the list, and they always notify the listeners.
  List<Expense> get expenses => List.unmodifiable(_expenses);

  void add(Expense expense) {
    _expenses.insert(0, expense); // newest first
    notifyListeners();
  }

  void remove(String id) {
    _expenses.removeWhere((e) => e.id == id);
    notifyListeners();
  }
}
