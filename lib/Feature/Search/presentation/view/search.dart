import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:lahijcenter/core/constans/app_colors.dart';
import '../../../../core/constans/fonts.dart';
import '../../../Home/presentaion/widget/advertsiminte_container.dart';
import '../../../MyFavoriteAds/manger/favourite_cubit.dart';
import '../../../MyFavoriteAds/manger/get_all_favourite_cubit.dart';
import '../../../MyFavoriteAds/manger/post_like_cubit.dart';
import '../../../MyFavoriteAds/manger/unlike_home_cubit.dart';
import '../../manager/search_cubit.dart';


class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController searchController = TextEditingController();
  late ScrollController scrollController;
  late SearchCubit searchCubit;
  final FocusNode focusNode = FocusNode();
  bool hasSearched = false;

  @override
  void initState() {
    super.initState();
    searchCubit = GetIt.instance<SearchCubit>();
    focusNode.requestFocus();
    scrollController = ScrollController();

    scrollController.addListener(() {
      if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 100) {
        searchCubit.loadMore();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    focusNode.dispose();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SearchCubit>.value(value: searchCubit),
        BlocProvider<FavouriteCubit>.value(
          value: GetIt.instance<FavouriteCubit>(),
        ),
      ],
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),
        body: SafeArea(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 20.h),
                decoration: BoxDecoration(
                  color: AppColors.mainAppColor


                ),
                child: Row(
                  spacing: 10,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                        child: Icon(Icons.arrow_back,color:Colors.white))

                  ,  Expanded(
                      flex: 4,
                      child: Container(
                        height: 52.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(26),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha:0.08),
                              blurRadius: 15,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: TextFormField(
                          focusNode: focusNode,
                          controller: searchController,
                          onChanged: (value) {
                            setState(() {
                              if (value.trim().isNotEmpty) {
                                hasSearched = true;
                                searchCubit.searchByName(value.trim(), isNewSearch: true);
                              } else {
                                hasSearched = false;
                              }
                            });
                          },
                          decoration: InputDecoration(
                            hintText: 'ابحث في لحج دوت كوم',
                            hintStyle: TextStyle(
                              fontFamily: Fonts.font,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFFB0B0B0),
                            ),
                            border: InputBorder.none,
                            prefixIcon: Container(
                              padding: EdgeInsets.all(12.w),
                              child: Icon(
                                Icons.search_rounded,
                                color: const Color(0xFF6366F1),
                                size: 22.sp,
                              ),
                            ),
                            suffixIcon: searchController.text.isNotEmpty
                                ? IconButton(
                              icon: Icon(
                                Icons.clear_rounded,
                                color: const Color(0xFF949494),
                                size: 20.sp,
                              ),
                              onPressed: () {
                                setState(() {
                                  searchController.clear();
                                  hasSearched = false;
                                });
                              },
                            )
                                : null,
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 14.h,
                              horizontal: 4.w,
                            ),
                          ),
                          style: TextStyle(
                            fontFamily: Fonts.font,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ),

              // Results Section
              Expanded(
                child: hasSearched
                    ? BlocBuilder<SearchCubit, SearchState>(
                  builder: (context, state) {
                    if (state is SearchSuccess) {
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
                              color: const Color(0xFFEF4444),
                            ),
                            SizedBox(height: 16.h),
                            Text(
                              state.message,
                              style: TextStyle(
                                fontFamily: Fonts.font,
                                fontSize: 16.sp,
                                color: const Color(0xFF6B7280),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    } else if (state is SearchLoading && searchCubit.searchList.isEmpty) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Color(0xFF6366F1),
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                )
                    : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 120.w,
                        height: 120.w,
                        decoration: BoxDecoration(
                          color: const Color(0xFF6366F1).withValues(alpha:0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.search_rounded,
                          size: 56.sp,
                          color: const Color(0xFF6366F1),
                        ),
                      ),
                      SizedBox(height: 24.h),
                      Text(
                        "ابدأ بالبحث...",
                        style: TextStyle(
                          fontFamily: Fonts.font,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF374151),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        "اكتب ما تبحث عنه في الأعلى",
                        style: TextStyle(
                          fontFamily: Fonts.font,
                          fontSize: 14.sp,
                          color: const Color(0xFF9CA3AF),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}