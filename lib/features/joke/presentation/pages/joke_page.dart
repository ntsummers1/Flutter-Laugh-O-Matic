import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/features/joke/presentation/bloc/joke_bloc.dart';
import 'package:myapp/injection_container.dart';
import 'package:myapp/features/joke/presentation/widgets/widgets.dart';

class JokePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Joke Generator'),
      ),
      body: SingleChildScrollView(
        child: buildBody(context),
      ),
    );
  }

  BlocProvider<JokeBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<JokeBloc>(),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              SizedBox(height: 10),
              // Top half
              BlocBuilder<JokeBloc, JokeState>(
                builder: (context, state) {
                  if (state is JokeInitial) {
                    return MessageDisplay(
                      message: 'Start Laughing!',
                    );
                  } else if (state is Loading) {
                    return LoadingWidget();
                  } else if (state is Loaded) {
                    return JokeDisplay(joke: state.joke);
                  } else if (state is Error) {
                    return MessageDisplay(
                      message: state.errorMessage,
                    );
                  }
                },
              ),
              SizedBox(height: 20),
              // Bottom half
              JokeControls()
            ],
          ),
        ),
      ),
    );
  }
}
