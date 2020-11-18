part of 'joke_bloc.dart';

abstract class JokeEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetJokeForBloc extends JokeEvent {}
