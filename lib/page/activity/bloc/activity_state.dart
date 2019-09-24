import 'dart:collection';

import 'package:Sarh/data/model/activity.dart';

class ActivityState {}

class LoadingState extends ActivityState {}

class EmptyState extends ActivityState {}

class NetworkErrorState extends ActivityState {}

class ActivitiesLoadedState extends ActivityState {
  final UnmodifiableListView<Activity> activities;

  ActivitiesLoadedState(this.activities);
}

class TimeoutState extends ActivityState {}

class ErrorState extends ActivityState {}
