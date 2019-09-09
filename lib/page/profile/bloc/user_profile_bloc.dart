import 'package:Sarh/data/session.dart';
import 'package:bloc/bloc.dart';
import 'bloc.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  final Session _session;

  UserProfileBloc(this._session);

  @override
  UserProfileState get initialState => ProfileLoaded(_session.user);


  @override
  Stream<UserProfileState> mapEventToState(UserProfileEvent event) async* {
    yield ProfileLoaded(_session.user);
  }


}
