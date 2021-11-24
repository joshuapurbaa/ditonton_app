import 'package:core/utils/encrypt.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('should return base64(String) when encrypted string ', () {
    final password = '@thejokratt136';

    final encrypted = encrypts(password);

    expect(encrypted, isA<String>());
  });
}
