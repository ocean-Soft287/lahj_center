abstract class ProfileViewState {}

class InitializeProfileViewState extends ProfileViewState{}
class EditImagePickerProfileViewLoading extends ProfileViewState{}
class EditImagePickerProfileViewSuccess extends ProfileViewState{


}
class EditImagePickerProfileViewError extends ProfileViewState{}
class DeleteProfileLoadingState extends ProfileViewState{}
class DeleteProfileErrorState extends ProfileViewState{
  final String error;

  DeleteProfileErrorState(this.error);
}
class DeleteProfileSuccessState extends ProfileViewState{


}
class EditProfileLoadingState extends ProfileViewState{}
class EditProfileErrorState extends ProfileViewState{
  final String  error;

  EditProfileErrorState(this.error);
}
class EditProfileSuccessState extends ProfileViewState {
  final dynamic data;  // حط نوع الداتا المناسب بدل dynamic إذا تعرفه

  EditProfileSuccessState(this.data);
}
