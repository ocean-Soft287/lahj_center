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
              
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.mainAppColor,
                      AppColors.mainAppColor.withOpacity(0.8),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.mainAppColor.withOpacity(0.3),
                      blurRadius: 15,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                padding: EdgeInsets.fromLTRB(16, 8, 16, 16),
                child: Column(
                  children: [
                    Row(
                      children: [
                       
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
                            borderRadius: BorderRadius.circular(25),
                            child: Container(
                              height: 50.h,
                              padding: const EdgeInsets.symmetric(horizontal: 18),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 10,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.search,
                                    color: AppColors.mainAppColor.withOpacity(0.7),
                                    size: 22,
                                  ),
                                  SizedBox(width: 12.w),
                                  Text(
                                    'ابحث في لحج سنتر',
                                    style: TextStyle(
                                      fontFamily: Fonts.font,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        
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
                          borderRadius: BorderRadius.circular(22),
                          child: Container(
                            width: 75.w,
                            height: 50.h,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(22),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 8,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                "بحث",
                                style: TextStyle(
                                  fontFamily: Fonts.font,
                                  color: AppColors.mainAppColor,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),

                    
                    BlocConsumer<HomeCubit, HomeState>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        if (state is Categorysuccful) {
                          return Container(
                            height: 40.h,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              padding: EdgeInsets.symmetric(horizontal: 4),
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
                                  child: AnimatedContainer(
                                    duration: Duration(milliseconds: 200),
                                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                    margin: EdgeInsets.symmetric(horizontal: 6),
                                    decoration: BoxDecoration(
                                      color: isSelected ? Colors.white : Colors.white.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(20),
                                      border: isSelected
                                          ? null
                                          : Border.all(color: Colors.white.withOpacity(0.3), width: 1),
                                      boxShadow: isSelected ? [
                                        BoxShadow(
                                          color: Colors.white.withOpacity(0.3),
                                          blurRadius: 8,
                                          offset: Offset(0, 2),
                                        ),
                                      ] : null,
                                    ),
                                    child: Center(
                                      child: Text(
                                        category.arName,
                                        style: TextStyle(
                                          fontFamily: Fonts.font,
                                          color: isSelected
                                              ? AppColors.mainAppColor
                                              : Colors.white,
                                          fontWeight: isSelected
                                              ? FontWeight.w600
                                              : FontWeight.w500,
                                          fontSize: 13.sp,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        } else if (state is Categoryload) {
                          return Container(
                            height: 40.h,
                            child: Center(
                              child: SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                  strokeWidth: 2.5,
                                ),
                              ),
                            ),
                          );
                        } else if (state is CategoryFailure) {
                          return Container(
                            height: 40.h,
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              color: Colors.red.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.red.withOpacity(0.3)),
                            ),
                            child: Center(
                              child: Text(
                                state.error,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          );
                        } else {
                          return Container(
                            height: 40.h,
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              color: Colors.orange.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.orange.withOpacity(0.3)),
                            ),
                            child: Center(
                              child: Text(
                                "فشل تحميل الفئات",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),

              // 📸 Banner Image
              // Container(
              //   margin: EdgeInsets.symmetric(vertical: 8),
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(12),
              //     boxShadow: [
              //       BoxShadow(
              //         color: Colors.black.withOpacity(0.1),
              //         blurRadius: 8,
              //         offset: Offset(0, 2),
              //       ),
              //     ],
              //   ),
              //   child: ClipRRect(
              //     borderRadius: BorderRadius.circular(12),
              //     child: Image.asset(
              //       'assets/image/Rectangle 16.png',
              //       height: 150,
              //       width: double.infinity,
              //       fit: BoxFit.fill,
              //     ),
              //   ),
              // ),
              SizedBox(height: 8.h),

              
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Listofitems(x: homeCubit.currentIndex),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}