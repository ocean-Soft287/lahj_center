import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lahijcenter/Feature/profile/data/repo/update_profile_repo.dart';
import 'update_profile_state.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  final UpdateProfileRepo updateProfileRepo;

  UpdateProfileCubit(this.updateProfileRepo) : super(UpdateProfileInitial());

  Future<void> updateProfile({
    required String name,
    required String email,
    required String phone,
    String? imageBase64,
  }) async {
    emit(UpdateProfileLoading());

    final result = await updateProfileRepo.updateprofile(
      name: name,
      email: email,
      phone: phone,
      imageBase64: imageBase64,
    );

    result.fold(
          (failure) => emit(UpdateProfileError(failure.message)),
          (model) => emit(UpdateProfileSuccess(model)),
    );
  }
}
