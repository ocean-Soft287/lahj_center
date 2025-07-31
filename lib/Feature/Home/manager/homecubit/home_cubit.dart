import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lahijcenter/Feature/Home/Data/model/categories.dart';
import 'package:lahijcenter/core/network/local/chachehelper.dart';
import '../../presentaion/screen/home_screen_wi.dart';
import '../../../main/bottomNavbar/widget/screen/inbox_screen.dart';
import '../../../main/bottomNavbar/widget/screen/notification_screen.dart';
import '../../Data/repo/home_repo.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final Homerepo homerepo;
  HomeCubit(this.homerepo) : super(InitializeHome()) {
    getcategory();
  }

  String namecategory = "الكل";
  int currentIndex = 0;
  List<Categorygroups> categories = [];

  void getcategory() async {
    emit(Categoryload());
    final response = await homerepo.fetchCategories();
    response.fold(
          (failure) {
        emit(CategoryFailure("فشل في تحميل التصنيفات: ${failure.message}"));
      },
          (data) {
        try {
          if (data.isNotEmpty) {
            categories = data
                .map((category) =>
                Categorygroups.fromJson(category as Map<String, dynamic>))
                .toList();
            // أضف "الكل" في البداية
            categories.insert(
              0,
              Categorygroups.fromJson(
                  const {"Id": 0, "ArName": "الكل", "EnName": "All"}),
            );
            String categoriesJson = jsonEncode(categories.map((category) => category.toJson()).toList());
            CacheHelper.saveData(key: "Categories", value: categoriesJson);

            emit(Categorysuccful(categories: categories));
          }
        } catch (e) {
          emit(CategoryFailure("خطأ في معالجة البيانات: ${e.toString()}"));
        }
      },
    );
  }


  List<Widget> screen = [
    const HomeScreenWi(),
    const InboxScreen(),
    const NotificationScreen(),
    const HomeScreenWi(),
  ];

  void changeSelectCategory({
    required int index,
    required String namecategory,
  }) {
    currentIndex = index;
    this.namecategory = namecategory;

    emit(Categorysuccful(categories: categories));


  }
}

