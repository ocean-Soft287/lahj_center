import 'package:bloc/bloc.dart';

import '../../Home/Data/model/advertismint_response.dart';
import '../data/my_ad_repo/myad_repo.dart';

part 'myadd_state.dart';

class MyaddCubit extends Cubit<MyaddState> {
  MyaddCubit(this.myaddrepo) : super(MyaddInitial());
  final Myaddrepo myaddrepo;

  void getmyadd() async {
    emit(Allmyadditemsuccfulload());

    final response = await myaddrepo.getmyad();

    response.fold(
      (failure) {
        emit(AllmyadditemFailure());
      },
      (data) {
        if (data.items.isEmpty) {
          emit(Allmyaddsitemsuccfulempty());
        } else {
          emit(Allmyadditemsuccful(advertisementResponse: data));
        }
      },
    );
  }

  Future<void> deletemyadd(int id, String reason) async {
    final response = await myaddrepo.deletemyadd(id, reason);

    response.fold(
      (failure) {
        emit(DeletemyadditemFailure());
      },
      (successMessage) {
        final updatedResponse = removeItem(id);
        if (updatedResponse != null) {
          emit(Deletemyadditemsuccful(advertisementResponse: updatedResponse));
        } else {
          emit(Allmyaddsitemsuccfulempty());
        }
      },
    );
  }

  AdvertisementResponse? removeItem(int id) {
    if (state is Allmyadditemsuccful || state is Deletemyadditemsuccful) {
      final currentStateResponse = state is Allmyadditemsuccful
          ? (state as Allmyadditemsuccful).advertisementResponse
          : (state as Deletemyadditemsuccful).advertisementResponse;

      final updatedItems = currentStateResponse.items
          .where((item) => item.id != id)
          .toList();

      if (updatedItems.isEmpty) {
        emit(Allmyaddsitemsuccfulempty());
        return null;
      } else {
        final newResponse = AdvertisementResponse(
          items: updatedItems,
          page: currentStateResponse.page,
          pageSize: currentStateResponse.pageSize,
          totalItems: currentStateResponse.totalItems - 1,
          totalPages: currentStateResponse.totalPages,
        );
        emit(Allmyadditemsuccful(advertisementResponse: newResponse));
        return newResponse;
      }
    }
    return null;
  }
}
