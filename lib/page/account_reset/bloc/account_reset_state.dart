class AccountResetState {}

class Loading extends AccountResetState {}

class RequestSuccess extends AccountResetState {
  final String phoneNumber;

  RequestSuccess(this.phoneNumber);
}

class AccountNotFound extends AccountResetState {}

class InvalidPhoneNumber extends AccountResetState {}

class NetworkError extends AccountResetState {}

class Error extends AccountResetState {}

class Timeout extends AccountResetState{}
