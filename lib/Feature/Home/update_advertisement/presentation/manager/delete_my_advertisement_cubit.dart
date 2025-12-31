import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lahijcenter/Feature/Home/update_advertisement/data/repo/delete_my_advertisement_repo.dart';
import 'package:lahijcenter/core/bloc/base_state.dart';

class DeleteMyAdvertisementCubit  extends Cubit<BaseState<String>> {
  final DeleteMyAdvertisementRepo deleteMyAdvertisementRepo;

  DeleteMyAdvertisementCubit(this.deleteMyAdvertisementRepo)
      : super(BaseState());

  Future<void> deleteMyAdvertisement({
    required int id,
    required String deletionReason,
  }) async {
    emit(state.copyWith(status: Status.loading));
   
    final result = await deleteMyAdvertisementRepo.deleteMyAdvertisement(
      id: id,
      deletionReason: deletionReason,
    );
    result.fold(
      (failure) => emit(state.copyWith(status: Status.failure)),
      (success) => emit(state.copyWith(status: Status.success),
    ));
  }
}


