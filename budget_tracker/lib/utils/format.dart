// 2500 -> ₦2,500
String formatNaira(int amount) {
  final digits = amount.abs().toString();
  final buffer = StringBuffer();
  for (var i = 0; i < digits.length; i++) {
    // Put a comma before every group of three digits, counting from the end.
    if (i > 0 && (digits.length - i) % 3 == 0) {
      buffer.write(',');
    }
    buffer.write(digits[i]);
  }
  final sign = amount < 0 ? '-' : '';
  return '$sign₦$buffer';
}

// 17/10/2026
String formatShortDate(DateTime date) {
  return '${date.day}/${date.month}/${date.year}';
}
