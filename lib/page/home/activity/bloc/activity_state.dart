import 'package:Sarh/data/model/activity.dart';

class ActivityState {}

class ActivityLoading extends ActivityState {}

class ActivityNetworkError extends ActivityState {}

class ActivityEmpty extends ActivityState {}

class ActivitySuccess extends ActivityState {
  final List<Activity> activityList;

  ActivitySuccess(this.activityList);
}

class ActivityError extends ActivityState {}

class ActivityIdle extends ActivityState {}

class ActivityTimeout extends ActivityState {}

class ActivitySessionExpired extends ActivityState {}
