import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lahijcenter/core/constans/app_colors.dart';

import '../../../../core/constans/fonts.dart';

class CommentContainer extends StatelessWidget {
  const CommentContainer({super.key, required this.comment, required this.customerImage, required this.customerName});
final String comment;
final String customerImage;
  final String customerName;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.white.withOpacity(0.15),
            offset: const Offset(0, 3),
            blurRadius: 6,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipOval(
                child: CachedNetworkImage(
                  imageUrl:
                  "http://78.89.159.126:9393/TheOneLahjAPI/CustomerImages/$customerImage",
                  width: 40.w,
                  height: 40.w,
                  fit: BoxFit.cover,
                  placeholder:
                      (context, url) => Container(
                    width: 40.w,
                    height: 40.w,
                    color: Colors.grey[300],
                    child: const Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                  ),
                  errorWidget:
                      (context, url, error) => Container(
                    width: 40.w,
                    height: 40.w,
                    color: Colors.grey[300],
                    child: const Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  customerName,
                  style: TextStyle(
                    fontFamily: Fonts.font,
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                    color: Colors.black87,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              PopupMenuButton<String>(
                icon: const Icon(
                  Icons.more_vert,
                  color: Colors.black,
                ),
                onSelected: (value) {
                  if (value == 'report') {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('تم اختيار: إبلاغ'),
                      ),
                    );
                  }
                },
                itemBuilder:
                    (BuildContext context) =>
                <PopupMenuEntry<String>>[
                  const PopupMenuItem<String>(
                    value: 'report',
                    child: Text('إبلاغ'),
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: 6.h),
          Text(
            comment,
            style: TextStyle(
              fontFamily: Fonts.font,
              fontWeight: FontWeight.w500,
              fontSize: 16.sp,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
