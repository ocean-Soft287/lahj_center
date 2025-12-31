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
    emit(Allmyadditemsuccfulload()); // optional: show loading

    final response = await myaddrepo.deletemyadd(id, reason);

    response.fold(
          (failure) {
        emit(DeletemyadditemFailure());
      },
          (successMessage) {
        getmyadd();
        emit(Deletemyadditemsuccful());
      },
    );
  }
}
