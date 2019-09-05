import 'package:Sarh/data/exceptions/session_expired_exception.dart';
import 'package:Sarh/data/exceptions/timeout_exception.dart';
import 'package:Sarh/data/exceptions/unable_to_connect_exception.dart';
import 'package:Sarh/data/session.dart';
import 'package:Sarh/data/user/user_repository.dart';
import 'package:Sarh/page/profile_image_modify/bloc/modify_profile_image_event.dart';
import 'package:Sarh/page/profile_image_modify/bloc/modify_profile_image_state.dart';
import 'package:bloc/bloc.dart';

class ModifyProfileImageBloc
    extends Bloc<ModifyProfileImageEvent, ModifyProfileImageState> {
  final UserRepository userRepository;
  final Session session;

  ModifyProfileImageBloc(this.userRepository, this.session);

  @override
  ModifyProfileImageState get initialState => Idle();

  @override
  Stream<ModifyProfileImageState> mapEventToState(
      ModifyProfileImageEvent event) async* {
    if (event is Load) {
      yield ImageLoaded(session.user.image);
    }
    if (event is Modify) {
      try {
        var response = await userRepository.uploadProfileImage(event.file);
        print(response.data);
      } on SessionExpiredException {
        yield SessionExpired();
      } on TimeoutException {} on UnableToConnectException {} catch (error) {}
    }
  }
}
