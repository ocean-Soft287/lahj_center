part of 'category_cubit.dart';


sealed class CategoryState {}

final class CategoryInitial extends CategoryState {}

class Allitemload extends CategoryState {}

class Allitemsuccful extends CategoryState {
  final AdvertisementResponse item;
  Allitemsuccful({required this.item});
}

class AllitemFailure extends CategoryState {
  final String error;
  AllitemFailure(this.error);
}

class Groupload extends CategoryState {}

class Groupsuccful extends CategoryState {
  final AdvertisementResponse item;
  Groupsuccful({required this.item});
}

class GroupitemFailure extends CategoryState {
  final String error;
  GroupitemFailure({required this.error});
}
