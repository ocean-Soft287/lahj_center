import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lahijcenter/Feature/Home/Data/model/comment_model.dart';
import 'package:lahijcenter/Feature/Home/Data/repo/get_all_comment_repo.dart';
import 'package:lahijcenter/core/bloc/base_state.dart';
class GetAllCommentCubit extends Cubit<BaseState<CommentModel>> {
  final GetAllCommentRepo getAllCommentRepo;

  GetAllCommentCubit(this.getAllCommentRepo)
      : super(const BaseState<CommentModel>());

  Future<void> getComment({
    required int num,
    int pageSize = 50,
    int page = 1,
  }) async {
    emit(state.copyWith(status: Status.loading));

    final response = await getAllCommentRepo.fetchcoomentbyid(
      number: num,
      pagesize: pageSize,
      page: page,
    );

    response.fold(
      (failure) => emit(state.copyWith(
        status: Status.failure,
        errorMessage: failure.message,
        failure: failure,
      )),
      (data) => emit(state.copyWith(
        status: Status.success,
        data: data,
      )),
    );
  }
}
