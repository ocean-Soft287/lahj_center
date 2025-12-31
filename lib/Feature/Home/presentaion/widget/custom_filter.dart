import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constans/app_colors.dart';
import '../../../../core/constans/fonts.dart';
import '../../../AddAdvertisement/data/model/government_model.dart';

class GovernmentFilterWidget extends StatelessWidget {
  final List<Government> governments;
  final int selectedIndex;
  final Function(int index, int? governmentId, String governmentName) onGovernmentSelected;

  const GovernmentFilterWidget({
    super.key,
    required this.governments,
    this.selectedIndex = 0,
    required this.onGovernmentSelected,
  });

  @override
  Widget build(BuildContext context) {
    // قائمة المحافظات مع إضافة "الكل" في البداية
    final List<Government> allGovernments = [
      Government(
        id: 0,
        arName: 'الكل',
        enName: 'All',
      ),
      ...governments,
    ];

    return Container(
      height: 42.h,
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        itemCount: allGovernments.length,
        itemBuilder: (context, index) {
          final isSelected = selectedIndex == index;
          final government = allGovernments[index];

          return GestureDetector(
            onTap: () {
              // إرسال الـ index والبيانات للـ parent
              if (index == 0) {
                onGovernmentSelected(index, null, 'الكل');
              } else {
                onGovernmentSelected(
                  index,
                  government.id,
                  government.arName,
                );
              }
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 6.h,
              ),
              margin: EdgeInsets.only(left: 8.w),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.mainAppColor : Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
                boxShadow: isSelected
                    ? [
                  BoxShadow(
                    color: AppColors.mainAppColor.withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ]
                    : null,
              ),
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (isSelected)
                      Padding(
                        padding: EdgeInsets.only(left: 6.w),
                        child: Icon(
                          Icons.location_on,
                          size: 14.sp,
                          color: Colors.white,
                        ),
                      ),
                    Text(
                      government.arName,
                      style: TextStyle(
                        fontFamily: Fonts.font,
                        color: isSelected ? Colors.white : Colors.black87,
                        fontSize: 12.sp,
                        fontWeight:
                        isSelected ? FontWeight.w600 : FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}