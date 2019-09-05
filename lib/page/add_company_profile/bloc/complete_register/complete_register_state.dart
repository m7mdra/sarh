class CompleteRegisterState {}

class RegisterLoading extends CompleteRegisterState {}

class RegisterNetworkError extends CompleteRegisterState {}

class RegisterTimeout extends CompleteRegisterState {}

class RegisterSuccess extends CompleteRegisterState {}
class RegisterSessionExpired extends CompleteRegisterState {}

class RegisterFailed extends CompleteRegisterState {}

class RegisterIdle extends CompleteRegisterState {}
