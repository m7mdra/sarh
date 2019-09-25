import 'dart:collection';

import 'package:Sarh/data/model/activity.dart';

class ActivityState {}

class ActivityLoadingState extends ActivityState {}

class ActivityEmptyState extends ActivityState {}

class ActivityNetworkErrorState extends ActivityState {}

class ActivitiesLoadedState extends ActivityState {
  final UnmodifiableListView<Activity> activities;

  ActivitiesLoadedState(this.activities);
}

class ActivityTimeoutState extends ActivityState {}

class ActivityErrorState extends ActivityState {}
class HideActivityState extends ActivityState{}
