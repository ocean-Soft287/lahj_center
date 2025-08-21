import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:lahijcenter/Feature/MyFavoriteAds/manger/favourite_cubit.dart';
import 'package:lahijcenter/Feature/main/bottomNavbar/manager/slider_cubit.dart';
import '../../../../core/constans/app_colors.dart';
import '../../../../core/constans/constants.dart';
import '../../../../core/constans/fonts.dart';
import '../../../../core/network/local/chachehelper.dart';
import '../../Data/repo/home_repo.dart';
import '../../manager/categorycubit/category_cubit.dart';
import '../../manager/homecubit/home_cubit.dart';
import '../../manager/homecubit/home_state.dart';
import '../widget/banner_screen.dart';
import '../widget/list_of_items.dart';
import 'package:lahijcenter/Feature/Search/manager/search_cubit.dart';
import '../../../Home/presentaion/widget/advertsiminte_container.dart';
import '../../../MyFavoriteAds/manger/get_all_favourite_cubit.dart';
import '../../../MyFavoriteAds/manger/post_like_cubit.dart';
import '../../../MyFavoriteAds/manger/unlike_home_cubit.dart';

class HomeScreenWi extends StatefulWidget {
  const HomeScreenWi({super.key});

  @override
  State<HomeScreenWi> createState() => _HomeScreenWiState();
}

class _HomeScreenWiState extends State<HomeScreenWi> {
  final TextEditingController searchController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  late ScrollController scrollController;
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();

    scrollController.addListener(() {
      if (isSearching && scrollController.position.pixels >= scrollController.position.maxScrollExtent - 100) {
        context.read<SearchCubit>().loadMore();
      }
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    focusNode.dispose();
    scrollController.dispose();
    super.dispose();
  }

  void _clearSearch() {
    setState(() {
      searchController.clear();
      isSearching = false;
      focusNode.unfocus();
    });
  }

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
        BlocProvider.value(
          value: GetIt.instance<FavouriteCubit>()..getallitems(),
        ),
        BlocProvider(
          create: (context) => GetIt.instance<SearchCubit>(),
        ),
    BlocProvider.value(
      value: GetIt.instance<SliderCubit>()..getSlider(),

    ),
      ],
      child: Builder(
        builder: (context) {
          final homeCubit = context.read<HomeCubit>();
          final categoryCubit = context.read<CategoryCubit>();
          final searchCubit = context.read<SearchCubit>();

          return Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.mainAppColor,
                      AppColors.mainAppColor.withValues(alpha:0.8),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.mainAppColor.withValues(alpha:0.3),
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
                          child: Container(
                            height: 42.h,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha:0.1),
                                  blurRadius: 10,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: TextFormField(
                              focusNode: focusNode,
                              controller: searchController,
                              onChanged: (value) {
                                setState(() {
                                  if (value.trim().isNotEmpty) {
                                    isSearching = true;
                                    searchCubit.searchByName(value.trim(), isNewSearch: true);
                                  } else {
                                    isSearching = false;
                                  }
                                });
                              },
                              decoration: InputDecoration(
                                isDense: true,
                                hintText: 'ابحث في لحج دوت كوم',
                                hintStyle: TextStyle(
                                  fontFamily: Fonts.font,
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey[600],
                                ),
                                border: InputBorder.none,
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: AppColors.mainAppColor.withValues(alpha:0.7),
                                  size: 18,
                                ),
                                suffixIcon: searchController.text.isNotEmpty
                                    ? IconButton(
                                  icon: Icon(
                                    Icons.clear_rounded,
                                    color: Colors.grey[600],
                                    size: 18,
                                  ),
                                  onPressed: _clearSearch,
                                )
                                    : null,
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 8.h,
                                  horizontal: 4.w,
                                ),
                              ),
                              style: TextStyle(
                                fontFamily: Fonts.font,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ),

                        if (isSearching) ...[
                          SizedBox(width: 12.w),
                          InkWell(
                            onTap: _clearSearch,
                            borderRadius: BorderRadius.circular(22),
                            child: Container(
                              width: 70.w,
                              height: 42.h,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(22),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha:0.1),
                                    blurRadius: 8,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  "إلغاء",
                                  style: TextStyle(
                                    fontFamily: Fonts.font,
                                    color: AppColors.mainAppColor,
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),

                    SizedBox(height: 12.h),
                    BlocConsumer<HomeCubit, HomeState>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        if (state is Categorysuccful) {
                          return SizedBox(
                            height: 35.h,
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
                                    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                                    margin: EdgeInsets.symmetric(horizontal: 5),
                                    decoration: BoxDecoration(
                                      color: isSelected ? Colors.white : Colors.white.withValues(alpha:0.2),
                                      borderRadius: BorderRadius.circular(20),
                                      border: isSelected
                                          ? null
                                          : Border.all(color: Colors.white.withValues(alpha:0.3), width: 1),
                                      boxShadow: isSelected ? [
                                        BoxShadow(
                                          color: Colors.white.withValues(alpha:0.3),
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
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        } else if (state is Categoryload) {
                          return Center(
                            child: SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                strokeWidth: 2.5,
                              ),
                            ),
                          );
                        } else if (state is CategoryFailure) {
                          return Container(
                            height: 40.h,
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              color: Colors.red.withValues(alpha:0.2),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.red.withValues(alpha:0.3)),
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
                              color: Colors.orange.withValues(alpha:0.2),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.orange.withValues(alpha:0.3)),
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

              SizedBox(height: 8.h),

                 //const BannerPage(),


              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: isSearching
                      ? _buildSearchResults()
                      : Listofitems(x: homeCubit.currentIndex),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSearchResults() {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        if (state is SearchSuccess) {
          if (state.results.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.search_off_rounded,
                    size: 64.sp,
                    color: Colors.grey[400],
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    "لا توجد نتائج",
                    style: TextStyle(
                      fontFamily: Fonts.font,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    "جرب البحث بكلمات أخرى",
                    style: TextStyle(
                      fontFamily: Fonts.font,
                      fontSize: 14.sp,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            controller: scrollController,
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 16.h,
            ),
            itemCount: state.results.length,
            itemBuilder: (context, index) {
              final item = state.results[index];
              return Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: MultiBlocProvider(
                  providers: [
                    BlocProvider.value(
                      value: GetIt.instance<GetAllFavouriteCubit>()
                        ..fetchFavouriteData(),
                    ),
                    BlocProvider(
                      create: (context) => GetIt.instance<PostLikeCubit>(),
                    ),
                    BlocProvider(
                      create: (context) => GetIt.instance<UnlikeHomeCubit>(),
                    ),
                  ],
                  child: AdvertsiminteContainer(item: item),
                ),
              );
            },
          );
        } else if (state is SearchFailure) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline_rounded,
                  size: 64.sp,
                  color: Colors.red[400],
                ),
                SizedBox(height: 16.h),
                Text(
                  state.message,
                  style: TextStyle(
                    fontFamily: Fonts.font,
                    fontSize: 16.sp,
                    color: Colors.grey[700],
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        } else if (state is SearchLoading && context.read<SearchCubit>().searchList.isEmpty) {
          return Center(
            child: CircularProgressIndicator(
              color: AppColors.mainAppColor,
            ),
          );
        }

        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 120.w,
                height: 120.w,
                decoration: BoxDecoration(
                  color: AppColors.mainAppColor.withValues(alpha:0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.search_rounded,
                  size: 56.sp,
                  color: AppColors.mainAppColor,
                ),
              ),
              SizedBox(height: 24.h),
              Text(
                "جاري البحث...",
                style: TextStyle(
                  fontFamily: Fonts.font,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}