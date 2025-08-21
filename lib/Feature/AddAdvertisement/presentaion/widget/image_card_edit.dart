import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constans/app_assets.dart';
import '../../../../core/constans/app_colors.dart';
import '../../../../core/constans/fonts.dart';
import '../../../../core/constans/responsve_font.dart';
import '../../manger/addadvertisminte_cubit.dart';
class ImageCardEdit extends StatelessWidget {
  const ImageCardEdit({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              "صور الإعلان",
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
              "يجب أن يحتوي الإعلان على 5 إلى 8 صور (قديمة + جديدة)",
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
            final cubit = BlocProvider.of<AddadvertisminteCubit>(context);
            final totalCount = cubit.galleryImage.length + cubit.oldImage.length;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  color: Colors.white,
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
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
                            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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
                            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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

                if (cubit.oldImage.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(" الصور الحالية:", style: TextStyle(fontFamily: Fonts.font)),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: cubit.oldImage.map((name) {
                          final fullUrl = 'http://78.89.159.126:9393/TheOneLahjAPI/AdvertImages/$name';
                          return Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  fullUrl,
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
                                    cubit.oldImage.remove(name);
                                    //cubit.emit(AddadvertisminteSuccess([]));
                                  },
                                  child: const CircleAvatar(
                                    radius: 10,
                                    backgroundColor: Colors.red,
                                    child: Icon(Icons.close, size: 12, color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ],
                  ),

                const SizedBox(height: 12),

                if (cubit.galleryImage.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("📥 الصور الجديدة:", style: TextStyle(fontFamily: Fonts.font)),
                      const SizedBox(height: 8),
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
                                   // cubit.emit(AddadvertisminteSuccess([]));
                                  },
                                  child: const CircleAvatar(
                                    radius: 10,
                                    backgroundColor: Colors.red,
                                    child: Icon(Icons.close, size: 12, color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ],
                  ),

                const SizedBox(height: 12),

                Text(
                  "عدد الصور الكلي: $totalCount / 8",
                  style: TextStyle(
                    color: totalCount < 5 ? Colors.red : Colors.green,
                    fontFamily: Fonts.font,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}