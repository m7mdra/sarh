import 'package:Sarh/data/model/activity.dart';

class SubActivityState {}

class Loading extends SubActivityState {}

class NetworkError extends SubActivityState {}

class Empty extends SubActivityState {}

class Success extends SubActivityState {
  final List<Activity> activityList;

  Success(this.activityList);
}

class Error extends SubActivityState {}

class Idle extends SubActivityState {}

class Timeout extends SubActivityState {}
