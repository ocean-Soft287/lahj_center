

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lahijcenter/Feature/MyFavoriteAds/data/model/post_like_model.dart';
import 'package:lahijcenter/Feature/MyFavoriteAds/data/repo/post_like_repo.dart';
import 'package:lahijcenter/core/bloc/base_state.dart';

class PostLikeCubit extends Cubit<BaseState<PostLikeModel>> {
  final PostLikeRepo postLikeRepo;

  PostLikeCubit(this.postLikeRepo) : super(const BaseState());

  Future<void> postLike(int id) async {
    emit(state.copyWith(status: Status.loading));

    final result = await postLikeRepo.postlike(id);

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
        ),
      ),
    );
  }
}
