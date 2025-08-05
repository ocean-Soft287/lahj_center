import 'package:lahijcenter/Feature/profile/data/models/new_password_model.dart';

abstract class NewpasswordState {}

class NewpasswordInitial extends NewpasswordState {}

class NewpasswordLoading extends NewpasswordState {}

class NewpasswordSuccess extends NewpasswordState {
  final NewPasswordModel model;

  NewpasswordSuccess({required this.model});
}

class NewpasswordError extends NewpasswordState {
  final String message;

  NewpasswordError({required this.message});
}
