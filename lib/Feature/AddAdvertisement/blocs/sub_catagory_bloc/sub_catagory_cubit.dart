import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lahijcenter/Feature/AddAdvertisement/data/model/sub_group_model.dart';
import 'package:lahijcenter/Feature/AddAdvertisement/data/repo/repo.dart';
import 'package:lahijcenter/core/bloc/base_state.dart';

class SubCatagoryCubit extends Cubit<BaseState<SubGroupModel>>{
  final SubGroupRepo subGroupRepo;

  SubCatagoryCubit(this.subGroupRepo) : super(BaseState());

  Future<void> getSubCatagory(int groupId) async {
   
    emit(state.copyWith(status: Status.loading));
    final result = await subGroupRepo.supgroup(groupId: groupId);
    result.fold(
      (left) => emit(
        state.copyWith(status: Status.failure, errorMessage: left.message),
      ),
      (right) => emit(state.copyWith(status: Status.success, items: right)),
    );
  }
}