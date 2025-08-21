import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:lahijcenter/Feature/main/bottomNavbar/manager/cubit_notfication.dart';
import 'package:lahijcenter/Feature/main/bottomNavbar/model/notfication_model.dart';
import 'package:lahijcenter/core/bloc/base_state.dart';

import '../../../../../core/constans/fonts.dart';
import '../../../../../core/constans/responsve_font.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          GetIt.instance<CubitNotfication>()..getNotifications(),
      child: BlocConsumer<CubitNotfication, BaseState<List<NotificationModel>>>(
        listener: (context, state) {
          if (state.status == Status.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  children: [
                    const Icon(Icons.error_outline, color: Colors.white),
                    const SizedBox(width: 8),
                    Text(
                      "خطأ في تحميل الإشعارات",
                      style: TextStyle(
                        fontFamily: Fonts.font,
                        fontSize: getFontSize(context, 12),
                      ),
                    ),
                  ],
                ),
                backgroundColor: Colors.red.shade600,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                margin: const EdgeInsets.all(16),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state.status == Status.loading) {
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.blue.shade50, Colors.white],
                ),
              ),
              child: Column(
                children: [
                  // Header
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade200,
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.notifications_active,
                          color: Colors.blue.shade600,
                          size: 24,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "الإشعارات",
                          style: TextStyle(
                            fontFamily: Fonts.font,
                            color: Colors.grey.shade800,
                            fontWeight: FontWeight.w700,
                            fontSize: getFontSize(context, 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Loading indicator
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.blue.shade600,
                            ),
                            strokeWidth: 3,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "جاري تحميل الإشعارات...",
                            style: TextStyle(
                              fontFamily: Fonts.font,
                              color: Colors.grey.shade600,
                              fontSize: getFontSize(context, 12),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          if (state.status == Status.success) {
            final notifications = state.data ?? [];
            if (notifications.isEmpty) {
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.blue.shade50, Colors.white],
                  ),
                ),
                child: Column(
                  children: [

                    Expanded(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(24),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.notifications_off_outlined,
                                size: 64,
                                color: Colors.grey.shade400,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              "لا توجد إشعارات",
                              style: TextStyle(
                                fontFamily: Fonts.font,
                                color: Colors.grey.shade600,
                                fontSize: getFontSize(context, 14),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "ستظهر الإشعارات هنا عند وصولها",
                              style: TextStyle(
                                fontFamily: Fonts.font,
                                color: Colors.grey.shade500,
                                fontSize: getFontSize(context, 11),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.blue.shade50, Colors.white],
                ),
              ),
              child: Column(
                children: [
                  // Enhanced Header
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade200,
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Notification count badge
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade100,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            "${notifications.length}",
                            style: TextStyle(
                              fontFamily: Fonts.font,
                              color: Colors.blue.shade700,
                              fontSize: getFontSize(context, 11),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        // Title with icon
                        Row(
                          children: [
                            Icon(
                              Icons.notifications_active,
                              color: Colors.blue.shade600,
                              size: 24,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              "الإشعارات",
                              style: TextStyle(
                                fontFamily: Fonts.font,
                                color: Colors.grey.shade800,
                                fontWeight: FontWeight.w700,
                                fontSize: getFontSize(context, 16),
                              ),
                            ),
                          ],
                        ),
                        // Placeholder for symmetry
                        const SizedBox(width: 40),
                      ],
                    ),
                  ),
                  // Enhanced notification list
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: notifications.length,
                      itemBuilder: (context, index) {
                        final notification = notifications[index];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade200,
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(16),
                            onTap: () {},
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.blue.shade100,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Icon(
                                      Icons.notifications,
                                      color: Colors.blue.shade600,
                                      size: 20,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          notification.messageBody,
                                          style: TextStyle(
                                            fontFamily: Fonts.font,
                                            fontWeight: FontWeight.bold,
                                            fontSize: getFontSize(context, 13),
                                            color: Colors.grey.shade800,
                                            height: 1.4,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        if (notification
                                                .messageBody
                                                .isNotEmpty) ...[
                                          const SizedBox(height: 4),
                                        
                                           
                                        ],
                                        const SizedBox(height: 8),
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.access_time,
                                                size: 12,
                                                color: Colors.grey.shade500,
                                              ),
                                              const SizedBox(width: 4),
                                              Text(
                                                DateFormat('HH:mm yyyy-MM-dd').format(notification.createdAt.toLocal())

                                                ,style: TextStyle(
                                                  fontFamily: Fonts.font,
                                                  fontSize: getFontSize(
                                                    context,
                                                    10,
                                                  ),
                                                  color: Colors.grey.shade500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  
                                  Container(
                                    width: 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      color: Colors.blue.shade600,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }

          if (state.status == Status.failure) {
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.red.shade50, Colors.white],
                ),
              ),
              child: Column(
                children: [
                  // Header
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade200,
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.notifications_active,
                          color: Colors.red.shade600,
                          size: 24,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "الإشعارات",
                          style: TextStyle(
                            fontFamily: Fonts.font,
                            color: Colors.grey.shade800,
                            fontWeight: FontWeight.w700,
                            fontSize: getFontSize(context, 16),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: Colors.red.shade100,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.error_outline,
                              size: 64,
                              color: Colors.red.shade600,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "حدث خطأ أثناء تحميل البيانات",
                            style: TextStyle(
                              fontFamily: Fonts.font,
                              color: Colors.red.shade700,
                              fontSize: getFontSize(context, 14),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "يرجى المحاولة مرة أخرى",
                            style: TextStyle(
                              fontFamily: Fonts.font,
                              color: Colors.grey.shade600,
                              fontSize: getFontSize(context, 11),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          // الحالة الافتراضية
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
