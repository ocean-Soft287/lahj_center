part of 'slider_cubit.dart';

@immutable
sealed class SliderState {}

class SliderInitial extends SliderState {

}
class SliderLoading extends SliderState {

}
class SliderSuccess extends SliderState {
  final  List<BannerSliderModel> bannerSliderModel;
  SliderSuccess({required this.bannerSliderModel});

}
class SliderError extends SliderState {
  final Failure failure;
  SliderError({required this.failure});
}
