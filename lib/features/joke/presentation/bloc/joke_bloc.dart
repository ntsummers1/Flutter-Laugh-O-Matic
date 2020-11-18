import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:myapp/core/error/failures.dart';
import 'package:myapp/core/usecases/usecase.dart';
import 'package:myapp/features/joke/domain/entities/joke.dart';
import 'package:myapp/features/joke/domain/usecases/get_random_joke.dart';

part 'joke_event.dart';
part 'joke_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';

class JokeBloc extends Bloc<JokeEvent, JokeState> {
  final GetRandomJoke getRandomJoke;

  JokeBloc({
    @required GetRandomJoke randomJoke,
  })  : assert(randomJoke != null),
        getRandomJoke = randomJoke,
        super(JokeInitial());

  @override
  Stream<JokeState> mapEventToState(
    JokeEvent event,
  ) async* {
    yield Loading();
    final failureOrJoke = await getRandomJoke(NoParams());
    yield* _eitherLoadedOrErrorState(failureOrJoke);
  }

  Stream<JokeState> _eitherLoadedOrErrorState(
    Either<Failure, Joke> failureOrJoke,
  ) async* {
    yield failureOrJoke.fold(
      (failure) => Error(errorMessage: _mapFailureToMessage(failure)),
      (joke) => Loaded(joke: joke),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected error';
    }
  }
}
