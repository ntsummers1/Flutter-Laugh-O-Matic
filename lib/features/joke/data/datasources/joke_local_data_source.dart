import 'package:myapp/features/joke/data/models/joke_model.dart';

abstract class JokeLocalDataSource {
  Future<JokeModel> getLastJoke();

  Future<void> cacheJokeModel(JokeModel joketoCache);
}
