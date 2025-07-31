import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/constans/app_assets.dart';
import '../../../../core/constans/app_colors.dart';
import '../../../../core/constans/fonts.dart';
import '../../../../core/constans/responsve_font.dart';
import '../../manger/addadvertisminte_cubit.dart';
import 'dart:io';
import 'package:flutter_svg/flutter_svg.dart';



class ImageCard extends StatelessWidget {
  const ImageCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              "صورة الاعلان",
              style: TextStyle(
                fontFamily: Fonts.font,
                color: AppColors.mainAppColor,
                fontWeight: FontWeight.w500,
                fontSize: getFontSize(context, 16),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Text(
              "صوره الاعلان يجب ان تكون ما بين 5 الى 8 صور",
              style: TextStyle(
                fontFamily: Fonts.font,
                color: const Color(0xff868686),
                fontWeight: FontWeight.w500,
                fontSize: getFontSize(context, 11),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        BlocBuilder<AddadvertisminteCubit, AddadvertisminteState>(
          builder: (context, state) {
            AddadvertisminteCubit cubit = BlocProvider.of(context);

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  color: Colors.white,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero),
                  elevation: 5,
                  child: Padding(
                    padding: EdgeInsets.all(8.sp),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () => cubit.pickFromGallery(),
                          child: Card(
                            color: Colors.white,
                            elevation: 2,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 16),
                              child: Column(
                                children: [
                                  SvgPicture.asset(AppAssets.galleryIcon),
                                  Text("تصفح المعرض",
                                      style: TextStyle(
                                          fontFamily: Fonts.font,
                                          fontSize: getFontSize(context, 10))),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Text("او",
                            style: TextStyle(
                                fontFamily: Fonts.font,
                                fontSize: getFontSize(context, 15))),
                        GestureDetector(
                          onTap: () => cubit.pickFromCamera(),
                          child: Card(
                            color: Colors.white,
                            elevation: 2,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 16),
                              child: Column(
                                children: [
                                  SvgPicture.asset(AppAssets.camaraIcon),
                                  Text("استخدام الكاميرا",
                                      style: TextStyle(
                                          fontFamily: Fonts.font,
                                          fontSize: getFontSize(context, 10))),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                if (cubit.galleryImage.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: cubit.galleryImage.map((xfile) {
                          return Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.file(
                                  File(xfile!.path),
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: GestureDetector(
                                  onTap: () {
                                    cubit.galleryImage.remove(xfile);
                                    cubit.emit(AddadvertisminteSuccess([]));
                                  },
                                  child: const CircleAvatar(
                                    radius: 10,
                                    backgroundColor: Colors.red,
                                    child: Icon(Icons.close,
                                        size: 12, color: Colors.white),
                                  ),
                                ),
                              )
                            ],
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "عدد الصور: ${cubit.galleryImage.length}/8",
                        style: TextStyle(
                          color: cubit.galleryImage.length < 5
                              ? Colors.red
                              : Colors.green,
                          fontFamily: Fonts.font,
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}
