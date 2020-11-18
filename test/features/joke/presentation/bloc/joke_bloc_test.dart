import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:myapp/core/error/failures.dart';
import 'package:myapp/core/usecases/usecase.dart';
import 'package:myapp/features/joke/domain/entities/joke.dart';
import 'package:myapp/features/joke/domain/usecases/get_random_joke.dart';
import 'package:myapp/features/joke/presentation/bloc/joke_bloc.dart';

class MockGetRandomJoke extends Mock implements GetRandomJoke {}

void main() {
  JokeBloc bloc;
  MockGetRandomJoke mockGetRandomJoke;

  setUp(() {
    mockGetRandomJoke = MockGetRandomJoke();

    bloc = JokeBloc(
      randomJoke: mockGetRandomJoke,
    );
  });

  test('initialState should be JokeInitial', () {
    // assert
    expect(bloc.state, equals(JokeInitial()));
  });

  group('GetRandomJoke', () {
    final tJoke = Joke(
        setup: "What's the best thing about a Boolean?",
        punchline: "Even if you're wrong, you're only off by a bit.");

    test(
      'should get data from the random use case',
      () async {
        // arrange
        when(mockGetRandomJoke(any)).thenAnswer((_) async => Right(tJoke));
        // act
        bloc.add(GetJokeForBloc());
        await untilCalled(mockGetRandomJoke(any));
        // assert
        verify(mockGetRandomJoke(NoParams()));
      },
    );

    test(
      'should emit [Loading, Loaded] when data is gotten successfully',
      () async {
        // arrange
        when(mockGetRandomJoke(any)).thenAnswer((_) async => Right(tJoke));
        // assert later
        final expected = [
          Loading(),
          Loaded(joke: tJoke),
        ];
        expectLater(bloc, emitsInOrder(expected));
        // act
        bloc.add(GetJokeForBloc());
      },
    );

    test(
      'should emit [Loading, Error] when getting data fails',
      () async {
        // arrange
        when(mockGetRandomJoke(any))
            .thenAnswer((_) async => Left(ServerFailure()));
        // assert later
        final expected = [
          Loading(),
          Error(errorMessage: SERVER_FAILURE_MESSAGE),
        ];
        expectLater(bloc, emitsInOrder(expected));
        // act
        bloc.add(GetJokeForBloc());
      },
    );

    test(
      'should emit [Loading, Error] with a proper message for the error when getting data fails',
      () async {
        // arrange
        when(mockGetRandomJoke(any))
            .thenAnswer((_) async => Left(CacheFailure()));
        // assert later
        final expected = [
          Loading(),
          Error(errorMessage: CACHE_FAILURE_MESSAGE),
        ];
        expectLater(bloc, emitsInOrder(expected));
        // act
        bloc.add(GetJokeForBloc());
      },
    );
  });
}
