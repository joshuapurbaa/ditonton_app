import 'package:flutter_test/flutter_test.dart';

void main() {
  int i = 0;
  test('Main Test', () async {
    i = i + 1;
    expect(i, 1);
  });
}
