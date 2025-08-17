import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:lahijcenter/Feature/MyFavoriteAds/data/model/get_all_favourite_model.dart';
import 'package:lahijcenter/Feature/MyFavoriteAds/manger/get_all_favourite_cubit.dart';
import 'package:lahijcenter/Feature/MyFavoriteAds/manger/unlike_cubit.dart';
import 'package:lahijcenter/Feature/MyFavoriteAds/screen/widget/favourite_container.dart';
import 'package:lahijcenter/core/bloc/base_state.dart';
import 'package:lahijcenter/core/constans/app_colors.dart';
import 'package:lahijcenter/core/constans/fonts.dart';
import '../../../../../core/constans/responsve_font.dart';

class MyFavoriteAdsScreen extends StatelessWidget {
  const MyFavoriteAdsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
       value:
              GetIt.instance<GetAllFavouriteCubit>()..fetchFavouriteData(),
        ),
        BlocProvider(create: (context) => GetIt.instance<UnlikeCubit>()),
      ],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.mainAppColor,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          flexibleSpace: FlexibleSpaceBar(
            titlePadding: const EdgeInsets.only(bottom: 12, right: 56),
            title: Text(
              "اعلانتي المفضلة",
              style: TextStyle(
                fontFamily: Fonts.font,
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: getFontSize(context, 15),
              ),
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body: BlocConsumer<GetAllFavouriteCubit, BaseState<GetAllFavourite>>(
          listener: (context, state) {},
          builder: (context, state) {
            final favouriteCubit = context.read<GetAllFavouriteCubit>();
            List<Widget> slivers = [];

            if (state.isLoading) {
              slivers.add(
                const SliverToBoxAdapter(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 50),
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
              );
            } else if (state.isSuccess && state.data!.items.isEmpty) {
              slivers.add(
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 80),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Icon(
                            Icons.favorite,
                            size: 200,
                            color: Colors.grey[300],
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Text(
                          "لا توجد منتجات في المفضلة ",
                          style: TextStyle(
                            fontSize: 20.sp,
                            color: Colors.green,
                            fontWeight: FontWeight.w600,
                            fontFamily: Fonts.font,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
            
            else if (state.isSuccess && state.data != null) {
              final items = state.data!.items;
              slivers.add(
                SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    return FavouriteContainer(
                      item: items[index],
                     onTap: () async {
  final unlikeCubit = context.read<UnlikeCubit>();


  await unlikeCubit.unlikeAd(items[index].id);

  items.removeAt(index);
  favouriteCubit.emit(
    state.copyWith(
      data: GetAllFavourite(
        items: List.from(items), 
        page: state.data!.page,
        pageSize: state.data!.pageSize,
        totalItems: state.data!.totalItems - 1,
        totalPages: state.data!.totalPages,
      ),
      status: Status.success,
    ),
  );

 
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        "تم الحذف من المفضلة",
        style: TextStyle(
          fontFamily: Fonts.font,
          fontWeight: FontWeight.w600,
        ),
      ),
      backgroundColor: Colors.red,
      duration: const Duration(seconds: 2),
    ),
  );
},
                    );
                  }, childCount: items.length),
                ),
              );
            } 
            // حالة الفشل
            else if (state.isFailure) {
              slivers.add(
                SliverToBoxAdapter(
                  child: Center(
                    child: Text(
                      state.errorMessage ?? "حدث خطأ غير متوقع",
                      style: TextStyle(
                        fontFamily: Fonts.font,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
              );
            }

            return CustomScrollView(slivers: slivers);
          },
        ),
      ),
    );
  }
}
