import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/Failure/failure.dart';
import '../model/banar_model.dart';
import '../repo/slider_repo.dart';

part 'slider_state.dart';

class SliderCubit extends Cubit<SliderState> {
  final SliderRepo sliderRepo;
  SliderCubit(this.sliderRepo) : super(SliderInitial());

  void getSlider() async {
    emit(SliderLoading());

    final result = await sliderRepo.getAllSlider();

    result.fold(
          (failure) {
           // print("Banner state is failure");
            emit(SliderError(failure: failure));
          },
          (banners) {
          //  print("Banner state is success");

            emit(SliderSuccess(

            bannerSliderModel: banners,
          ));
          },
    );
  }
}

