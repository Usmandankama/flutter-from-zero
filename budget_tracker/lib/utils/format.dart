import 'package:intl/intl.dart';

// The intl package already knows how to format money and dates,
// so we don't have to write (and test) that code ourselves.
final _naira = NumberFormat.currency(
  locale: 'en',
  symbol: '₦',
  decimalDigits: 0,
);
final _dollars = NumberFormat.currency(locale: 'en', symbol: '\$');
final _shortDate = DateFormat('d MMM');
final _longDate = DateFormat('EEEE d MMMM y, h:mm a');

// 2500 -> ₦2,500
String formatNaira(int amount) => _naira.format(amount);

// 1.6 -> $1.60
String formatDollars(double amount) => _dollars.format(amount);

// 17 Oct
String formatShortDate(DateTime date) => _shortDate.format(date);

// Saturday 17 October 2026, 1:45 PM
String formatLongDate(DateTime date) => _longDate.format(date);
