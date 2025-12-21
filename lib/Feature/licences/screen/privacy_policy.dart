import 'package:flutter/material.dart';
import '../../../core/Textstyle/text_style.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 3,
        shadowColor: Colors.black26,
        title: Text(
          "سياسة الخصوصية",
          style: Textstylefont.usetermsstyle(context),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: 22),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            // Header Card with Icon
            Container(
              width: double.infinity,
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.green,
                    Colors.green.shade600,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.green.withOpacity(0.3),
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
                      Icons.privacy_tip_outlined,
                      size: 48,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    "نحن نهتم بخصوصيتك",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "نلتزم بحماية بياناتك وحقوقك",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            // Content Cards
            _buildContentCard(
              context: context,
              icon: Icons.info_outline,
              iconColor: Colors.blue,
              title: "مقدمة",
              content:
              "إن اتفاقية الاستخدام هذه وخصوصية الاستخدام، والشروط والبنود، وجميع السياسات التي تم نشرها على موقع الحج دوت كوم وضعت لحماية وضبط حقوق كل من (لحج دوت كوم). "
                  "وضعت\n\n لحماية وحفظ حقوق كل من لحج دوت كوم والمستخدم الذي يصل إلى الموقع بتسجيل مجاناً أو من دون تسجيل. لكونك مستخدمًا، فإنك توافق على الالتزام بكل ما يرد بهذه الاتفاقية "
                  "في حال استخدامك للموقع لحج دوت كوم أو في حال الوصول إليه أو في حالة التسجيل في الخدمة. يحق لموقع لحج دوت كوم التعديل على هذه الاتفاقية في أي وقت وتعتبر ملزمة لجميع الأطراف بعد الإعلان.",
            ),

            _buildListCard(
              context: context,
              icon: Icons.rule_outlined,
              iconColor: Colors.orange,
              title: "شروط الاستخدام",
              items: [
                "عدم نشر أي إعلان أو تحميل محتوى أو عناصر غير ملائمة لتصنيفات المساحات في الموقع.",
                "عدم استخدام السلع المشبوهة كونها سلعًا أصلية.",
                "عدم التلاعب بأسعار السلع سواء في البيع أو الشراء وإلحاق الضرر بالمستخدمين الآخرين.",
                "عدم نشر إعلانات أو تعليقات كاذبة أو غير دقيقة أو مضللة أو خادعة أو قذف أو تشهير.",
                "عدم جمع معلومات عن مستخدمي الموقع إلا لغرض الأعمال التجارية أو إلحاق الضرر.",
                "عدم انتهاك حقوق ملكية الآخرين."
              ],
            ),

            _buildContentCard(
              context: context,
              icon: Icons.verified_user_outlined,
              iconColor: Colors.green,
              title: "مسؤولية موقع لحج دوت كوم",
              content:
              "يقدم موقع لحج دوت كوم خدمة للمستخدمين من خلال توفير بيئة آمنة للبيع والشراء.",
            ),

            SizedBox(height: 24),

            // Footer
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.green.shade200, width: 1.5),
              ),
              child: Row(
                children: [
                  Icon(Icons.check_circle, color: Colors.green, size: 28),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "باستخدامك للموقع فإنك توافق على هذه الشروط",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.green.shade900,
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
    );
  }

  Widget _buildContentCard({
    required BuildContext context,
    required IconData icon,
    required Color iconColor,
    required String title,
    required String content,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
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
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListCard({
    required BuildContext context,
    required IconData icon,
    required Color iconColor,
    required String title,
    required List<String> items,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
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
          SizedBox(height: 16),
          ...List.generate(items.length, (index) {
            return Container(
              margin: EdgeInsets.only(bottom: 12),
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
                textDirection: TextDirection.rtl,
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
      ),
    );
  }
}