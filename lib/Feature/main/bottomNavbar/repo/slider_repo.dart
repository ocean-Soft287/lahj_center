import 'package:dartz/dartz.dart';
import 'package:lahijcenter/core/Failure/failure.dart';
import 'package:lahijcenter/core/utils/api/dio_consumer.dart';

import '../../../../core/utils/api/endpoint.dart';
import '../model/banar_model.dart';

abstract interface class SliderRepo {
  Future<Either<Failure, List<BannerSliderModel>>> getAllSlider();
}

class SliderRepoImpl implements SliderRepo {
  final DioConsumer dioConsumer;
  SliderRepoImpl(this.dioConsumer);

  @override
  Future<Either<Failure, List<BannerSliderModel>>> getAllSlider() async {
    try {
      final response = await dioConsumer.get(EndPoint.getallSlider);

      final List data = response.data;
      final banners = data.map((e) => BannerSliderModel.fromJson(e)).toList();

      return Right(banners);
    } on Exception catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}


