import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:lahijcenter/Feature/Home/manager/commentcubit/post_comment_cubit.dart';
import 'package:lahijcenter/Feature/Home/presentaion/screen/comment_list.dart';
import 'package:lahijcenter/core/bloc/base_state.dart';

import '../../../../core/constans/app_colors.dart';
import '../../Data/model/post_model_comment.dart';

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
      create: (_) => GetIt.instance<PostCommentCubit>(),
      child: BlocConsumer<PostCommentCubit, BaseState<CommentItem>>(
        listener: (context, state) {
          if (state.isLoading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) =>  Center(child: CircularProgressIndicator(
              color: AppColors.mainAppColor,
              )),
            );
          } else if (state.isSuccess) {
            Navigator.pop(context); 
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('تم إضافة التعليق بنجاح')),
            );
            controller.clear();
          } else if (state.isFailure) {
            Navigator.pop(context); 
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMessage ?? "")));
          }
        },

        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.all(16.0.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'اكتب تعليقاً',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: AppColors.mainAppColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.h),

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
                    GestureDetector(
                      onTap: () {
                        context.read<PostCommentCubit>().postComment(
                          advertisementId: advertisementId,
                          comment: controller.text,
                        );
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
                    TextButton.icon(
                      onPressed: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                CommentList(postId: advertisementId),
                          ),
                        );
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
              ],
            ),
          );
        },
      ),
    );
  }
}
