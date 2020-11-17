import 'package:flutter_test/flutter_test.dart';
import 'package:myapp/features/joke/data/models/joke_model.dart';
import 'package:myapp/features/joke/domain/entities/joke.dart';

void main() {
  final jokeModel = JokeModel(
      setup: "What's the best thing about a Boolean?",
      punchline: "Even if you're wrong, you're only off by a bit.");

  test(
    'Should be a subclass of Joke Entity',
    () async {
      expect(jokeModel, isA<Joke>());
    },
  );
}
