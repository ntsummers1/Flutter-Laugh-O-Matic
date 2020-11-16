import 'package:dartz/dartz.dart';
import 'package:myapp/core/error/failures.dart';
import 'package:myapp/core/usecases/usecase.dart';
import 'package:myapp/features/joke/domain/entities/joke.dart';
import 'package:myapp/features/joke/domain/repositories/joke_repository.dart';

class GetRandomJoke implements UseCase<Joke, NoParams> {
  final JokeRepository repository;

  GetRandomJoke(this.repository);

  @override
  Future<Either<Failure, Joke>> call(NoParams params) async {
    return await repository.getRandomJoke();
  }
}
