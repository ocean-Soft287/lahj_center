import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lahijcenter/Feature/Home/Data/model/comment_model.dart';
import 'package:lahijcenter/core/constans/fonts.dart';

import '../widget/comment_container.dart';

class CommentList extends StatelessWidget {
  const CommentList({super.key, required this.member});

  final List<CommentItem> member;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 60.h,
            backgroundColor: const Color(0xFF54BC64),
            centerTitle: true,
            title: Text(
              "قائمة التعليقات",
              style: TextStyle(
                fontFamily: Fonts.font,
                fontWeight: FontWeight.bold,
                fontSize: 20.sp,
                color: Colors.white,
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final comment = member[index];
                final customerName =
                    comment.memberFullName ;
                final customerImage =
                    comment.memberImageUrl ;

                return CommentContainer(comment:comment.comment , customerImage: customerImage.toString(), customerName: customerName,);
              }, childCount: member.length),
            ),
          ),
        ],
      ),
    );
  }
}
