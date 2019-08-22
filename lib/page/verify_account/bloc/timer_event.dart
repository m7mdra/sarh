import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
@immutable
abstract class TimerEvent extends Equatable {
  TimerEvent([List props = const []]) : super(props);
}

class Start extends TimerEvent {
  final int duration;

  Start({ this.duration=5}) : super([duration]);

  @override
  String toString() => "Start { duration: $duration }";
}


class Reset extends TimerEvent {
  @override
  String toString() => "Reset";
}

class Tick extends TimerEvent {
  final int duration;

  Tick({@required this.duration}) : super([duration]);

  @override
  String toString() => "Tick { duration: $duration }";
}