import 'package:Sarh/data/activity/activity_repository.dart';
import 'package:Sarh/data/exceptions/exceptions.dart';
import 'package:Sarh/page/home/activity/bloc/activity_event.dart';
import 'package:Sarh/page/home/activity/bloc/activity_state.dart';
import 'package:bloc/bloc.dart';

class ActivityBloc extends Bloc<ActivityEvent, ActivityState> {
  final ActivityRepository _repository;

  ActivityBloc(this._repository);

  @override
  ActivityState get initialState => Idle();

  @override
  Stream<ActivityState> mapEventToState(ActivityEvent event) async* {
    if (event is LoadActivities) {
      yield Loading();
      try {
        var response = await _repository.getActivities();
        if (response.success) {
          if (response.activities.isNotEmpty) {
            yield Success(response.activities);
          } else {
            yield Empty();
          }
        } else {
          yield Error();
        }
      } on UnableToConnectException {
        yield NetworkError();
      } on TimeoutException {
        yield Timeout();
      } on SessionExpiredException {
        yield SessionExpired();
      } catch (error) {
        print(error);
        yield Error();
      }
    }
  }
}
