import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:lahijcenter/Feature/AddAdvertisement/blocs/government_bloc/government_bloc.dart';
import 'package:lahijcenter/Feature/AddAdvertisement/data/model/government_model.dart';
import 'package:lahijcenter/Feature/Home/manager/filter_cities/filter_cities_cubit.dart';
import 'package:lahijcenter/Feature/MyFavoriteAds/manger/favourite_cubit.dart';
import 'package:lahijcenter/Feature/main/bottomNavbar/manager/slider_cubit.dart';
import 'package:lahijcenter/core/bloc/base_state.dart';
import 'package:lahijcenter/core/utils/services/services_locator.dart';
import '../../../../core/constans/app_colors.dart';
import '../../../../core/constans/constants.dart';
import '../../../../core/constans/fonts.dart';
import '../../../../core/network/local/chachehelper.dart';
import '../../Data/repo/home_repo.dart';
import '../../Data/model/item_model.dart';
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
  Government? selectedGovernorate;

  bool isSearching = false;
  bool isFilteringByCity = false;
  int? selectedGovernorateId;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();

    scrollController.addListener(() {
      if (isSearching &&
          scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 100) {
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
          create: (context) =>
              HomeCubit(GetIt.instance<Homerepo>())..getcategory(),
        ),
        BlocProvider(
          create: (context) =>
              CategoryCubit(GetIt.instance<Homerepo>())..getallitems(),
        ),
        BlocProvider.value(
          value: GetIt.instance<FavouriteCubit>()..getallitems(),
        ),
        BlocProvider(create: (context) => GetIt.instance<SearchCubit>()),
        BlocProvider(create: (context) => GetIt.instance<FilterCitiesCubit>()),
        BlocProvider.value(value: GetIt.instance<SliderCubit>()..getSlider()),
      ],
      child: Builder(
        builder: (context) {
          final homeCubit = context.read<HomeCubit>();
          final categoryCubit = context.read<CategoryCubit>();
          final searchCubit = context.read<SearchCubit>();

          return NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  floating: true,
                  pinned: false,
                  elevation: 0,
                  backgroundColor: AppColors.mainAppColor,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            AppColors.mainAppColor,
                            AppColors.mainAppColor.withValues(alpha: 0.8),
                          ],
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, 11, 10, 4),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 30.h,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(25),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withValues(
                                            alpha: 0.1,
                                          ),
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
                                            searchCubit.searchByName(
                                              value.trim(),
                                              isNewSearch: true,
                                            );
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
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.grey[600],
                                        ),
                                        border: InputBorder.none,
                                        prefixIcon: Icon(
                                          Icons.search,
                                          color: AppColors.mainAppColor
                                              .withValues(alpha: 0.7),
                                          size: 16,
                                        ),
                                        suffixIcon:
                                            searchController.text.isNotEmpty
                                            ? IconButton(
                                                icon: Icon(
                                                  Icons.clear_rounded,
                                                  color: Colors.grey[600],
                                                  size: 16,
                                                ),
                                                onPressed: _clearSearch,
                                              )
                                            : null,
                                        contentPadding: EdgeInsets.symmetric(
                                          vertical: 4.h,
                                          horizontal: 4.w,
                                        ),
                                      ),
                                      style: TextStyle(
                                        fontFamily: Fonts.font,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ),
                                ),
                                if (isSearching) ...[
                                  SizedBox(width: 8.w),
                                  InkWell(
                                    onTap: _clearSearch,
                                    borderRadius: BorderRadius.circular(22),
                                    child: Container(
                                      width: 60.w,
                                      height: 34.h,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(22),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withValues(
                                              alpha: 0.1,
                                            ),
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
                          ),
                          // SizedBox(height: 5.h),
                          // Align(
                          //   alignment: Alignment.centerLeft,
                          //   child: Padding(
                          //     padding: EdgeInsets.symmetric(
                          //       horizontal: 16.w,
                          //       vertical: 8.h,
                          //     ),
                          //     child: Text(
                          //       isSearching ? 'نتائج البحث' : 'الإعلانات',
                          //       style: TextStyle(
                          //         fontFamily: Fonts.font,
                          //         fontSize: 16.sp,
                          //         fontWeight: FontWeight.w600,
                          //         color: Colors.black87,
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),

                SliverPersistentHeader(
                  pinned: true,
                  delegate: _SliverAppBarDelegate(
                    minHeight: 42.h,
                    maxHeight: 42.h,
                    child: Container(
                      color: AppColors.mainAppColor,
                      padding: EdgeInsets.symmetric(vertical: 6.h),
                      child: BlocConsumer<HomeCubit, HomeState>(
                        listener: (context, state) {},
                        builder: (context, state) {
                          if (state is Categorysuccful) {
                            return SizedBox(
                              height: 30.h,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                padding: EdgeInsets.symmetric(horizontal: 4),
                                itemCount: state.categories.length,
                                itemBuilder: (context, index) {
                                  final isSelected =
                                      homeCubit.currentIndex == index;
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
                                      duration: const Duration(
                                        milliseconds: 200,
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 6,
                                        vertical: 3,
                                      ),
                                      margin: EdgeInsets.symmetric(
                                        horizontal: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? Colors.white
                                            : Colors.white.withValues(
                                                alpha: 0.2,
                                              ),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Center(
                                        child: Text(
                                          category.arName,
                                          style: TextStyle(
                                            fontFamily: Fonts.font,
                                            color: isSelected
                                                ? AppColors.mainAppColor
                                                : Colors.white,
                                            fontSize: 11.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ),
                  ),
                ),

                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      BannerPage(),

                      BlocProvider(
                        create: (context) => sl<GovernmentBloc>(),
                        child: _buildGovernorateFilter(),
                      ),
                    ],
                  ),
                ),
              ];
            },

            body: NotificationListener<ScrollNotification>(
              onNotification: (scrollInfo) {
                if (isFilteringByCity &&
                    !isSearching &&
                    scrollInfo.metrics.pixels >=
                        scrollInfo.metrics.maxScrollExtent * 0.9) {
                  if (selectedGovernorateId != null) {
                    final filterCubit = context.read<FilterCitiesCubit>();
                    if (filterCubit.hasMoreData && !filterCubit.isLoadingMore) {
                      filterCubit.fetchNextPage(selectedGovernorateId!);
                    }
                  }
                }
                return false;
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: isSearching
                    ? _buildSearchResults()
                    : isFilteringByCity
                    ? _buildFilteredResults()
                    : Listofitems(x: homeCubit.currentIndex),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSearchResults() {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        if (state is SearchSuccess) {
          return ListView.builder(
            controller: scrollController,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
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
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildGovernorateFilter() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      child: BlocBuilder<GovernmentBloc, BaseState<Government>>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: DropdownButtonFormField<Government>(
              value: selectedGovernorate,
              hint: const Text("اختر المحافظة"),
              items: [
                DropdownMenuItem<Government>(
                  value: null,
                  child: Text(
                    "الكل",
                    style: TextStyle(
                      fontFamily: Fonts.font,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                ...state.items.map(
                  (g) => DropdownMenuItem(
                    value: g,
                    child: Text(
                      g.arName,
                      style: TextStyle(fontFamily: Fonts.font, fontSize: 14.sp),
                    ),
                  ),
                ),
              ],
              onChanged: (val) {
                setState(() {
                  selectedGovernorate = val;
                  if (val == null) {
                    isFilteringByCity = false;
                    selectedGovernorateId = null;
                  } else {
                    isFilteringByCity = true;
                    selectedGovernorateId = val.id;
                    context.read<FilterCitiesCubit>().fetchFirstPage(val.id);
                  }
                });
              },
              onSaved: (val) {
                setState(() {
                  selectedGovernorate = val;
                });
              },
              decoration: const InputDecoration(border: InputBorder.none),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFilteredResults() {
    return BlocBuilder<FilterCitiesCubit, BaseState<Item>>(
      builder: (context, state) {
        if (state.isLoading && state.items.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.items.isEmpty) {
          return Center(
            child: Text(
              'لا توجد إعلانات',
              style: TextStyle(
                fontFamily: Fonts.font,
                fontSize: 16.sp,
                color: Colors.grey[600],
              ),
            ),
          );
        }

        return ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          itemCount: state.items.length + (state.isLoading ? 1 : 0),
          itemBuilder: (context, index) {
            if (index >= state.items.length) {
              // Show loading indicator at the bottom
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                child: const Center(child: CircularProgressIndicator()),
              );
            }

            final item = state.items[index];
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
      },
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
