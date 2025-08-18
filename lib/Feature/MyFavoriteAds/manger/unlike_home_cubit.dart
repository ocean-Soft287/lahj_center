import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lahijcenter/Feature/MyFavoriteAds/data/model/unlike_home.dart';
import 'package:lahijcenter/Feature/MyFavoriteAds/data/repo/unlike_home_repo.dart';
import 'package:lahijcenter/core/bloc/base_state.dart';

class UnlikeHomeCubit extends Cubit<BaseState<UnlikeHome>> {
  final UnlikeHomeRepo unlikeHomeRepo;

  UnlikeHomeCubit(this.unlikeHomeRepo) : super(const BaseState());

  Future<void> unlikeHome(int id) async {
    emit(state.copyWith(status: Status.loading));

    final result = await unlikeHomeRepo.unlikeHome(id);

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
