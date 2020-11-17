import 'package:myapp/features/joke/data/models/joke_model.dart';

abstract class JokeRemoteDataSource {
  Future<JokeModel> getRandomJoke();
}
