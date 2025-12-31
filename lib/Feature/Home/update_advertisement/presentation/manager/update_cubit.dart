import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lahijcenter/Feature/Home/update_advertisement/data/models/advertisement_responce.dart';
import 'package:lahijcenter/Feature/Home/update_advertisement/data/models/update_advertisement_model.dart';
import 'package:lahijcenter/Feature/Home/update_advertisement/data/repo/upadate_advertisment_repo.dart';
import 'package:lahijcenter/core/bloc/base_state.dart';

class UpdateAdvertisementCubit extends Cubit<BaseState<AdvertisementResponseModel>> {
  final AdvertisementRepo _advertisementRepo;

  UpdateAdvertisementCubit(this._advertisementRepo) : super(BaseState ());

  Future<void> submitAd(UpdateAdvertisementModel model) async {
    emit(state.copyWith(
      status: Status.loading,
    ));
    final result = await _advertisementRepo.updateAdvertisement(model);
    result.fold(
      (failure) => emit(state.copyWith(status: Status.failure,)),
      (response) => emit(state.copyWith(status: Status.success, data: response)),
    );
  }
}
