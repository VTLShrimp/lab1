String formatPrice(int price) {
  final isNegative = price.isNegative;
  final digits = price.abs().toString();
  final buffer = StringBuffer();

  for (var i = 0; i < digits.length; i++) {
    buffer.write(digits[i]);

    final remaining = digits.length - i - 1;
    if (remaining > 0 && remaining % 3 == 0) {
      buffer.write('.');
    }
  }

  return '${isNegative ? '-' : ''}${buffer.toString()} đ';
}
