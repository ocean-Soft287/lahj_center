import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import '../../../../core/constans/fonts.dart';
import '../../../Home/presentaion/widget/advertsiminte_container.dart';
import '../../../MyFavoriteAds/manger/favourite_cubit.dart';
import '../../../MyFavoriteAds/manger/post_like_cubit.dart';
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

  @override
  void initState() {
    super.initState();
    searchCubit = GetIt.instance<SearchCubit>();

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
    searchController.dispose();
    super.dispose();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SearchCubit>.value(value: searchCubit),
        BlocProvider<FavouriteCubit>(
          create: (_) => GetIt.instance<FavouriteCubit>(),
        ),
      ],
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                child: Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Container(
                        height: 45.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: TextFormField(
                          controller: searchController,
                          onChanged: (value) {
                            if (value.trim().isNotEmpty) {
                              searchCubit.searchByName(value.trim(), isNewSearch: true);
                            }
                          },
                          decoration: InputDecoration(
                            hintText: 'ابحث في لحج سنتر',
                            hintStyle: TextStyle(
                              fontFamily: Fonts.font,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xff949494),
                            ),
                            border: InputBorder.none,
                            prefixIcon: const Icon(Icons.search, color: Color(0xff949494)),
                            contentPadding: const EdgeInsets.symmetric(vertical: 10),
                          ),
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    InkWell(
                      onTap: () {
                        final searchText = searchController.text.trim();
                        if (searchText.isNotEmpty) {
                          searchCubit.searchByName(searchText, isNewSearch: true);
                        }
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
              ),
              SizedBox(height: 10.h),
              Expanded(
                child: BlocBuilder<SearchCubit, SearchState>(
                  builder: (context, state) {
                    if (state is SearchSuccess) {
                      return ListView.builder(
                        controller: scrollController,
                        itemCount: state.results.length,
                        itemBuilder: (context, index) {
                          final item = state.results[index];
                          return BlocProvider(create: (context) => GetIt.instance<PostLikeCubit>(),

                              child: AdvertsiminteContainer(item: item));
                        },
                      );
                    } else if (state is SearchFailure) {
                      return Center(child: Text(state.message));
                    } else if (state is SearchLoading && searchCubit.searchList.isEmpty) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return const Center(child: Text("ابدأ بالبحث..."));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
