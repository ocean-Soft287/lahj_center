import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lahijcenter/Feature/profile/data/repo/new_password_repo.dart';

import 'new_password_state.dart';

class NewPasswordCubit extends Cubit<NewpasswordState> {
  final NewPasswordRepo repo;

  NewPasswordCubit(this.repo) : super(NewpasswordInitial());

  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    emit(NewpasswordLoading());

    final result = await repo.newpassword(
      oldPassword: oldPassword,
      newPassword: newPassword,
    );

    result.fold(
          (failure) => emit(NewpasswordError(message: failure.message)),
          (model) => emit(NewpasswordSuccess(model: model)),
    );
  }
}
