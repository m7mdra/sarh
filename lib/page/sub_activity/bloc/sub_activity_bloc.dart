import 'package:Sarh/data/activity/activity_repository.dart';
import 'package:Sarh/data/exceptions/exceptions.dart';
import 'package:Sarh/page/sub_activity/bloc/sub_activity_event.dart';
import 'package:Sarh/page/sub_activity/bloc/sub_activity_state.dart';
import 'package:bloc/bloc.dart';

class SubActivityBloc extends Bloc<SubActivityEvent, SubActivityState> {
  final ActivityRepository _repository;

  SubActivityBloc(this._repository);

  @override
  SubActivityState get initialState => Idle();

  @override
  Stream<SubActivityState> mapEventToState(SubActivityEvent event) async* {
    if (event is LoadSubActivities) {
      yield Loading();
      try {
        var response = await _repository.getSubActivities(event.parentActivity);
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
      } catch (error) {
        print(error);
        yield Error();
      }
    }
  }
}
