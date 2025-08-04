import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lahijcenter/Feature/profile/data/repo/get_profile_repo.dart';
import 'get_profile_state.dart';

class GetProfileCubit extends Cubit<GetProfileState> {
  final GetProfileRepo getProfileRepo;

  GetProfileCubit(this.getProfileRepo) : super(GetProfileInitial());

  Future<void> fetchProfile() async {
    emit(GetProfileLoading());

    final result = await getProfileRepo.getProfile();

    result.fold(
          (failure) => emit(GetProfileFailure(failure.message)),
          (profile) => emit(GetProfileSuccess(profile)),
    );
  }
}
