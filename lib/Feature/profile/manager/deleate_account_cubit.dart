import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lahijcenter/Feature/profile/data/models/deleate_account_model.dart';
import 'package:lahijcenter/Feature/profile/data/repo/deleate_account_repo.dart';
import 'package:lahijcenter/core/bloc/base_state.dart';

class DeleateAccountCubit extends Cubit<BaseState<DeleateAccountModel>>{
  final DeleteAccountRepo deleteAccountRepo;
  DeleateAccountCubit({required this.deleteAccountRepo}) : super(BaseState());

  Future<void> deleteAccount(String userid) async {
    emit(
      state.copyWith(status: Status.loading, 

    ));
    final result = await deleteAccountRepo.deleteAccount(userid);
    print('Delete account result: $result');
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: Status.failure,
          errorMessage: failure.message,
          failure: failure,
        ),
      ),

      (model) => emit(state.copyWith(
        status: Status.success,
        data: model,
      )),
    );
  }
}