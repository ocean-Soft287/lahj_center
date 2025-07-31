import 'package:flutter/material.dart';
import '../../../core/Textstyle/text_style.dart';


class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title:  Text(
          "سياسة الخصوصية",
          style: Textstylefont.usetermsstyle(context)
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sectionTitle("مقدمة",context),
              descriptionText(
                  "إن اتفاقية الاستخدام هذه وخصوصية الاستخدام، والشروط والبنود، وجميع السياسات التي تم نشرها على موقع الحج سنتر وضعت لحماية وضبط حقوق كل من (لحج سنتر). "
                      "وضعت\n\n لحماية وحفظ حقوق كل من لحج سنتر والمستخدم الذي يصل إلى الموقع بتسجيل مجاناً أو من دون تسجيل. لكونك مستخدمًا، فإنك توافق على الالتزام بكل ما يرد بهذه الاتفاقية "
                      "في حال استخدامك للموقع لحج سنتر أو في حال الوصول إليه أو في حالة التسجيل في الخدمة. يحق لموقع لحج سنتر التعديل على هذه الاتفاقية في أي وقت وتعتبر ملزمة لجميع الأطراف بعد الإعلان."
              ,context),

              const SizedBox(height: 16),

              sectionTitle("شروط الاستخدام",context),
              numberedList([
                "عدم نشر أي إعلان أو تحميل محتوى أو عناصر غير ملائمة لتصنيفات المساحات في الموقع.",
                "عدم استخدام السلع المشبوهة كونها سلعًا أصلية.",
                "عدم التلاعب بأسعار السلع سواء في البيع أو الشراء وإلحاق الضرر بالمستخدمين الآخرين.",
                "عدم نشر إعلانات أو تعليقات كاذبة أو غير دقيقة أو مضللة أو خادعة أو قذف أو تشهير.",
                "عدم جمع معلومات عن مستخدمي الموقع إلا لغرض الأعمال التجارية أو إلحاق الضرر.",
                "عدم انتهاك حقوق ملكية الآخرين."
              ],context),

              const SizedBox(height: 16),

              sectionTitle("مسؤولية موقع لحج سنتر",context),
              descriptionText(
                  "يقدم موقع لحج سنتر خدمة للمستخدمين من خلال توفير بيئة آمنة للبيع والشراء."
              ,context),
            ],
          ),
        ),
      ),
    );
  }

  Widget sectionTitle(String title,BuildContext context) {
    return Padding(
      padding:  const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style:Textstylefont.sectionTitle(context),
        textAlign: TextAlign.right,
      ),
    );
  }

  Widget descriptionText(String text,BuildContext context) {
    return Text(
      text,
      style:Textstylefont.sectionSubtitle(context),
      textAlign: TextAlign.right,
    );
  }

  Widget numberedList(List<String> items,BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: List.generate(items.length, (index) {
        return Padding(
          padding:  const EdgeInsets.symmetric(vertical: 4.0),
          child: Align(
            alignment: Alignment.centerRight,
            child: RichText(
              text: TextSpan(
                style:Textstylefont.sectionSubtitle(context),
                children: [
                  TextSpan(
                    text: "${index + 1}- ",
                    style:Textstylefont.sectionSubtitle(context),                  ),
                  TextSpan(text: items[index]),
                ],
              ),
              textAlign: TextAlign.right,
            ),
          ),
        );
      }),
    );
  }
}
