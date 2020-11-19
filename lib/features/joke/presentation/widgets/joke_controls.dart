import 'package:auto_route/auto_route.dart';
import 'package:myapp/features/joke/presentation/bloc/joke_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class JokeControls extends StatefulWidget {
  const JokeControls({
    Key key,
  }) : super(key: key);

  @override
  _JokeControlsState createState() => _JokeControlsState();
}

class _JokeControlsState extends State<JokeControls> {
  final controller = TextEditingController();
  String inputStr;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            SizedBox(width: 10),
            Expanded(
              child: RaisedButton(
                child: Text('Get random joke'),
                onPressed: dispatchRandom,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: RaisedButton(
                child: Text('Next Page'),
                onPressed: navigateToHelloWorld,
              ),
            ),
          ],
        )
      ],
    );
  }

  void dispatchRandom() {
    controller.clear();
    BlocProvider.of<JokeBloc>(context).add(GetJokeForBloc());
  }

  void navigateToHelloWorld() {
    controller.clear();
    ExtendedNavigator.of(context).push("/hello-world-page");
  }
}
