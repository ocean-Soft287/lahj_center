import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lahijcenter/Feature/MyFavoriteAds/data/model/unlike_model.dart';
import 'package:lahijcenter/Feature/MyFavoriteAds/data/repo/unlike_repo.dart';
import 'package:lahijcenter/core/bloc/base_state.dart';

class UnlikeCubit extends Cubit<BaseState<UnlikeModel>> {
  final UnlikeRepo unlikeRepo;

  UnlikeCubit(this.unlikeRepo) : super(const BaseState());

  Future<void> unlikeAd(int adId) async {
    emit(state.copyWith(status: Status.loading));

    final result = await unlikeRepo.unlikeAd(adId);

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: Status.failure,
          errorMessage: failure.message,
        ),
      ),
      (success) => emit(
        state.copyWith(
          status: Status.success,
          data: success,
        ),
      ),
    );
  }
}
