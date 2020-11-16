import 'package:dartz/dartz.dart';
import 'package:myapp/core/error/failures.dart';
import 'package:myapp/features/joke/domain/entities/joke.dart';

abstract class JokeRepository {
  Future<Either<Failure, Joke>> getRandomJoke();
}
