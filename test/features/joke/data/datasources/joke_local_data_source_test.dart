import 'dart:convert';

import 'package:myapp/core/error/exception.dart';
import 'package:myapp/features/joke/data/datasources/joke_local_data_source.dart';
import 'package:myapp/features/joke/data/models/joke_model.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:matcher/matcher.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  JokeLocalDataSourceImpl dataSource;
  MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = JokeLocalDataSourceImpl(
      sharedPreferences: mockSharedPreferences,
    );
  });

  group('getLastNumberTrivia', () {
    final tJokeModel =
        JokeModel.fromJson(json.decode(fixture('joke_cached.json')));

    test(
      'should return Joke from SharedPreferences when there is one in the cache',
      () async {
        // arrange
        when(mockSharedPreferences.getString(any))
            .thenReturn(fixture('joke_cached.json'));
        // act
        final result = await dataSource.getLastJoke();
        // assert
        verify(mockSharedPreferences.getString(CACHED_JOKE));
        expect(result, equals(tJokeModel));
      },
    );

    test(
      'should throw a CacheExeption when there is not a cached value',
      () async {
        // arrange
        when(mockSharedPreferences.getString(any)).thenReturn(null);
        // act
        final call = dataSource.getLastJoke;
        // assert
        expect(() => call(), throwsA(TypeMatcher<CacheException>()));
      },
    );
  });

  group('cacheNumberTrivia', () {
    final tJokeModel = JokeModel(
        setup: "What's the best thing about a Boolean?",
        punchline: "Even if you're wrong, you're only off by a bit.");

    test(
      'should call SharedPreferences to cache the data',
      () async {
        // act
        dataSource.cacheJokeModel(tJokeModel);
        // assert
        final expectedJsonString = json.encode(tJokeModel.toJson());
        verify(mockSharedPreferences.setString(
          CACHED_JOKE,
          expectedJsonString,
        ));
      },
    );
  });
}
