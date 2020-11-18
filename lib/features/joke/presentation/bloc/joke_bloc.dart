import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:myapp/features/joke/domain/entities/joke.dart';

part 'joke_event.dart';
part 'joke_state.dart';

class JokeBloc extends Bloc<JokeEvent, JokeState> {
  @override
  Stream<JokeState> mapEventToState(
    JokeEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }

  @override
  JokeState get initialState => JokeInitial();
}
