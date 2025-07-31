part of 'favourite_cubit.dart';

sealed class FavouriteState {}

final class FavouriteInitial extends FavouriteState {}

class AllitemfavouriteFailure extends FavouriteState {}

class Allfavouriteitemsuccful extends FavouriteState {
  final AdvertisementResponse advertisementResponse ;

  Allfavouriteitemsuccful(this.advertisementResponse,);
}

class Allfavouriteitemsuccfulempty extends FavouriteState {}

class Allfavouriteitemsuccfulload extends FavouriteState {}

