import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constans/app_colors.dart';

class CommentSectionrrSW extends StatelessWidget {
  const CommentSectionrrSW({super.key, required this.comment});
final TextEditingController comment;
  @override
  Widget build(BuildContext context) {
    return                Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16), color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              ' وصف الاعلان',
              style: TextStyle(
                fontSize: 16.sp,
                color: AppColors.mainAppColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.h),
            TextField(
              controller: comment,
              decoration: InputDecoration(
                hintText: '.....اكتب تعليقك هنا',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              maxLines: 3,
            ),
          ],
        ),
      ),
    );
  }
}
