import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:lahijcenter/core/Failure/failure.dart';
import 'package:lahijcenter/core/utils/api/api_consumer.dart';
import 'package:lahijcenter/core/utils/api/dio_consumer.dart';

import '../../../../core/utils/api/endpoint.dart';
import '../model/banar_model.dart';

abstract interface class SliderRepo {
  Future<Either<Failure, List<BannerSliderModel>>> getAllSlider();
}

class SliderRepoImpl implements SliderRepo {
  final ApiConsumer dioConsumer;
  SliderRepoImpl(this.dioConsumer);

  @override
  Future<Either<Failure, List<BannerSliderModel>>> getAllSlider() async {
    try {
      final List response = await dioConsumer.get(EndPoint.getallSlider);

      final banners = response
          .map((e) => BannerSliderModel.fromJson(e as Map<String, dynamic>))
          .toList();

      return Right(banners);
    } on DioException catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

}


