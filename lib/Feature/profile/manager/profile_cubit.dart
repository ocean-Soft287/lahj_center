import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lahijcenter/Feature/profile/data/repo/profile_repo.dart';
import 'package:lahijcenter/Feature/profile/manager/profile_state.dart';

class ProfileViewCubit extends Cubit<ProfileViewState> {
  ProfileViewCubit(this.profilerepo) : super(InitializeProfileViewState());
  final Profilerepo profilerepo;

  XFile? imageEditProfilePhoto;
  var pickerPhoto = ImagePicker();
  Future<void> getProfileImageByGallery() async {
    try {
      emit(EditImagePickerProfileViewLoading());

      final pickedFile = await pickerPhoto.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (pickedFile != null) {
        imageEditProfilePhoto = XFile(pickedFile.path);
        emit(EditImagePickerProfileViewSuccess());
      } else {
        emit(EditImagePickerProfileViewError());
      }
    } catch (e) {
      emit(EditImagePickerProfileViewError());
    }
  }

  void deleteuser() async {
    emit(DeleteProfileLoadingState());

    final result = await profilerepo.deleteprofilebyid();

    result.fold(
      (failure) {
        emit(DeleteProfileErrorState(failure.message));
      },
      (data) {
        emit(DeleteProfileSuccessState());
      },
    );
  }

  Future<void> submitProfileEdit({
    required int customerId,
    required String arabicName,
    required String englishName,
    required String phone,
    required String password,
    required String email,
  }) async {
    if (imageEditProfilePhoto == null) {
      emit(EditProfileErrorState("Please pick an image first."));
      return;
    }

    emit(EditProfileLoadingState());
    final file = File(imageEditProfilePhoto!.path);

    final result = await profilerepo.editimage(
      imageFile: file,
      customerId: customerId,
      arabicName: arabicName,
      englishName: englishName,
      phone: phone,
      password: password,
      email: email,
    );
    result.fold(
      (failure) => emit(EditProfileErrorState(failure.message)),
      (data) => emit(EditProfileSuccessState(data)),
    );
  }
}
