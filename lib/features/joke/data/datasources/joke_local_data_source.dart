import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:myapp/core/error/exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:myapp/features/joke/data/models/joke_model.dart';

abstract class JokeLocalDataSource {
  Future<JokeModel> getLastJoke();

  Future<void> cacheJokeModel(JokeModel joketoCache);
}

const CACHED_JOKE = 'CACHED_JOKE';

class JokeLocalDataSourceImpl implements JokeLocalDataSource {
  final SharedPreferences sharedPreferences;

  JokeLocalDataSourceImpl({@required this.sharedPreferences});

  @override
  Future<JokeModel> getLastJoke() {
    final jsonString = sharedPreferences.getString(CACHED_JOKE);
    if (jsonString != null) {
      return Future.value(JokeModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheJokeModel(JokeModel joketoCache) {
    return sharedPreferences.setString(
      CACHED_JOKE,
      json.encode(joketoCache.toJson()),
    );
  }
}
