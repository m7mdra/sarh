class SubActivityEvent {}

class LoadSubActivities extends SubActivityEvent {
  final int parentActivity;

  LoadSubActivities(this.parentActivity);
}
