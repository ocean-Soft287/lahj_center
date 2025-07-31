
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lahijcenter/Feature/Home/Data/model/comment_model.dart';

import '../../Data/repo/home_repo.dart';

part 'comment_state.dart';
class CommentCubit extends Cubit<CommentState> {
  final Homerepo homerepo;

  CommentCubit(this.homerepo) : super(CommentInitial());

  List<CommentItem> comments = [];

  Future<void> getComment({required int num}) async {
    emit(CommentLoading());

    final response = await homerepo.fetchcoomentbyid(
      number: num,
      pagesize: 10, // عدد التعليقات في كل صفحة، غيّرها حسب الحاجة
      page: 1,      // بداية من الصفحة الأولى
    );

    response.fold(
          (failure) {
        emit(CommentFailure("فشل في تحميل التعليقات: ${failure.message}"));
      },
          (data) {
        try {
          if (data.items.isEmpty) {
            comments = data.items;
            emit(CommentSuccess(comments: comments));
          } else {
            emit(CommentEmpty());
          }
        } catch (e) {
          emit(CommentFailure("خطأ في معالجة البيانات: ${e.toString()}"));
        }
      },
    );
  }

  Future<void> addComment({
    required int advertisementId,
    required String comment,
  }) async {
    emit(CommentLoading());

    final response = await homerepo.addcomment(

      advertisementid: advertisementId,
      comment: comment,
    );

    response.fold(
          (failure) {
        emit(CommentFailure("فشل في إضافة التعليق: ${failure.message}"));
      },
          (data) async {
        await getComment(num: advertisementId);
        emit(CommentSuccess(comments: comments));
      },
    );
  }
}
