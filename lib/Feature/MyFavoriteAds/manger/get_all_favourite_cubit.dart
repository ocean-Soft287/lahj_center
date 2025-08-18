import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lahijcenter/Feature/MyFavoriteAds/data/model/get_all_favourite_model.dart';
import 'package:lahijcenter/Feature/MyFavoriteAds/data/repo/get_all_repo.dart';
import 'package:lahijcenter/core/bloc/base_state.dart';

class GetAllFavouriteCubit extends Cubit<BaseState<GetAllFavourite>> {
  final GetAllFavouriteRepo getAllFavouriteRepo;

  GetAllFavouriteCubit(this.getAllFavouriteRepo) : super(const BaseState());

  Future<void> fetchFavouriteData() async {
    emit(state.copyWith(status: Status.loading));

    final result = await getAllFavouriteRepo.getfavouritedata(
      1,
      50,
    );

    result.fold(
      (failure) => emit(state.copyWith(
        status: Status.failure,
        failure: failure,
        errorMessage: failure.message,
      )),
      (data) => emit(state.copyWith(
        status: Status.success,
        data: data,
      )),
    );
  }
  void removeFromFavourite(int id) {
    final items = state.data!.items.where((item) => item.id != id).toList();
    emit(state.copyWith(data: state.data!.copyWith(items: items)));
  }
}

