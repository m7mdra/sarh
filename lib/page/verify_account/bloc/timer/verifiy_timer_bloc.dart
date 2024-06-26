/*
 * Copyright (c) 2019.
 *           ______             _
 *          |____  |           | |
 *  _ __ ___    / / __ ___   __| |_ __ __ _
 * | '_ ` _ \  / / '_ ` _ \ / _` | '__/ _` |
 * | | | | | |/ /| | | | | | (_| | | | (_| |
 * |_| |_| |_/_/ |_| |_| |_|\__,_|_|  \__,_|
 *
 *
 *
 *
 */

import 'dart:async';

import 'package:Sarh/page/verify_account/bloc/timer/ticker.dart';
import 'package:Sarh/page/verify_account/bloc/timer/timer_event.dart';
import 'package:Sarh/page/verify_account/bloc/timer/timer_state.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  final Ticker _ticker;
  final int _duration = 60;

  StreamSubscription<int> _tickerSubscription;

  TimerBloc({@required Ticker ticker})
      : assert(ticker != null),
        _ticker = ticker;

  @override
  TimerState get initialState => Ready(_duration);

  @override
  void dispose() {
    super.dispose();
    _tickerSubscription.cancel();
  }

  @override
  Stream<TimerState> mapEventToState(
    TimerEvent event,
  ) async* {
    if (event is Start) {
      yield Running(event.duration);
      _tickerSubscription?.cancel();
      _tickerSubscription = _ticker.tick(ticks: event.duration).listen(
        (duration) {
          dispatch(Tick(duration: duration));
        },
      );
    }
    if (event is Tick) {
      yield event.duration > 0 ? Running(event.duration) : Finished();
    }
    if (event is Reset) {
      _tickerSubscription?.cancel();
      yield Ready(_duration);
    }
  }
}
