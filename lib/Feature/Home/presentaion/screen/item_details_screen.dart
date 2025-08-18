import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:lahijcenter/Feature/Home/manager/homecubit/item_details_cubit.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/constans/app_colors.dart';
import '../../../../core/constans/fonts.dart';
import '../../Data/repo/home_repo.dart';
import '../widget/build_advertiser_section.dart';
import '../widget/build_image_section.dart';
import '../widget/comment_section.dart';

class ItemDetailsScreen extends StatelessWidget {
  const ItemDetailsScreen({super.key, required this.x});

  final int x;

  @override
  Widget build(BuildContext context) {
    final pageController = PageController();
    final TextEditingController comment = TextEditingController();
    return BlocProvider(
      create: (context) =>
          ItemDetailsCubit(GetIt.instance<Homerepo>())..getData(x),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: 40,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: AppColors.mainAppColor,
          elevation: 0,
          scrolledUnderElevation: 0,
        ),
        body: BlocConsumer<ItemDetailsCubit, ItemDetailsState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is ItemDetailsSuccessful) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BuildImageSection(
                      govrnment: state.item.governorateName,
                      pageController: pageController,
                      imagecache: state.item.advertisementImages.map((e)=>e.imageName).toList(),
                      name: state.item.name,
                      price: state.item.price.toString(),
                      currency: state.item.currencyName,
                      area: state.item.area,
                      item: state.item,
                    ),
                    Divider(thickness: 5, color: Color(0xffD9D9D9)),
                    BuildAdvertiserSection(item: state.item),
                    Divider(thickness: 5, color: Color(0xffD9D9D9)),
                    buildDescriptionSection(name: state.item.description),
                    Divider(thickness: 5, color: Color(0xffD9D9D9)),
                    SizedBox(height: 15.h),
                    state.item.isCloseReplies == false
                        ? CommentSection(
                            controller: comment,
                            advertisementId: x,
                          )
                        : const SizedBox(),
                  ],
                ),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 200,
                        width: double.infinity,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 16),
                      Container(height: 20, width: 150, color: Colors.white),
                      const SizedBox(height: 10),
                      Container(
                        height: 14,
                        width: double.infinity,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 10),
                      Container(
                        height: 14,
                        width: double.infinity,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 10),
                      Container(height: 14, width: 200, color: Colors.white),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget buildDescriptionSection({required String name}) {
    return Container(
      margin: EdgeInsets.all(12.sp),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'الوصف',
            style: TextStyle(
              fontFamily: Fonts.font,
              color: Colors.black,
              fontWeight: FontWeight.w300,
              fontSize: 12.sp,
            ),
          ),
          SizedBox(height: 20.h),
          Text(
            name,
            style: TextStyle(
              fontFamily: Fonts.font,
              color: Colors.black,
              fontWeight: FontWeight.w300,
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
    );
  }
}
