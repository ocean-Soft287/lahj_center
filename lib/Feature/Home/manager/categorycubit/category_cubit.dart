import 'package:bloc/bloc.dart';
import '../../Data/model/advertismint_response.dart';
import '../../Data/model/item_model.dart';
import '../../Data/repo/home_repo.dart';

part 'category_state.dart';


class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit(this.homerepo) : super(CategoryInitial());

  final Homerepo homerepo;

  List<Item> itemlist = [];
  List<Item> itemcategory = [];
  List<Item> itemgroup = [];

  void getitemsbygroup(int x) async {
    emit(Groupload());

    final response = await homerepo.fetchitemsbygroup(number: x);

    response.fold(
          (failure) {
      print(failure);
        emit(GroupitemFailure(
            error: "فشل في تحميل التصنيفات: ${failure.message}"));
      },
          (data) {
        try {
          if (data.items.isNotEmpty) {

            emit(Groupsuccful(item: data));
          } else {
            emit(GroupitemFailure(error: "لا توجد بيانات"));
          }
        } catch (e) {
          emit(GroupitemFailure(
              error: "خطأ في معالجة البيانات: ${e.toString()}"));
        }
      },
    );
  }

  void getallitems() async {
    emit(Allitemload());

    final response = await homerepo.fetchallitems();

    response.fold(
          (failure) {
        print(failure);
        emit(AllitemFailure("فشل في تحميل التصنيفات: ${failure.message}"));
      },
          (data) {
        try {
          if (data.items.isNotEmpty) {
            emit(Allitemsuccful(item: data));
          } else {
            emit(AllitemFailure("لا توجد بيانات للإعلانات"));
          }
        } catch (e) {
          emit(AllitemFailure("خطأ في معالجة البيانات: ${e.toString()}"));
        }
      },
    );
  }
}
