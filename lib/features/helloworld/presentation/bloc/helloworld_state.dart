part of 'helloworld_bloc.dart';

abstract class HelloworldState extends Equatable {
  const HelloworldState();
  
  @override
  List<Object> get props => [];
}

class HelloworldInitial extends HelloworldState {}
