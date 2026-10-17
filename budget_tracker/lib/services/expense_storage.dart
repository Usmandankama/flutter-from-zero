import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/expense.dart';

// Keeps the expenses on the phone as one piece of JSON text.
class ExpenseStorage {
  static const _key = 'expenses';

  Future<List<Expense>> load() async {
    final prefs = await SharedPreferences.getInstance();
    final text = prefs.getString(_key);
    if (text == null) {
      return []; // nothing saved yet: the first time the app runs
    }
    final list = jsonDecode(text) as List<dynamic>;
    return list
        .map((item) => Expense.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<void> save(List<Expense> expenses) async {
    final prefs = await SharedPreferences.getInstance();
    final text = jsonEncode(expenses.map((e) => e.toJson()).toList());
    await prefs.setString(_key, text);
  }
}
