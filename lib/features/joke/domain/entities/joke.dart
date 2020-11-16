import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Joke extends Equatable {
  final String setup;
  final String punchline;

  Joke({@required this.setup, @required this.punchline});

  @override
  List<Object> get props => [setup, punchline];
}
