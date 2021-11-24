import 'package:core/core.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'network_info_test.mocks.dart';

@GenerateMocks([DataConnectionChecker])
void main() {
  late MockDataConnectionChecker mockDataConnectionChecker;
  late NetworkInfo networkInfo;

  setUp(() {
    mockDataConnectionChecker = MockDataConnectionChecker();
    networkInfo = NetworkInfoImpl(mockDataConnectionChecker);
  });

  group('network info', () {
    test('should return true when device connected to internet', () async {
      // arrange
      when(mockDataConnectionChecker.hasConnection)
          .thenAnswer((_) async => true);
      // act
      final result = await networkInfo.isConnected;
      // assert
      expect(result, true);
    });

    test('should return false when device connected to internet', () async {
      // arrange
      when(mockDataConnectionChecker.hasConnection)
          .thenAnswer((_) async => false);
      // act
      final result = await networkInfo.isConnected;
      // assert
      expect(result, false);
    });
  });
}
