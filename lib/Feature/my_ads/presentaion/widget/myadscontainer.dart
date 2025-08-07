import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constans/app_colors.dart';
import '../../../../core/sharde/widget/default_button.dart';
import '../../../AddAdvertisement/presentaion/screen/edit_add.dart';
import '../../../Home/Data/model/item_model.dart';
import '../../../MyFavoriteAds/screen/my_favorite_ad_sscreen.dart';

class Myadscontainer extends StatelessWidget {
  const Myadscontainer({super.key, required this.item, required this.function,});
final Item item;
final  Function function ;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: SizeUtility(context).height * 0.12,
              child: AspectRatio(
                aspectRatio: 2 / 1.4,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: item.advertisementImages.isEmpty?SizedBox.shrink():Image.network(
                  item.advertisementImages[0].imageName,
                      fit: BoxFit.contain,
                    ),

                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: MainTitle(
                          text: item.name, // اسم الإعلان ثابت
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.mainAppColor,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {

                        },
                        child:  Icon(
                          Icons.forward_10_outlined
                          ,
                          color: Colors.green,
                          size: 30.sp,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10.h),
                  MainTitle(
                    text:
//منذ 10 أشهر
                    "", // وقت ثابت
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.hintTextColor,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  const SizedBox(height: 5),
                  MainTitle(
                    text: "${item.governorateName}، ${item.area},",
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.hintTextColor,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  const SizedBox(height: 5),
                  MainTitle(
                    text: item.serviceName, // وقت ثابت
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.hintTextColor,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  SizedBox(height: 10.h),
                ],
              ),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              width: MediaQuery.sizeOf(context).width * .25,
              height: 35.h,
              child: DefaultButton(
                function:function,
                text: "حذف",
              ),
            ),
            SizedBox(
              width: 5.w,
            ),
            SizedBox(
              width: MediaQuery.sizeOf(context).width * .25,
              height: 35.h,
              child: DefaultButton(
                function: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>EditAdvertisementScreen(item: item,)));
                },
                text: "تعديل",
              ),
            ),
            SizedBox(
              width: 5.w,
            ),
            // SizedBox(
            //   width: MediaQuery.sizeOf(context).width * .25,
            //   height: 35.h,
            //   child: DefaultButton(
            //     function: () {},
            //     text: "مشاركه",
            //   ),
            // ),

          ],
        )
      ],
    );
  }
}
