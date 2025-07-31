




abstract class RegisterViewState{}
class InitializeRegisterViewState extends RegisterViewState{}

class ChangeIconPasswordSuccess extends RegisterViewState{}

class RegisterViewStateLoading extends RegisterViewState{}
class RegisterViewStateSuccess extends RegisterViewState{

  // UserRegisterModel? userRegisterModelModel;
  RegisterViewStateSuccess(
      // this.userRegisterModelModel
      );
}
class RegisterViewStateError extends RegisterViewState{

  final String error;
  RegisterViewStateError(this.error);
}

class otpLoading extends RegisterViewState {}

class otpSuccess extends RegisterViewState {}

class otpError extends RegisterViewState {
  final String message;
  otpError(this.message);
}
