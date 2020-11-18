part of 'joke_bloc.dart';

abstract class JokeState extends Equatable {
  const JokeState();
  
  @override
  List<Object> get props => [];
}

class JokeInitial extends JokeState {}
