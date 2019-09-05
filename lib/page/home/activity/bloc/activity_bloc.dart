import 'package:Sarh/data/activity/activity_repository.dart';
import 'package:Sarh/data/exceptions/exceptions.dart';
import 'package:Sarh/page/home/activity/bloc/activity_event.dart';
import 'package:Sarh/page/home/activity/bloc/activity_state.dart';
import 'package:bloc/bloc.dart';

class ActivityBloc extends Bloc<ActivityEvent, ActivityState> {
  final ActivityRepository _repository;

  ActivityBloc(this._repository);

  @override
  ActivityState get initialState => ActivityIdle();

  @override
  Stream<ActivityState> mapEventToState(ActivityEvent event) async* {
    if (event is LoadActivities) {
      yield ActivityLoading();
      try {
        var response = await _repository.getActivities();
        if (response.success) {
          if (response.activities.isNotEmpty) {
            yield ActivitySuccess(response.activities);
          } else {
            yield ActivityEmpty();
          }
        } else {
          yield ActivityError();
        }
      } on UnableToConnectException {
        yield ActivityNetworkError();
      } on TimeoutException {
        yield ActivityTimeout();
      } on SessionExpiredException {
        yield ActivitySessionExpired();
      } catch (error) {
        print(error);
        yield ActivityError();
      }
    }
  }
}
