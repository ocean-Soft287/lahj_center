import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lahijcenter/Feature/Home/Data/model/post_model_comment.dart';
import 'package:lahijcenter/Feature/Home/Data/repo/repo_post_comment.dart';
import 'package:lahijcenter/core/bloc/base_state.dart';



class PostCommentCubit extends Cubit<BaseState<CommentItem>> {
  final RepoPostComment repoPostComment;

  PostCommentCubit(this.repoPostComment) : super(const BaseState<CommentItem>());

  Future<void> postComment({
    required int advertisementId,
    required String comment,
  }) async {
    emit(state.copyWith(status: Status.loading));

    final result = await repoPostComment.addcomment(
      advertisementid: advertisementId,
      comment: comment,
    );

    result.fold(
      (failure) {
        emit(state.copyWith(
          status: Status.failure,
          errorMessage: failure.message,
          failure: failure,
        ));
      },
      (commentItem) {
        emit(state.copyWith(
          status: Status.success,
    data: commentItem as CommentItem?, 
        ));
      },
    );
  }
}
