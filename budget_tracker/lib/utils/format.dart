// 1234567 -> 1,234,567
String _withCommas(int number) {
  final digits = number.abs().toString();
  final buffer = StringBuffer();
  for (var i = 0; i < digits.length; i++) {
    // Put a comma before every group of three digits, counting from the end.
    if (i > 0 && (digits.length - i) % 3 == 0) {
      buffer.write(',');
    }
    buffer.write(digits[i]);
  }
  final sign = number < 0 ? '-' : '';
  return '$sign$buffer';
}

// 2500 -> ₦2,500
String formatNaira(int amount) {
  return '₦${_withCommas(amount)}';
}

// 1.6 -> $1.60
String formatDollars(double amount) {
  final cents = (amount * 100).round();
  final dollars = cents ~/ 100;
  final rest = (cents % 100).toString().padLeft(2, '0');
  return '\$${_withCommas(dollars)}.$rest';
}

// 17/10/2026
String formatShortDate(DateTime date) {
  return '${date.day}/${date.month}/${date.year}';
}
