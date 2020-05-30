import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:numbertrivia/core/network/network_info.dart';

class MockDataConnectorChecker extends Mock implements DataConnectionChecker {}

void main() {
  NetworkInfoImpl networkInfoImpl;
  MockDataConnectorChecker mockDataConnectorChecker;


  setUp(() {
    mockDataConnectorChecker = MockDataConnectorChecker();
    networkInfoImpl = NetworkInfoImpl(mockDataConnectorChecker);
  });

  group('isConnected', () {
    test('should forward call to to DataConnectionChecker.hasConnection',  () async {
      // Ensure that the call has really been forwarded, not passed value directly
      final tHasConnectionFuture = Future.value(true);

      when(mockDataConnectorChecker.hasConnection).thenAnswer((realInvocation) async => tHasConnectionFuture);

      final result = await networkInfoImpl.isConnected;
      verify(networkInfoImpl.isConnected);
      expect(result, tHasConnectionFuture);

    });
  });

}