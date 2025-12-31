


import 'package:lahijcenter/Feature/Home/Data/model/advertismint_response.dart';

abstract class AdvertisementState {}

class AdvertisementInitial extends AdvertisementState {}

class AdvertisementFormUpdated extends AdvertisementState {}

class AdvertisementLoading extends AdvertisementState {}

class AdvertisementSuccess extends AdvertisementState {
  final AdvertisementResponse model;
  AdvertisementSuccess(this.model);
}

class AdvertisementFailure extends AdvertisementState {
  final String error;
  AdvertisementFailure(this.error);
}
