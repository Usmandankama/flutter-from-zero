import 'package:flutter/foundation.dart';

import '../models/expense.dart';
import '../services/expense_storage.dart';

// One place that owns the expenses. Any screen can read it, and when it
// changes, notifyListeners() tells every screen that's watching to rebuild.
class ExpenseStore extends ChangeNotifier {
  ExpenseStore(this._storage);

  final ExpenseStorage _storage;
  final List<Expense> _expenses = [];
  bool _isLoading = true;

  bool get isLoading => _isLoading;

  // Screens get a read-only copy, so add and remove are the only ways to
  // change the list, and they always notify the listeners and save.
  List<Expense> get expenses => List.unmodifiable(_expenses);

  Future<void> load() async {
    final saved = await _storage.load();
    _expenses
      ..clear()
      ..addAll(saved);
    _isLoading = false;
    notifyListeners();
  }

  Future<void> add(Expense expense) async {
    _expenses.insert(0, expense); // newest first
    notifyListeners(); // update the screen straight away...
    await _storage.save(_expenses); // ...then save to the phone
  }

  Future<void> remove(String id) async {
    _expenses.removeWhere((e) => e.id == id);
    notifyListeners();
    await _storage.save(_expenses);
  }
}
