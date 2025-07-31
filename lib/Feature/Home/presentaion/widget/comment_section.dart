import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:lahijcenter/Feature/Home/manager/commentcubit/comment_cubit.dart';
import 'package:lahijcenter/Feature/Home/presentaion/screen/comment_list.dart';
import 'package:lahijcenter/core/network/local/flutter_secure_storage.dart';

import '../../../../core/constans/app_colors.dart';
import '../../Data/repo/home_repo.dart';
class CommentSection extends StatelessWidget {
  final TextEditingController controller;

  final int advertisementId;

  const CommentSection({
    super.key,
    required this.controller,
    required this.advertisementId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CommentCubit(GetIt.instance<Homerepo>())..getComment(num: advertisementId),
      child: BlocConsumer<CommentCubit, CommentState>(
        listener: (context, state) {
          // On successful comment submission, show a confirmation snackbar and clear the text field
          if (state is CommentSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('تم إضافة التعليق بنجاح')),
            );
            controller.clear();

            // On failure, display the error message
          } else if (state is CommentFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage)),
            );
          }
        },
        builder: (context, state) {
          // Obtain the CommentCubit instance
          final commentCubit = context.read<CommentCubit>();
          return Padding(
            padding: EdgeInsets.all(16.0.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Section title
                Text(
                  'اكتب تعليقاً',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: AppColors.mainAppColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.h),

                // Multiline text field for entering comments
                TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: '.....اكتب تعليقك هنا',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  maxLines: 3,
                ),
                SizedBox(height: 10.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Button to submit a comment
                    GestureDetector(
                      onTap: () async {
                        if (controller.text
                            .trim()
                            .isEmpty) return; // تعديل هنا

                        final storedId = await SecureStorageService.read(
                          SecureStorageService.customerid,
                        );
                        if (storedId == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('حدث خطأ في استرجاع رقم المستخدم'),
                            ),
                          );
                          return;
                        }

                        final customerId = int.parse(storedId);
                        commentCubit.addComment(
                          // id: customerId,
                          // customerId: customerId,
                          advertisementId: advertisementId,
                          comment: controller.text,
                        );
                        // print(customerId);
                        // print(advertisementId);
                        // commentCubit.getComment(num: advertisementId);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 10.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.mainAppColor,
                          borderRadius: BorderRadius.circular(25.r),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.arrow_back, color: Colors.white),
                            SizedBox(width: 5.w),
                            Text(
                              'إضافة تعليق',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Button to fetch and display existing comments
                    TextButton.icon(
                      onPressed: () async {
                        // commentCubit.getComment(
                        //   num: advertisementId,
                        // );
                        // if (commentCubit.comments.isEmpty) {
                        //
                        // }
                        // else {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) =>
                                  CommentList(member: commentCubit.comments)));
                        // }
                      },
                      icon: Icon(Icons.comment, color: AppColors.mainAppColor),
                      label: Text(
                        'مشاهدة التعليقات',
                        style: TextStyle(
                          color: AppColors.mainAppColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                // Display a loading indicator while comments are being processed

              ],
            ),
          );
        },
      ),
    );
  }
}