import 'package:flutter/cupertino.dart';
import 'package:myapp/features/joke/domain/entities/joke.dart';

class JokeModel extends Joke {
  JokeModel({
    @required String setup,
    @required String punchline,
  }) : super(setup: setup, punchline: punchline);
}