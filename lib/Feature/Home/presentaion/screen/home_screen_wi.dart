import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:lahijcenter/Feature/MyFavoriteAds/manger/favourite_cubit.dart';
import '../../../../core/constans/app_colors.dart';
import '../../../../core/constans/constants.dart';
import '../../../../core/constans/fonts.dart';
import '../../../../core/network/local/chachehelper.dart';
import '../../../Search/presentation/view/search.dart';
import '../../Data/repo/home_repo.dart';
import '../../manager/categorycubit/category_cubit.dart';
import '../../manager/homecubit/home_cubit.dart';
import '../../manager/homecubit/home_state.dart';
import '../widget/list_of_items.dart';
import 'package:lahijcenter/Feature/Search/manager/search_cubit.dart';


class HomeScreenWi extends StatelessWidget {
  const HomeScreenWi({super.key});

  @override
  Widget build(BuildContext context) {
    currentLang = CacheHelper.getData(key: 'changeLang') ?? 'ar';

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeCubit(GetIt.instance<Homerepo>())..getcategory(),
        ),
        BlocProvider(
          create: (context) => CategoryCubit(GetIt.instance<Homerepo>())..getallitems(),
        ),
        BlocProvider(
          create: (context) => GetIt.instance<FavouriteCubit>()..getallitems(),
        ),
        BlocProvider(
          create: (context) => GetIt.instance<SearchCubit>(),
        ),
      ],
      child: Builder(
        builder: (context) {
          final homeCubit = context.read<HomeCubit>();
          final categoryCubit = context.read<CategoryCubit>();

          return Column(
            children: [
              // 🔍 Search Section
              Container(
                color: AppColors.mainAppColor,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                child: Column(
                  children: [
                    Row(
                      children: [
                        // Fake Search Input (navigate to SearchPage)
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              final searchCubit = context.read<SearchCubit>();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BlocProvider.value(
                                    value: searchCubit,
                                    child: const Search(),
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              height: 45.h,
                              padding: const EdgeInsets.symmetric(horizontal: 15),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: [
                                  const Icon(Icons.search, color: Color(0xff949494)),
                                  SizedBox(width: 8.w),
                                  Text(
                                    'ابحث في لحج سنتر',
                                    style: TextStyle(
                                      fontFamily: Fonts.font,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                      color: const Color(0xff949494),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        // Button "بحث"
                        InkWell(
                          onTap: () {
                            final searchCubit = context.read<SearchCubit>();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BlocProvider.value(
                                  value: searchCubit,
                                  child: const Search(),
                                ),
                              ),
                            );
                          },
                          child: Container(
                            width: 70.w,
                            height: 45.h,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Text(
                                "بحث",
                                style: TextStyle(
                                  fontFamily: Fonts.font,
                                  color: Colors.black,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),

                    // 🧭 Categories
                    BlocConsumer<HomeCubit, HomeState>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        if (state is Categorysuccful) {
                          return SizedBox(
                            height: 30.h,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: state.categories.length,
                              itemBuilder: (context, index) {
                                final isSelected = homeCubit.currentIndex == index;
                                final category = state.categories[index];

                                return GestureDetector(
                                  onTap: () {
                                    homeCubit.changeSelectCategory(
                                      index: index,
                                      namecategory: category.arName,
                                    );

                                    if (index == 0) {
                                      categoryCubit.getallitems();
                                    } else {
                                      categoryCubit.getitemsbygroup(index);
                                    }
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8),
                                    margin: const EdgeInsets.symmetric(horizontal: 4),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          category.arName,
                                          style: TextStyle(
                                            fontFamily: Fonts.font,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12.sp,
                                          ),
                                        ),
                                        if (isSelected)
                                          Container(
                                            height: 2.h,
                                            width: 30.w,
                                            color: Colors.white,
                                            margin: const EdgeInsets.only(top: 5),
                                          ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        } else if (state is Categoryload) {
                          return const SizedBox(height: 30);
                        } else if (state is CategoryFailure) {
                          return Center(child: Text(state.error));
                        } else {
                          return const Center(child: Text("فشل تحميل الفئات"));
                        }
                      },
                    ),
                  ],
                ),
              ),

              // 📸 Banner Image
              Image.asset(
                'assets/image/Rectangle 16.png',
                height: 150,
                width: double.infinity,
                fit: BoxFit.fill,
              ),
              SizedBox(height: 10.h),

              // 📋 List of Items
              Expanded(
                child: Listofitems(x: homeCubit.currentIndex),
              ),
            ],
          );
        },
      ),
    );
  }
}




