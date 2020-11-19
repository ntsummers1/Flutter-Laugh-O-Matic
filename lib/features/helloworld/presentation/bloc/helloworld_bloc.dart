import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'helloworld_event.dart';
part 'helloworld_state.dart';

class HelloworldBloc extends Bloc<HelloworldEvent, HelloworldState> {
  HelloworldBloc() : super(HelloworldInitial());

  @override
  Stream<HelloworldState> mapEventToState(
    HelloworldEvent event,
  ) async* {}
}
