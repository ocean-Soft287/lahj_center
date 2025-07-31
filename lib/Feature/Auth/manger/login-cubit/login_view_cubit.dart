import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Data/repo/repo.dart';
import 'login_view_state.dart';

class LoginViewCubit extends Cubit<LoginViewState> {
  final Loginrepo loginrepo;

  LoginViewCubit(this.loginrepo) : super(InitializeLoginViewState());

  void userLogin({
    required String email,
    required String password,
  }) async {
    emit(LoginViewStateLoading());
    final response = await loginrepo.login(
      email: email,
      password: password,
    );

    response.fold(
      (failure) {
        emit(LoginViewStateError(failure.message));
      },
      (data) {

        emit(LoginViewStateSuccess(data));

      }
    );
  }

  void forgetPassword({required String email}) async {
    emit(LoginViewStateLoading());

    final response = await loginrepo.forgetpassword(email: email);

    response.fold(
      (failure) {
        emit(LoginViewStateError(failure.message));
      },
      (data) {
        emit(LoginViewStateSuccessMessage(""));
      }
    );
  }
  //
  void forgetandchangepass({
    required String email,
    required String token,
    required String newpass,
  }) async {
    final response = await loginrepo.resetpassword(
     email: email, token:token, newpassword: newpass,
    );
    response.fold(
      (failure) {
        emit(Forgetandchangepassfailed(message: failure.message));
      },
      (data) {

          emit(ForgetandchangepassSuccessMessage(message:  data, ));

        }

    );
  }

  bool isPassword = true;
  IconData subfix = Icons.visibility_off;

  void changeIconPassword() {
    isPassword = !isPassword;
    subfix = isPassword ? Icons.visibility_off : Icons.visibility;
    emit(ChangeIconPasswordSuccess());
  }
}
