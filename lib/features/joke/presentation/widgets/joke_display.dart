import 'package:flutter/material.dart';
import 'package:myapp/features/joke/domain/entities/joke.dart';

class JokeDisplay extends StatelessWidget {
  final Joke joke;

  const JokeDisplay({
    Key key,
    @required this.joke,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      child: Column(
        children: <Widget>[
          Text(
            joke.setup,
            style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                child: Text(
                  joke.punchline,
                  style: TextStyle(fontSize: 25),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
