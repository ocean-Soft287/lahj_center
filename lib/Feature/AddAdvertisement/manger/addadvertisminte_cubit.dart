import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lahijcenter/Feature/AddAdvertisement/data/model/currency.dart';
import 'package:lahijcenter/Feature/AddAdvertisement/data/model/government_model.dart';
import 'package:lahijcenter/Feature/Home/Data/model/categories.dart';
import 'package:lahijcenter/Feature/Home/Data/repo/home_repo.dart';
import '../../../core/network/local/hive_crud_manager.dart';
import '../data/model/services.dart';
import '../data/repo/repo.dart';

part 'addadvertisminte_state.dart';

class AddadvertisminteCubit extends Cubit<AddadvertisminteState> {
  AddadvertisminteCubit(this.addadvertisminterepo, this.homerepo)
    : super(AddadvertisminteInitial());

  final Addadvertisminterepo addadvertisminterepo;
  final Homerepo homerepo;

  final List<ModelCurrency> currency = [];
  final List<Government> government = [];
  final List<Categorygroups> category = [];
  final List<Services> services = [];

  List<XFile?> galleryImage = [];
  List<String> oldImage = [];

  final ImagePicker _picker = ImagePicker();

  Future<void> pickFromGallery() async {
    final List<XFile> images = await _picker.pickMultiImage();
    if (images.isNotEmpty) {
      galleryImage.addAll(images);
      emit(AddadvertisminteSuccess([]));
    }
  }

  Future<void> pickFromCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      galleryImage.add(image);
      emit(AddadvertisminteSuccess([]));
    }
  }

  Future<void> addAdvertisement({
    required String name,
    required String phone,
    required int groupId,
    required int serviceId,
    required double price,
    required bool isCloseReplies,
    required int currencyId,
    required int governorateId,
    required String area,
    required String description,
  }) async {
    emit(AddadvertisminteLoading());

    try {
      // تحويل الصور من XFile إلى File
      final List<File> imageFiles = galleryImage
          .whereType<XFile>()
          .map((xfile) => File(xfile.path))
          .toList();

      final result = await addadvertisminterepo.addAdvertisminte(
        name: name,
        phone: phone,
        groupId: groupId,
        serviceId: serviceId,
        price: price,
        isCloseReplies: isCloseReplies,
        currencyId: currencyId,
        governorateId: governorateId,
        area: area,
        description: description,
        images: imageFiles,
      );

      result.fold(
            (failure) => emit(AddadvertisminteFailure(failure.message)),
            (data) => emit(AddadvertisminteprocessSuccess(data)),
      );
    } catch (e) {
      emit(AddadvertisminteFailure("Unexpected error: ${e.toString()}"));
    }
  }


  Future<void> edit({
    required int id,
    required String name,
    required String phone,
    required int groupId,
    required String groupName,
    required String groupEName,
    required int serviceId,
    required String serviceName,
    required String serviceEName,
    required double price,
    required int currencyId,
    required String currencyName,
    required String currencyEName,
    required int regionId,
    required String regionName,
    required String regionEName,
    required String area,
    required String description,
    required int customerId,
    required String customerName,
    required String customerEName,
    required String date,
    required bool isCloseReplies,
    required int stateId,
    required String stateName,
    required String stateEName,
    String? deletionReason,
  }) async {
    emit(AddadvertisminteLoading());

    try {
      final List<File> imageFiles = galleryImage
          .whereType<XFile>()
          .map((xfile) => File(xfile.path))
          .toList();

      final result = await addadvertisminterepo.edit(
        id: id,
        name: name,
        phone: phone,
        groupId: groupId,
        groupName: groupName,
        groupEName: groupEName,
        serviceId: serviceId,
        serviceName: serviceName,
        serviceEName: serviceEName,
        price: price,
        currencyId: currencyId,
        currencyName: currencyName,
        currencyEName: currencyEName,
        regionId: regionId,
        regionName: regionName,
        regionEName: regionEName,
        area: area,
        description: description,
        customerId: customerId,
        customerName: customerName,
        customerEName: customerEName,
        date: date,
        isCloseReplies: isCloseReplies,
        stateId: stateId,
        stateName: stateName,
        stateEName: stateEName,
        images: imageFiles,
        deletionReason: deletionReason,
        oldImage: oldImage,
      );

      result.fold(
        (failure) => emit(AddadvertisminteFailure(failure.message)),
        (data) => emit(AddadvertisminteprocessSuccess(data)),
      );
    } catch (e) {
      emit(AddadvertisminteFailure("Unexpected error: ${e.toString()}"));
    }
  }

  void setOldImages(List<String> images) {
    oldImage = images;
    emit(AddadvertisminteSuccess([]));
  }

  void fetchCategories() async {
    final result = await homerepo.fetchCategories();
    result.fold((failure) => emit(AddadvertisminteFailure(failure.message)), (
      data,
    ) async {
      if (data.isNotEmpty) {
        category.clear();
        category.addAll(
          data
              .map(
                (item) => Categorygroups.fromJson(item as Map<String, dynamic>),
              )
              .toList(),
        );

        await HiveCrudManager.saveList(
          "shared_data_box",
          "category",
          category.map((e) => e.toJson()).toList(),
        );

        emit(AddadvertisminteSuccess(category));
      }
    });
  }

  void fetchcurrency() async {
    emit(AddadvertisminteLoading());

    final result = await addadvertisminterepo.getcurrency();

    result.fold(
          (failure) {
        emit(AddadvertisminteFailure(failure.message));
      },
          (data) async {
        if (data.isNotEmpty) {
          currency.clear();
          currency.addAll(data);

          await HiveCrudManager.saveList(
            "shared_data_box",
            "currency",
            currency.map((e) => e.toJson()).toList(),
          );

          emit(AddadvertisminteSuccess(currency));
        } else {
          emit(AddadvertisminteFailure("لا توجد عملات متاحة"));
        }
      },
    );
  }




  void fetchgovermnet() async {
    emit(AddadvertisminteLoading());

    int retryCount = 0;
    const maxRetries = 3;

    while (retryCount < maxRetries) {
      try {

        final result = await addadvertisminterepo.getGovernment();

        result.fold(
          (failure) {
            retryCount++;

            if (retryCount >= maxRetries) {
              emit(
                AddadvertisminteFailure(
                  'فشل في جلب المحافظات بعد $maxRetries محاولات: ${failure.message}',
                ),
              );
            }
          },
          (data) async {
            if (data.isNotEmpty) {
              government.clear();
              government.addAll(data);

              await HiveCrudManager.saveList(
                "shared_data_box",
                "government",
                government.map((e) => e.toJson()).toList(),
              );

              emit(AddadvertisminteSuccess(government));
              return; // Exit the retry loop
            } else {
              emit(AddadvertisminteFailure("لا توجد بيانات متاحة للمحافظات"));
              return; // Exit the retry loop
            }
          },
        );

        if (retryCount < maxRetries) {
          await Future.delayed(
            Duration(seconds: retryCount + 1),
          ); // Exponential backoff
        }
      } catch (e) {
        retryCount++;

        if (retryCount >= maxRetries) {
          emit(AddadvertisminteFailure('فشل في جلب المحافظات: $e'));
        }
      }
    }
  }

  void fetchServices() async {

    emit(AddadvertisminteLoading());

    int retryCount = 0;
    const maxRetries = 3;

    while (retryCount < maxRetries) {
      try {

        final result = await addadvertisminterepo.getServices();

        result.fold(
          (failure) {

            retryCount++;

            if (retryCount >= maxRetries) {

              emit(
                AddadvertisminteFailure(
                  'فشل في جلب الخدمات بعد $maxRetries محاولات: ${failure.message}',
                ),
              );
            }
          },
          (data) async {

            if (data.isNotEmpty) {

              services.clear();
              services.addAll(data);


              await HiveCrudManager.saveList(
                "shared_data_box",
                "services",
               services.map((e) => e.toJson()).toList(),
              );



              emit(AddadvertisminteSuccess(services));
              return; // Exit the retry loop
            } else {

              emit(AddadvertisminteFailure("لا توجد بيانات متاحة للخدمات"));
              return; // Exit the retry loop
            }
          },
        );

        if (retryCount < maxRetries) {
          await Future.delayed(
            Duration(seconds: retryCount + 1),
          ); // Exponential backoff
        }
      } catch (e) {
        retryCount++;

        if (retryCount >= maxRetries) {
          emit(AddadvertisminteFailure('فشل في جلب الخدمات: $e'));
        }
      }
    }
  }

  bool failureMessageContainsCache({required String failureMessage}) {
    return failureMessage.toLowerCase().contains("api") ||
        failureMessage.toLowerCase().contains("server");
  }
}
