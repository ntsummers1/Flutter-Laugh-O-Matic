import 'package:myapp/features/joke/data/models/joke_model.dart';

abstract class JokeRemoteDataSource {
  /// Calls the http://numbersapi.com/random endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<JokeModel> getRandomJoke();
}
