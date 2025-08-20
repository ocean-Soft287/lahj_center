import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lahijcenter/Feature/main/bottomNavbar/repo/notfication_repo.dart';
import 'package:lahijcenter/core/bloc/base_state.dart';
import 'package:lahijcenter/Feature/main/bottomNavbar/model/notfication_model.dart';

class CubitNotfication extends Cubit<BaseState<List<NotificationModel>>> {
  final NotificationRepo repo;
  CubitNotfication(this.repo) : super(BaseState());

  
  void getNotifications() async {
    try {
      emit(state.copyWith(status: Status.loading));
      
       final result = await repo.fetchNotifications();
       result.fold(
         (failure) => emit(state.copyWith(
           status: Status.failure,
           errorMessage: failure.message,
           failure: failure,
         )),
        (notifications) => emit(
          state.copyWith(
            status: Status.success,
            data: notifications,
          ),
        ),
       );
    } catch (e) {
      emit(state.copyWith(
        status: Status.failure,
        errorMessage: e.toString(),
      ));
    }
  }
}
