import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lahijcenter/Feature/AddAdvertisement/data/model/sub_area_model.dart';
import 'package:lahijcenter/Feature/AddAdvertisement/data/repo/repo.dart';
import 'package:lahijcenter/core/bloc/base_state.dart';

class SubAreaBloc extends Cubit<BaseState<SubAreaModel>> {
  final SubAreaRepo subAreaRepo;

  SubAreaBloc(this.subAreaRepo) : super(BaseState());

  Future<void> getSubArea(int governorateId) async {
    emit(state.copyWith(status: Status.loading));

    final result = await subAreaRepo.subarea(governorateId: governorateId);

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: Status.failure,
          errorMessage: failure.message,
        ),
      ),
      (model) => emit(
        state.copyWith(
          status: Status.success,
          items: model, 
        ),
      ),
    );
  }
}
