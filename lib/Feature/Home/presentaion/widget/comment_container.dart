import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:lahijcenter/Feature/Home/Data/model/get_report_model.dart';
import 'package:lahijcenter/Feature/Home/manager/commentcubit/get_report_cubit.dart';
import 'package:lahijcenter/Feature/Home/presentaion/widget/custom_enum.dart';
import 'package:lahijcenter/core/bloc/base_state.dart';
import 'package:lahijcenter/core/constans/app_colors.dart';
import '../../../../core/constans/fonts.dart';

class CommentContainer extends StatefulWidget {
  const CommentContainer({
    super.key,
    required this.comment,
    required this.customerImage,
    required this.customerName,
    required this.date,
    required this.advertCommentId,
  });

  final String comment;
  final String customerImage;
  final String customerName;
  final String date;
  final int advertCommentId;

  @override
  State<CommentContainer> createState() => _CommentContainerState();
}

class _CommentContainerState extends State<CommentContainer> {
  ReportReason? selectedReason;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.instance<GetReportCubit>(),
      child: BlocConsumer<GetReportCubit, BaseState<GetReportModel>>(
        listener: (context, state) {
          
          if (state.status == Status.success) {
            ScaffoldMessenger.of(context).showSnackBar(
               SnackBar(
               backgroundColor :AppColors.mainAppColor,
                content: Text("تم إرسال الإبلاغ بنجاح"),
              ),
            );
          } else if (state.status == Status.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("فشل في إرسال الإبلاغ")),
            );
          }
        },
        builder: (context, state) {
          return Container(
            margin: EdgeInsets.only(bottom: 12.h),
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: [
                BoxShadow(
                  color: AppColors.white.withValues(alpha:0.15),
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
                        imageUrl: widget.customerImage,
                        width: 40.w,
                        height: 40.w,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          width: 40.w,
                          height: 40.w,
                          color: Colors.grey[300],
                          child: const Icon(Icons.person, color: Colors.white),
                        ),
                        errorWidget: (context, url, error) => Container(
                          width: 40.w,
                          height: 40.w,
                          color: Colors.grey[300],
                          child: const Icon(Icons.person, color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Text(
                      widget.customerName,
                        style: TextStyle(
                          fontFamily: Fonts.font,
                          fontWeight: FontWeight.w600,
                          fontSize: 12.sp,
                          color: Colors.black87,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: DropdownButtonFormField<ReportReason>(
                        value: selectedReason,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 5.w),
                        ),
                        hint: Text(
                          "ابلاغ",
                          style: TextStyle(
                            fontFamily: Fonts.font,
                            fontWeight: FontWeight.w600,
                            fontSize: 14.sp,
                            color: AppColors.mainAppColor,
                          ),
                        ),
                        items: ReportReason.values.map((reason) {
                          return DropdownMenuItem(
                            value: reason,
                            child: Text(
                              reason == ReportReason.Abuse
                                  ? "إساءة"
                                  : "محتوى غير لائق",
                              style: TextStyle(
                                color: Colors.black87,
                                fontFamily: Fonts.font,
                                fontWeight: FontWeight.w600,
                                fontSize: 10.sp,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedReason = value;
                          });
                          if (value != null) {
                            context.read<GetReportCubit>().getReport(
                                  advertCommentId: widget.advertCommentId,
                                  reason: value.value.toString(),
                                );
                          }
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6.h),
                Text(
                  widget.comment,
                  style: TextStyle(
                    fontFamily: Fonts.font,
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 6.h),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    widget.date,
                    style: TextStyle(
                      fontFamily: Fonts.font,
                      fontWeight: FontWeight.w500,
                      fontSize: 10.sp,
                      color: Colors.grey,
                    ),
                  ),
                ),
                if (state.status == Status.loading) ...[
                  SizedBox(height: 8.h),
                   Center(child: CircularProgressIndicator(
                    color: AppColors.mainAppColor,
                  )),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}
