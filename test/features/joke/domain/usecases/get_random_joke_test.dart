import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:myapp/core/usecases/usecase.dart';
import 'package:myapp/features/joke/domain/entities/joke.dart';
import 'package:myapp/features/joke/domain/repositories/joke_repository.dart';
import 'package:myapp/features/joke/domain/usecases/get_random_joke.dart';

class MockJokeRepository extends Mock implements JokeRepository {}

void main() {
  GetRandomJoke usecase;
  MockJokeRepository mockJokeRepository;

  setUp(() {
    mockJokeRepository = MockJokeRepository();
    usecase = GetRandomJoke(mockJokeRepository);
  });

  final tJoke = Joke(
      setup: "What's the best thing about a Boolean?",
      punchline: "Even if you're wrong, you're only off by a bit.");

  test(
    'Should get random joke from the repository',
    () async {
      // arrange
      when(mockJokeRepository.getRandomJoke())
          .thenAnswer((_) async => Right(tJoke));
      // act
      final result = await usecase.call(NoParams());

      // assert
      expect(result, Right(tJoke));
      verify(mockJokeRepository.getRandomJoke());
      verifyNoMoreInteractions(mockJokeRepository);
    },
  );
}
