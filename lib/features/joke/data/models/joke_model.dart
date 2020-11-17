import 'package:flutter/cupertino.dart';
import 'package:myapp/features/joke/domain/entities/joke.dart';

class JokeModel extends Joke {
  JokeModel({
    @required String setup,
    @required String punchline,
  }) : super(setup: setup, punchline: punchline);

  factory JokeModel.fromJson(Map<String, dynamic> json) {
    return JokeModel(setup: json['setup'], punchline: json['punchline']);
  }

  Map<String, dynamic> toJson() {
    return {
      'setup': setup,
      'punchline': setup,
    };
  }
}
