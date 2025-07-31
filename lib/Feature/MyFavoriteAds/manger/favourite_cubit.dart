import 'package:bloc/bloc.dart';
import 'package:lahijcenter/Feature/Home/Data/model/advertismint_response.dart';
import 'package:lahijcenter/Feature/MyFavoriteAds/data/repo/fav_repo.dart';

import '../../Home/Data/model/item_model.dart';

part 'favourite_state.dart';

class FavouriteCubit extends Cubit<FavouriteState> {
  FavouriteCubit(this.favrepo) : super(FavouriteInitial());
  final Favrepo favrepo;
  void getallitems() async {
    emit(Allfavouriteitemsuccfulload());

    try {
      final response = await favrepo.getfavouritedata();
      response.fold(
            (failure) {
          emit(AllitemfavouriteFailure());
        },
            (data) {
          emit(Allfavouriteitemsuccful(data));
        },
      );
    } catch (e) {
      emit(AllitemfavouriteFailure());
    }
  }

  void changeboolean(bool islike){
    islike!=islike;
    print(" changeboolean(favourite);$islike");
  }
  void addoedeletefavourite(
      int advertisementid, bool favourite) async {
    if (favourite == false) {
      await favrepo.addofavourite(
          advertisementid: advertisementid);
      changeboolean(favourite);
      // getallitems();

    } else {
      await favrepo.deletefavourite(advertisementid: advertisementid);
      changeboolean(favourite);
      // getallitems();

    }
  }

  void delete(int advertisementid) async {
    await favrepo.deletefavourite(
        advertisementid: advertisementid);

     getallitems();
  }

}
