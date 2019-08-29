import 'package:Sarh/data/model/activity.dart';

class ActivityState {}

class Loading extends ActivityState {}

class NetworkError extends ActivityState {}

class Empty extends ActivityState {}

class Success extends ActivityState {
  final List<Activity> activityList;

  Success(this.activityList);
}

class Error extends ActivityState {}

class Idle extends ActivityState {}

class Timeout extends ActivityState {}
class SessionExpired extends ActivityState {}

