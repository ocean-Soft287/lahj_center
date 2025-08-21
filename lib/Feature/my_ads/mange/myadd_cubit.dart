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
        try {
          emit(Allmyadditemsuccful(advertisementResponse: data));
        } catch (e) {
          print(e);
          emit(AllmyadditemFailure());
        }
      },
    );
  }


  void deletemyadd(int id,String reason)async{
    getmyadd();

    emit(Deletemyadditemsuccful());

  }


}
