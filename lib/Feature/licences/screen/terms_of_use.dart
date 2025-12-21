import 'package:flutter/material.dart';
import 'package:lahijcenter/core/Textstyle/text_style.dart';
import 'package:lahijcenter/core/constans/app_colors.dart';

class TermsOfUse extends StatelessWidget {
  const TermsOfUse({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: AppColors.mainAppColor,
        elevation: 3,
        shadowColor: Colors.black26,
        title: Text(
          "شروط الاستخدام",
          style: Textstylefont.usetermsstyle(context),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: 22),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              // Header Card
              Container(
                width: double.infinity,
                margin: EdgeInsets.all(16),
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.mainAppColor,
                      AppColors.mainAppColor.withOpacity(0.8),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.mainAppColor.withOpacity(0.3),
                      blurRadius: 15,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.description_outlined,
                        size: 48,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      "يرجى قراءة الشروط بعناية",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "التزم بالقواعد لضمان تجربة آمنة",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),

              // Content
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionCard(
                      context: context,
                      icon: Icons.block_outlined,
                      iconColor: Colors.red,
                      title: "السلع الممنوعة:",
                      content:
                      "السلعة الموضحة هي السلع الممنوعة في الموقع لحج دوت كوم. هذه السلع ممنوع الإعلان عنها في الموقع و ممنوع أيضًا شرائها عبر الموقع. نحن نقوم بحظر المعلن الذي يقوم بالإعلان عن هذه السلع و نقوم بحظر من يتجاوب معه عبر الرسائل الخاصة أو عبر الردود. نرجو ملاحظة أن ليس هناك تنبيه قبل الحظر وأن الحظر نهائي.",
                      subtitle: "السلع الممنوعة هي:",
                      items: [
                        "المخدرات بكل أنواعها.",
                        "المنتجات الجنسية بكافة أشكالها وأنواعها.",
                        "صرف العملات بكل أنواعها.",
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildSectionCard(
                      context: context,
                      icon: Icons.comment_outlined,
                      iconColor: Colors.orange,
                      title: "الردود الممنوعة:",
                      subtitle: "القائمة التالية تحتوي على أغلب الردود الممنوعة:",
                      items: [
                        "الإعلان في الردود.",
                        "البخس.",
                        "السب والشتم سواء كان هناك مبرر أم لم يكن هناك مبرر.",
                        "عدم الجدية و عدم الرغبة في الشراء.",
                        "التعليق لأجل إضافة نكتة أو خبر. الموقع للبيع والشراء فقط.",
                        "الاستهزاء بالسلعة أو المعلن.",
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildSectionCard(
                      context: context,
                      icon: Icons.message_outlined,
                      iconColor: Colors.purple,
                      title: "الرسائل الخاصة الممنوعة:",
                      subtitle: "القائمة التالية تحتوي على أغلب الرسائل الخاصة الممنوعة:",
                      items: [
                        "الإعلان في الرسائل الخاصة.",
                        "السب والشتم سواء كان هناك مبرر أم لم يكن هناك مبرر.",
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),

              // Warning Footer
              Container(
                margin: EdgeInsets.all(16),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.red.shade200, width: 1.5),
                ),
                child: Row(
                  children: [
                    Icon(Icons.warning_amber_rounded, color: Colors.red, size: 32),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        "تحذير: مخالفة هذه الشروط قد يؤدي إلى حظر دائم",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.red.shade900,
                          fontWeight: FontWeight.w600,
                          height: 1.4,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionCard({
    required BuildContext context,
    required IconData icon,
    required Color iconColor,
    required String title,
    String? content,
    String? subtitle,
    List<String>? items,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title with Icon
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: Textstylefont.sectionTitle(context).copyWith(
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
              SizedBox(width: 12),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 28,
                ),
              ),
            ],
          ),

          // Content
          if (content != null) ...[
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[200]!, width: 1),
              ),
              child: Text(
                content,
                style: Textstylefont.sectionSubtitle(context).copyWith(
                  height: 1.8,
                  fontSize: 15,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
          ],

          // Subtitle
          if (subtitle != null) ...[
            SizedBox(height: 16),
            Text(
              subtitle,
              style: Textstylefont.sectionSubtitle(context).copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
              textAlign: TextAlign.right,
            ),
          ],

          // Items List
          if (items != null) ...[
            SizedBox(height: 12),
            ...List.generate(items.length, (index) {
              return Container(
                margin: EdgeInsets.only(bottom: 10),
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: iconColor.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 2, left: 8),
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: iconColor,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        "${index + 1}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        items[index],
                        style: Textstylefont.sectionSubtitle(context).copyWith(
                          height: 1.6,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ],
      ),
    );
  }
}