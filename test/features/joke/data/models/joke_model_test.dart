import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:myapp/features/joke/data/models/joke_model.dart';
import 'package:myapp/features/joke/domain/entities/joke.dart';

import '../../../../core/fixtures/fixture_reader.dart';

void main() {
  final tJokeModel = JokeModel(
      setup: "What's the best thing about a Boolean?",
      punchline: "Even if you're wrong, you're only off by a bit.");

  test(
    'Should be a subclass of Joke Entity',
    () async {
      expect(tJokeModel, isA<Joke>());
    },
  );

  group('fromJson', () {
    test('Should return a valid model of Joke from JSON', () async {
      final Map<String, dynamic> jsonMap = json.decode(fixture('json.dart'));

      final result = JokeModel.fromJson(jsonMap);

      expect(result, tJokeModel);
    });
  });
}
