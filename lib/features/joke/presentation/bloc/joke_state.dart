part of 'joke_bloc.dart';

abstract class JokeState extends Equatable {
  const JokeState();

  @override
  List<Object> get props => [];
}

class JokeInitial extends JokeState {}

class Loading extends JokeState {}

class Loaded extends JokeState {
  final Joke joke;

  Loaded({@required this.joke});
}

class Error extends JokeState {
  final String errorMessage;

  Error({@required this.errorMessage});
}
