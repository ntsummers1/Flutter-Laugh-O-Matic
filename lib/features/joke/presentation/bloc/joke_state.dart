part of 'joke_bloc.dart';

@immutable
abstract class JokeState extends Equatable {
  @override
  List<Object> get props => [];
}

class JokeInitial extends JokeState {}

class Loading extends JokeState {}

class Loaded extends JokeState {
  final Joke joke;

  Loaded({@required this.joke});

  @override
  List<Object> get props => [joke];
}

class Error extends JokeState {
  final String errorMessage;

  Error({@required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
