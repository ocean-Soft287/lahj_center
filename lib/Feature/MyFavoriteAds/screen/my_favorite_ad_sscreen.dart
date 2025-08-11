import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:lahijcenter/Feature/MyFavoriteAds/manger/favourite_cubit.dart';
import 'package:lahijcenter/Feature/MyFavoriteAds/screen/widget/favourite_container.dart';
import 'package:lahijcenter/core/constans/app_colors.dart';
import 'package:lahijcenter/core/constans/fonts.dart';
import '../../../../../core/constans/responsve_font.dart';
import '../../../core/network/local/flutter_secure_storage.dart';

class MyFavoriteAdsScreen extends StatelessWidget {
  const MyFavoriteAdsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.instance<FavouriteCubit>()..getallitems(),
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
        body: BlocConsumer<FavouriteCubit, FavouriteState>(
          listener: (context, state) {},
          builder: (context, state) {
            FavouriteCubit favouritecubit = BlocProvider.of(context);
            List<Widget> slivers = [];

            if (state is Allfavouriteitemsuccfulload) {
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
            } else if (state is Allfavouriteitemsuccful &&
                state.advertisementResponse.items.isEmpty) {
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
                          "لا توجد منتجات في المفضله ",
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
            } else if (state is Allfavouriteitemsuccful) {
              final items = state.advertisementResponse.items;
              slivers.add(
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return FavouriteContainer(
                        item: items[index],
                        onTap: () async {
                          final idString = await SecureStorageService.read(
                              SecureStorageService.customerid);
                          final int id =
                              int.tryParse(idString ?? '') ?? 0;

                          favouritecubit.delete(items[index].id);

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
                    },
                    childCount: items.length,
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

class MainTitle extends StatelessWidget {
  final String text;
  final Color? color;
  final double fontSize;
  final FontWeight fontWeight;
  final TextAlign? textAlign;
  final TextDecoration? decoration;
  final int? maxLines;
  final TextOverflow? overflow;

  const MainTitle(
      {super.key,
      required this.text,
      this.color = Colors.green,
      required this.fontSize,
      required this.fontWeight,
      this.textAlign,
      this.decoration = TextDecoration.none,
      this.maxLines,
      this.overflow});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: Fonts.font,
        fontSize: fontSize,
        fontWeight: fontWeight,
        decoration: decoration,
        decorationColor: AppColors.mainAppColor,
        color: color,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}

class SizeUtility {
  BuildContext context;

  SizeUtility(this.context);

  double get width => MediaQuery.of(context).size.width;
  double get height => MediaQuery.of(context).size.height;
}
