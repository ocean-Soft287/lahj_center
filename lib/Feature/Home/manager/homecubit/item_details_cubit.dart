import 'package:bloc/bloc.dart';
import 'package:lahijcenter/Feature/Home/Data/repo/home_repo.dart';
import '../../Data/model/item_model.dart';

part 'item_details_state.dart';

class ItemDetailsCubit extends Cubit<ItemDetailsState> {
  ItemDetailsCubit(this.homerepo) : super(ItemDetailsInitial());

  final Homerepo homerepo;
  Item? item; // تم تعديل النوع إلى Item بدلاً من List<Item>

  void getData(int id) async {
    emit(ItemDetailsLoad());

    try {
      final response = await homerepo.fetchitemsbyid(number: id);

      response.fold(
            (failure) {
          emit(ItemDetailsFailure());
        },
            (data) {
          item = data;
          emit(ItemDetailsSuccessful(item: data));
        },
      );
    } catch (e) {
      emit(ItemDetailsFailure());
    }
  }
}
