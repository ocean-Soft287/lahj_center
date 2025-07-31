part of 'item_details_cubit.dart';


sealed class ItemDetailsState {}

final class ItemDetailsInitial extends ItemDetailsState {}

final class ItemDetailsFailure extends ItemDetailsState {}

final class ItemDetailsLoad extends ItemDetailsState {}

final class ItemDetailsEmpty extends ItemDetailsState {}

final class ItemDetailsSuccessful extends ItemDetailsState {
  final Item item;

  ItemDetailsSuccessful({required this.item});
}
