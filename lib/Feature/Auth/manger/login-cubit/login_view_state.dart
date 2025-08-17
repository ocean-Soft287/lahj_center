import 'package:lahijcenter/Feature/Auth/Data/model/user_model.dart';

import '../../../../core/Failure/failure.dart';

abstract class LoginViewState {}

class InitializeLoginViewState extends LoginViewState{}

class LoginViewStateLoading extends LoginViewState{}
class LoginViewStateSuccess extends LoginViewState{
  UserModel dataUser;
LoginViewStateSuccess(this.dataUser);
}
class LoginViewStateError extends LoginViewState{
  final Failure failure;
  final String error;
  LoginViewStateError(this.error,this.failure);
}
class ChangeIconPasswordSuccess extends LoginViewState{}




class AuthGoogleLoading extends LoginViewState{}

class AuthGoogleSuccess extends LoginViewState{
  final dynamic userGoogle;

  AuthGoogleSuccess(this.userGoogle);
}

class AuthGoogleFailure extends LoginViewState{
  final String error;

  AuthGoogleFailure(this.error);
}
class LoginViewStateSuccessMessage extends LoginViewState {
  final String message;
  LoginViewStateSuccessMessage(this.message);
}
class Faliuremobilephone extends LoginViewState {
  final String message;

  Faliuremobilephone(this.message);
}

class Forgetandchangepassfailed extends LoginViewState{
  final String message;

  Forgetandchangepassfailed({required this.message});


}
class ForgetandchangepassSuccessMessage extends LoginViewState {
  final String message;

  ForgetandchangepassSuccessMessage({required this.message});
}
class ForgetpasswordLoading extends LoginViewState{}