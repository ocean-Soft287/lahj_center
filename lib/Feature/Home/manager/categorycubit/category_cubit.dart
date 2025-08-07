import 'package:bloc/bloc.dart';
import 'package:lahijcenter/core/bloc/base_state.dart';
import '../../Data/model/advertismint_response.dart';
import '../../Data/model/item_model.dart';
import '../../Data/repo/home_repo.dart';



class CategoryCubit extends Cubit<BaseState<AdvertisementResponse>> {
  CategoryCubit(this.homerepo) : super(BaseState());

  final Homerepo homerepo;

  List<Item> itemlist = [];
  List<Item> itemcategory = [];
  List<Item> itemgroup = [];

  void getitemsbygroup(int x) async {
    emit(state.copyWith(status: Status.loading));

    final response = await homerepo.fetchitemsbygroup(number: x);

    response.fold(
          (failure) {
      print(failure);
        emit(state.copyWith(
            errorMessage: "فشل في تحميل التصنيفات: ${failure.message}"));
      },
          (data) {
        try {
          if (data.items.isNotEmpty) {

            emit(state.copyWith(status: Status.success, data: data));
          } else {
            emit(state.copyWith(
                errorMessage: "لا توجد بيانات"));
          }
        } catch (e) {
          emit(state.copyWith(
              errorMessage: "خطأ في معالجة البيانات: ${e.toString()}"));
        }
      },
    );
  }

  void getallitems() async {
    emit(state.copyWith(status: Status.loading));

    final response = await homerepo.fetchallitems();

    response.fold(
          (failure) {
        print(failure);
        emit(state.copyWith(
            errorMessage:"فشل في تحميل التصنيفات: ${failure.message}"));
      },
          (data) {
        try {
          if (data.items.isNotEmpty) {
            emit(state.copyWith(status: Status.success, data: data));
          } else {
            emit(state.copyWith(
                errorMessage:"لا توجد بيانات للإعلانات"));
          }
        } catch (e) {
          emit(state.copyWith(
              errorMessage:"خطأ في معالجة البيانات: ${e.toString()}"));
        }
      },
    );
  }
}
