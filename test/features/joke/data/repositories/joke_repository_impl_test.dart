import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:myapp/core/error/exception.dart';
import 'package:myapp/core/error/failures.dart';
import 'package:myapp/core/platform/network_info.dart';
import 'package:myapp/features/joke/data/datasources/joke_local_data_source.dart';
import 'package:myapp/features/joke/data/datasources/joke_remote_data_source.dart';
import 'package:myapp/features/joke/data/models/joke_model.dart';
import 'package:myapp/features/joke/data/repositories/joke_repository_impl.dart';
import 'package:myapp/features/joke/domain/entities/joke.dart';

class MockRemoteDataSource extends Mock implements JokeRemoteDataSource {}

class MockLocalDataSource extends Mock implements JokeLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  JokeRepositoryImpl repository;
  MockRemoteDataSource mockRemoteDataSource;
  MockLocalDataSource mockLocalDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = JokeRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  group('getRandomJoke', () {
    final tJokeModel = JokeModel(
        setup: "What's the best thing about a Boolean?",
        punchline: "Even if you're wrong, you're only off by a bit.");
    final Joke tJoke = tJokeModel;

    test('should check if the device is online', () {
      //arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      // act
      repository.getRandomJoke();
      // assert
      verify(mockNetworkInfo.isConnected);
    });

    group('device is online', () {
      // This setUp applies only to the 'device is online' group
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test(
        'should return remote data when the call to remote data source is successful',
        () async {
          // arrange
          when(mockRemoteDataSource.getRandomJoke())
              .thenAnswer((_) async => tJokeModel);
          // act
          final result = await repository.getRandomJoke();
          // assert
          verify(mockRemoteDataSource.getRandomJoke());
          expect(result, equals(Right(tJoke)));
        },
      );

      test(
        'should cache the data locally when the call to remote data source is successful',
        () async {
          // arrange
          when(mockRemoteDataSource.getRandomJoke())
              .thenAnswer((_) async => tJokeModel);
          // act
          await repository.getRandomJoke();
          // assert
          verify(mockRemoteDataSource.getRandomJoke());
          verify(mockLocalDataSource.cacheJokeModel(tJoke));
        },
      );

      test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(mockRemoteDataSource.getRandomJoke())
              .thenThrow(ServerException());
          // act
          final result = await repository.getRandomJoke();
          // assert
          verify(mockRemoteDataSource.getRandomJoke());
          verifyZeroInteractions(mockLocalDataSource);
          expect(result, equals(Left(ServerFailure())));
        },
      );
    });

    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test(
        'should return last locally cached data when the cached data is present',
        () async {
          // arrange
          when(mockLocalDataSource.getLastJoke())
              .thenAnswer((_) async => tJokeModel);
          // act
          final result = await repository.getRandomJoke();

          // assert
          verifyZeroInteractions(mockRemoteDataSource);
          verify(mockLocalDataSource.getLastJoke());
          expect(result, equals(Right(tJoke)));
        },
      );

      test(
        'should return CacheFailure when there is no cached data present',
        () async {
          // arrange
          when(mockLocalDataSource.getLastJoke()).thenThrow(CacheException());
          // act
          final result = await repository.getRandomJoke();
          // assert
          verifyZeroInteractions(mockRemoteDataSource);
          verify(mockLocalDataSource.getLastJoke());
          expect(result, equals(Left(CacheFailure())));
        },
      );
    });
  });
}
