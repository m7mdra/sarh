/*
 * Copyright (c) 2019.
 *           ______             _
 *          |____  |           | |
 *  _ __ ___    / / __ ___   __| |_ __ __ _
 * | '_ ` _ \  / / '_ ` _ \ / _` | '__/ _` |
 * | | | | | |/ /| | | | | | (_| | | | (_| |
 * |_| |_| |_/_/ |_| |_| |_|\__,_|_|  \__,_|
 *
 *
 *
 *
 */

import 'package:Sarh/data/company/company_repository.dart';
import 'package:Sarh/data/exceptions/session_expired_exception.dart';
import 'package:Sarh/data/exceptions/timeout_exception.dart';
import 'package:Sarh/data/exceptions/unable_to_connect_exception.dart';
import 'package:Sarh/data/session.dart';
import 'package:Sarh/data/user/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'add_image_event_state.dart';

class UploadImageBloc extends Bloc<UploadImage, UploadImageState> {
  final CompanyRepository companyRepository;
  UploadImageBloc(this.companyRepository);

  @override
  UploadImageState get initialState => IdleState();

  @override
  Stream<UploadImageState> mapEventToState(UploadImage event) async* {
    if (event is AttemptUpload) {
      yield LoadingState();
      try {
        var response = await companyRepository.uploadCompanyImage(event.image,event.title, event.description);
        if (response.success) {
          yield SuccessState();
        } else {
          yield FaildState();
        }
      } on UnableToConnectException {
        yield NetworkError();
      } on TimeoutException {
        yield Timeout();
      } catch (error) {
        print("Error: $error");
        yield UploadError('Failed to upload, try again');
      }
    }
  }
}
