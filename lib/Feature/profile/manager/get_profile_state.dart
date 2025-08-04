import '../data/models/get_profile_model.dart';

abstract class GetProfileState {}

class GetProfileInitial extends GetProfileState {}

class GetProfileLoading extends GetProfileState {}

class GetProfileSuccess extends GetProfileState {
  final GetProfileModel profile;

  GetProfileSuccess(this.profile);
}

class GetProfileFailure extends GetProfileState {
  final String message;

  GetProfileFailure(this.message);
}

