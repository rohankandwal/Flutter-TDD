import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:numbertrivia/core/error/exceptions.dart';
import 'package:numbertrivia/core/error/failures.dart';
import 'package:numbertrivia/core/network/network_info.dart';
import 'package:numbertrivia/features/number_trivia/data/datasources/number_trivia_local_datasource.dart';
import 'package:numbertrivia/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:numbertrivia/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:numbertrivia/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:numbertrivia/features/number_trivia/domain/entities/number_trivia.dart';

class MockRemoteDataSource extends Mock
    implements NumberTriviaRemoteDataSource {}

class MockLocalDataSource extends Mock implements NumberTriviaLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  NumberTriviaRepositoryImpl repository;
  MockRemoteDataSource mockRemoteDataSource;
  MockLocalDataSource mockLocalDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = NumberTriviaRepositoryImpl(
        remoteDataSource: mockRemoteDataSource,
        localDataSource: mockLocalDataSource,
        networkInfo: mockNetworkInfo);
  });

  void runTestsOnline(Function body) {
    group(
      'device is online',
      () {
        setUp(() {
          when(mockNetworkInfo.isConnected)
              .thenAnswer((realInvocation) async => true);
        });
        body();
      },
    );
  }

  void runTestsOffline(Function body) {
    group(
      'device is offline',
      () {
        setUp(() {
          when(mockNetworkInfo.isConnected)
              .thenAnswer((realInvocation) async => false);
        });
        body();
      },
    );
  }

  group('getConcreteNumberTrivia', () {
    final tNumber = 1;
    final tNumberTriviaModel =
        NumberTriviaModel(number: tNumber, text: "Test Trivia");

    final NumberTrivia tNumberTrivia = tNumberTriviaModel;

    test('should check if the device is online', () async {
      //assert
      when(mockNetworkInfo.isConnected)
          .thenAnswer((realInvocation) async => true);

      // act
      repository.getConcreteNumberTrivia(tNumber);

      // assert
      verify(mockNetworkInfo.isConnected);
    });

    runTestsOnline(() {
      test(
          'should return remote data when the call to remote data source is successful',
          () async {
        // arrange
        when(mockRemoteDataSource.getConcreteNumberTrivia(tNumber))
            .thenAnswer((realInvocation) async => tNumberTriviaModel);

        // act
        final result = await repository.getConcreteNumberTrivia(tNumber);

        // verify
        verify(mockRemoteDataSource.getConcreteNumberTrivia(tNumber));
        expect(result, (Right(tNumberTrivia)));
      });

      test(
          'should cache local data when the call to remote data source is successful',
          () async {
        // arrange
        when(mockRemoteDataSource.getConcreteNumberTrivia(tNumber))
            .thenAnswer((realInvocation) async => tNumberTriviaModel);

        // act
        await repository.getConcreteNumberTrivia(tNumber);

        // verify
        verify(mockRemoteDataSource.getConcreteNumberTrivia(tNumber));
        verify(mockLocalDataSource.cacheNumberTrivia(tNumberTriviaModel));
      });

      test(
          'should throw server exception when the call to remote data source is unsuccessful',
          () async {
        // arrange
        when(mockRemoteDataSource.getConcreteNumberTrivia(tNumber))
            .thenThrow(ServerException());

        // act
        final result = await repository.getConcreteNumberTrivia(tNumber);

        // verify
        verify(mockRemoteDataSource.getConcreteNumberTrivia(tNumber));
        verifyZeroInteractions(mockLocalDataSource);
        expect(result, (Left(ServerFailure())));
      });
    });

    runTestsOffline(() {
      test('should return cache data when cache data is present', () async {
        // arrange
        when(mockLocalDataSource.getLastNumberTrivia())
            .thenAnswer((realInvocation) async => tNumberTriviaModel);

        // act
        final result = await repository.getConcreteNumberTrivia(tNumber);

        // verify
        verify(mockLocalDataSource.getLastNumberTrivia());
        verifyZeroInteractions(mockRemoteDataSource);
        expect(result, (Right(tNumberTrivia)));
      });

      test('should return CacheFailure data when cache data is not present',
          () async {
        // arrange
        when(mockLocalDataSource.getLastNumberTrivia())
            .thenThrow(CacheException());

        // act
        final result = await repository.getConcreteNumberTrivia(tNumber);

        // verify
        verify(mockLocalDataSource.getLastNumberTrivia());
        verifyZeroInteractions(mockRemoteDataSource);
        expect(result, (Left(CacheFailure())));
      });
    });
  });

  group('getRandomTrivia', () {
    final tNumberTriviaModel =
    NumberTriviaModel(number: 123, text: "Test Trivia");

    final NumberTrivia tNumberTrivia = tNumberTriviaModel;

    test('should check if the device is online', () async {
      //assert
      when(mockNetworkInfo.isConnected)
          .thenAnswer((realInvocation) async => true);

      // act
      repository.getRandomNumberTrivia();

      // assert
      verify(mockNetworkInfo.isConnected);
    });

    runTestsOnline(() {
      test(
          'should return remote data when the call to remote data source is successful',
              () async {
            // arrange
            when(mockRemoteDataSource.getRandomNumberTrivia())
                .thenAnswer((realInvocation) async => tNumberTriviaModel);

            // act
            final result = await repository.getRandomNumberTrivia();

            // verify
            verify(mockRemoteDataSource.getRandomNumberTrivia());
            expect(result, (Right(tNumberTrivia)));
          });

      test(
          'should cache local data when the call to remote data source is successful',
              () async {
            // arrange
            when(mockRemoteDataSource.getRandomNumberTrivia())
                .thenAnswer((realInvocation) async => tNumberTriviaModel);

            // act
            await repository.getRandomNumberTrivia();

            // verify
            verify(mockRemoteDataSource.getRandomNumberTrivia());
            verify(mockLocalDataSource.cacheNumberTrivia(tNumberTriviaModel));
          });

      test(
          'should throw server exception when the call to remote data source is unsuccessful',
              () async {
            // arrange
            when(mockRemoteDataSource.getRandomNumberTrivia())
                .thenThrow(ServerException());

            // act
            final result = await repository.getRandomNumberTrivia();

            // verify
            verify(mockRemoteDataSource.getRandomNumberTrivia());
            verifyZeroInteractions(mockLocalDataSource);
            expect(result, (Left(ServerFailure())));
          });
    });

    runTestsOffline(() {
      test('should return cache data when cache data is present', () async {
        // arrange
        when(mockLocalDataSource.getLastNumberTrivia())
            .thenAnswer((realInvocation) async => tNumberTriviaModel);

        // act
        final result = await repository.getRandomNumberTrivia();

        // verify
        verify(mockLocalDataSource.getLastNumberTrivia());
        verifyZeroInteractions(mockRemoteDataSource);
        expect(result, (Right(tNumberTrivia)));
      });

      test('should return CacheFailure data when cache data is not present',
              () async {
            // arrange
            when(mockLocalDataSource.getLastNumberTrivia())
                .thenThrow(CacheException());

            // act
            final result = await repository.getRandomNumberTrivia();

            // verify
            verify(mockLocalDataSource.getLastNumberTrivia());
            verifyZeroInteractions(mockRemoteDataSource);
            expect(result, (Left(CacheFailure())));
          });
    });
  });
}
