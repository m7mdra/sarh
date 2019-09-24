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
      yield LoadingState();
      try {
        var activityResponse = await _activityRepository
            .getActivitiesWithCategory(event.categoryId);
        if (activityResponse.success) {
          var activities = activityResponse.activities;
          if (activities.isNotEmpty) {
            yield ActivitiesLoadedState(UnmodifiableListView(activities));
          } else {
            yield EmptyState();
          }
        } else {
          yield ErrorState();
        }
      } on TimeoutException {
        yield TimeoutState();
      } on UnableToConnectException {
        yield NetworkErrorState();
      } catch (error) {
        print(error);
        yield ErrorState();
      }
    }
  }
}
