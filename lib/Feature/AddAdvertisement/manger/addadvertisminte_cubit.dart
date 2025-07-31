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

  final List<Currency> currency = [];
  final List<Government> government = [];
  final List<Categorygroups> category = [];

  List<XFile?> galleryImage = []; // ✅ صور جديدة
  List<String> oldImage = [];     // ✅ صور قديمة

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
      final List<File> imageFiles =
      galleryImage.whereType<XFile>().map((xfile) => File(xfile.path)).toList();

      final result = await addadvertisminterepo.addaddvertisminte(
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
      final List<File> imageFiles =
      galleryImage.whereType<XFile>().map((xfile) => File(xfile.path)).toList();

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
        deletionReason: deletionReason, oldImage: oldImage,
      );

      result.fold(
            (failure) => emit(AddadvertisminteFailure(failure.message)),
            (data) => emit(AddadvertisminteprocessSuccess(data)),
      );
    } catch (e) {
      emit(AddadvertisminteFailure("Unexpected error: ${e.toString()}"));
    }
  }

  // 🔁 لتحديث الصور القديمة (تستخدمها لما ترجع بيانات الإعلان من الـ API)
  void setOldImages(List<String> images) {
    oldImage = images;
    emit(AddadvertisminteSuccess([]));
  }

  void fetchCategories() async {
    final result = await homerepo.fetchCategories();
    result.fold((failure) => emit(AddadvertisminteFailure(failure.message)),
            (data) async {
          if (data.isNotEmpty) {
            category.clear();
            category.addAll(
              data
                  .map((item) =>
                  Categorygroups.fromJson(item as Map<String, dynamic>))
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
          (failure) => emit(AddadvertisminteFailure(failure.message)),
          (data) async {
        if (data.isNotEmpty) {
          currency.clear();
          currency.addAll(
            data.map((item) =>
                Currency.fromJson(item as Map<String, dynamic>)).toList(),
          );

          await HiveCrudManager.saveList(
            "shared_data_box",
            "currency",
            currency.map((e) => e.toJson()).toList(),
          );

          emit(AddadvertisminteSuccess(currency));
        } else {
          emit(AddadvertisminteFailure("No data found"));
        }
      },
    );
  }

  void fetchgovermnet() async {
    emit(AddadvertisminteLoading());

    final result = await addadvertisminterepo.getGovernment();
    result.fold(
          (failure) => emit(AddadvertisminteFailure(failure.message)),
          (data) async {
        if (data.isNotEmpty) {
          government.clear();
          government.addAll(
              data.map((item) => Government.fromJson(item as Map<String, dynamic>)).toList(),
          );

          await HiveCrudManager.saveList(
            "shared_data_box",
            "government",
            government.map((e) => e.toJson()).toList(),
          );

          emit(AddadvertisminteSuccess(government));
        } else {
          emit(AddadvertisminteFailure("No data found"));
        }
      },
    );
  }

  List<Services> services = [];

  Future<void> getServices() async {
    emit(ServicesLoading());
    final result = await servicesRepo.getServices();
    result.fold(
          (failure) => emit(ServicesError(_mapFailureToMessage(failure))),
          (data) {
        services = data;
        emit(ServicesLoaded(List.from(services)));
      },
    );
  }

  bool failureMessageContainsCache({required String failureMessage}) {
    return failureMessage.toLowerCase().contains("api") ||
        failureMessage.toLowerCase().contains("server");
  }
}
