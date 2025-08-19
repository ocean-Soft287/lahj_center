import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constans/app_colors.dart';
import '../../../../core/sharde/widget/default_button.dart';
import '../../../AddAdvertisement/presentaion/screen/edit_add.dart';
import '../../../Home/Data/model/item_model.dart';

class Myadscontainer extends StatelessWidget {
  const Myadscontainer({super.key, required this.item, required this.function,});
  
  final Item item;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 100.w,
              height: 100.w,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),  
                  ]
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: item.advertisementImages.isEmpty
                      ? Container(
                          color: Colors.grey[300],
                          child: Icon(
                            Icons.image_not_supported,
                            color: Colors.grey[600],
                            size: 40.sp,
                          ),
                        )
                      : Image.network(
                          item.advertisementImages[0].imageName,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                ),
              ),
            ),

            SizedBox(width: 10.w),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: MainTitle(
                          text: item.name,
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.mainAppColor,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Icon(
                          Icons.reply,
                          color: Colors.green,
                          size: 24.sp,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 5.h),

                  
                  MainTitle(
                    text: "${item.governorateName}، ${item.area}",
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.hintTextColor,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  SizedBox(height: 5.h),

               
                  MainTitle(
                    text: item.serviceName,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.hintTextColor,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
              ),
            )
          ],
        ),

        SizedBox(height: 10.h),

        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              width: MediaQuery.sizeOf(context).width * .25,
              height: 35.h,
              child: DefaultButton(
                function: function,
                text: "حذف",
              ),
            ),
            SizedBox(width: 5.w),
            SizedBox(
              width: MediaQuery.sizeOf(context).width * .25,
              height: 35.h,
              child: DefaultButton(
                function: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditAdvertisementScreen(item: item),
                    ),
                  );
                },
                text: "تعديل",
              ),
            ),
            SizedBox(width: 5.w),
          ],
        )
      ],
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

  const MainTitle({
    super.key,
    required this.text,
    this.color = Colors.green,
    required this.fontSize,
    required this.fontWeight,
    this.textAlign,
    this.decoration = TextDecoration.none,
    this.maxLines,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
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
