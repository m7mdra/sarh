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

import 'dart:collection';

import 'package:Sarh/data/activity/activity_repository.dart';
import 'package:Sarh/data/exceptions/exceptions.dart';
import 'bloc.dart';
import 'package:bloc/bloc.dart';

class ActivityBloc extends Bloc<ActivityEvent, ActivityState> {
  final ActivityRepository _activityRepository;

  ActivityBloc(this._activityRepository);

  @override
  ActivityState get initialState => ActivityState();
  @override
  void onError(Object error, StackTrace stacktrace) {
    // TODO: implement onError
    super.onError(error, stacktrace);
    print(error);
    print(stacktrace);
  }
  @override
  Stream<ActivityState> mapEventToState(ActivityEvent event) async* {
    if (event is LoadActivitiesFromCategory) {
      yield ActivityLoadingState();
      try {
        var activityResponse = await _activityRepository
            .getActivitiesWithCategory(event.categoryId);
        if (activityResponse.success) {
          var activities = activityResponse.activities;
          if (activities.isNotEmpty) {
            yield ActivitiesLoadedState(UnmodifiableListView(activities));
          } else {
            yield ActivityEmptyState();
          }
        } else {
          yield ActivityErrorState();
        }
      } on TimeoutException {
        yield ActivityTimeoutState();
      } on UnableToConnectException {
        yield ActivityNetworkErrorState();
      } catch (error) {
        print(error);
        yield ActivityErrorState();
      }
    }
    if(event is HideActivities){
      yield HideActivityState();
    }
  }
}
