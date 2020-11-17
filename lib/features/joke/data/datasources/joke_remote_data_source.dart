import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:myapp/core/error/exception.dart';

import 'package:myapp/features/joke/data/models/joke_model.dart';

abstract class JokeRemoteDataSource {
  Future<JokeModel> getRandomJoke();
}

class JokeRemoteDataSourceImpl implements JokeRemoteDataSource {
  final http.Client client;

  JokeRemoteDataSourceImpl({@required this.client});

  @override
  Future<JokeModel> getRandomJoke() =>
      _getJokeFromUrl('https://official-joke-api.appspot.com/random_joke');

  Future<JokeModel> _getJokeFromUrl(String url) async {
    final response = await client.get(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return JokeModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
