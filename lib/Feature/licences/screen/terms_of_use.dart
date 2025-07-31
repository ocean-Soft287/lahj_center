import 'package:flutter/material.dart';
import 'package:lahijcenter/core/Textstyle/text_style.dart';
import 'package:lahijcenter/core/constans/app_colors.dart';


class TermsOfUse extends StatelessWidget {
  const TermsOfUse({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainAppColor,
        title:
        Text("شروط الاستخدام", style: Textstylefont.usetermsstyle(context)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                sectionTitle(context, "السلع الممنوعة:"),
                descriptionText(context,
                    "السلعة الموضحة هي السلع الممنوعة في الموقع لحج سنتر. هذه السلع ممنوع الإعلان عنها في الموقع و ممنوع أيضًا شرائها عبر الموقع. نحن نقوم بحظر المعلن الذي يقوم بالإعلان عن هذه السلع و نقوم بحظر من يتجاوب معه عبر الرسائل الخاصة أو عبر الردود. نرجو ملاحظة أن ليس هناك تنبيه قبل الحظر وأن الحظر نهائي."),
                sectionSubtitle(context, "السلع الممنوعة هي:"),
                numberedList(context, [
                  "المخدرات بكل أنواعها.",
                  "المنتجات الجنسية بكافة أشكالها وأنواعها.",
                  "صرف العملات بكل أنواعها.",
                ]),
                const SizedBox(height: 16),
                sectionTitle(context, "الردود الممنوعة:"),
                sectionSubtitle(context, "القائمة التالية تحتوي على أغلب الردود الممنوعة:"),
                numberedList(context, [
                  "الإعلان في الردود.",
                  "البخس.",
                  "السب والشتم سواء كان هناك مبرر أم لم يكن هناك مبرر.",
                  "عدم الجدية و عدم الرغبة في الشراء.",
                  "التعليق لأجل إضافة نكتة أو خبر. الموقع للبيع والشراء فقط.",
                  "الاستهزاء بالسلعة أو المعلن.",
                ]),
                const SizedBox(height: 16),
                sectionTitle(context, "الرسائل الخاصة الممنوعة:"),
                sectionSubtitle(context, "القائمة التالية تحتوي على أغلب الرسائل الخاصة الممنوعة:"),
                numberedList(context, [
                  "الإعلان في الرسائل الخاصة.",
                  "السب والشتم سواء كان هناك مبرر أم لم يكن هناك مبرر.",
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget sectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: Textstylefont.sectionTitle(context),
        textAlign: TextAlign.right,
      ),
    );
  }

  Widget sectionSubtitle(BuildContext context, String subtitle) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
      child: Text(
        subtitle,
        style: Textstylefont.sectionSubtitle(context),
        textAlign: TextAlign.right,
      ),
    );
  }

  Widget descriptionText(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: Textstylefont.sectionSubtitle(context),
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget numberedList(BuildContext context, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(items.length, (index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${index + 1} - ",
                style: Textstylefont.sectionSubtitle(context),
              ),
              Expanded(
                child: Text(
                  items[index],
                  style: Textstylefont.sectionSubtitle(context),
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
