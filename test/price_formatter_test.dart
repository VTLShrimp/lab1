import 'package:flutter_test/flutter_test.dart';

import 'package:lab1/utils/price_formatter.dart';

void main() {
  test('formatPrice groups digits by thousands', () {
    expect(formatPrice(890000), '890.000 đ');
    expect(formatPrice(1290000), '1.290.000 đ');
    expect(formatPrice(2190000), '2.190.000 đ');
  });
}
