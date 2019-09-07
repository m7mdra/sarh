import 'package:Sarh/data/exceptions/session_expired_exception.dart';
import 'package:Sarh/data/exceptions/timeout_exception.dart';
import 'package:Sarh/data/exceptions/unable_to_connect_exception.dart';
import 'package:Sarh/data/session.dart';
import 'package:Sarh/data/user/user_repository.dart';
import 'package:Sarh/page/profile/bloc/bloc.dart';
import 'package:Sarh/page/profile_image_modify/bloc/modify_profile_image_event.dart';
import 'package:Sarh/page/profile_image_modify/bloc/modify_profile_image_state.dart';
import 'package:bloc/bloc.dart';

class ModifyProfileImageBloc
    extends Bloc<ModifyProfileImageEvent, ModifyProfileImageState> {
  final UserRepository _userRepository;
  final Session _session;


  ModifyProfileImageBloc(this._userRepository, this._session);

  @override
  ModifyProfileImageState get initialState => Idle(_session.user.image);

  @override
  void onError(Object error, StackTrace stacktrace) {
    // TODO: implement onError
    super.onError(error, stacktrace);
    print(error);
    print(stacktrace);
  }

  @override
  Stream<ModifyProfileImageState> mapEventToState(
      ModifyProfileImageEvent event) async* {
    if (event is Load) {
      yield ImageLoaded(_session.user.image);
    }
    if (event is Modify) {
      try {
        yield Loading();
        var response = await _userRepository.uploadProfileImage(event.file);
        if (response.success) {
          var profile = await _userRepository.profile();
          await _session.saveUser(profile.token, profile.user, profile.company);

          yield ImageLoaded(_session.user.image);
        } else {
          yield Failed();
        }
      } on SessionExpiredException {
        yield SessionExpired();
      } on TimeoutException {
        yield Failed();
      } on UnableToConnectException {
        yield Failed();
      } catch (error) {
        yield Failed();
        print(error);
      }
    }
  }
}
