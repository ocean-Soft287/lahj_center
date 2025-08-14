import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lahijcenter/Feature/Home/Data/model/get_report_model.dart';
import 'package:lahijcenter/Feature/Home/Data/repo/get_report_repo.dart';
import 'package:lahijcenter/core/bloc/base_state.dart';

class GetReportCubit extends Cubit<BaseState<GetReportModel>>{
  
final GetReportRepo getReportRepo;
  GetReportCubit(this.getReportRepo) : super(const BaseState<GetReportModel>());

  Future<void> getReport({
    required int advertCommentId,
    required String reason,
  }) async {
    emit(state.copyWith(status: Status.loading));

    final response = await getReportRepo.getReport(
      advertCommentId: advertCommentId,
      reason: reason,
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