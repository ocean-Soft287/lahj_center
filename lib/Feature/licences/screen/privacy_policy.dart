import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/Textstyle/text_style.dart';
import '../../../core/constans/app_colors.dart';
import '../../../core/constans/fonts.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: AppColors.mainAppColor,
        elevation: 3,
        shadowColor: Colors.black26,
        title: Text(
          "سياسة الخصوصية والاستخدام",
          style: TextStyle(
            fontFamily: Fonts.font,
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
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
              margin: EdgeInsets.all(16.w),
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.mainAppColor,
                    AppColors.mainAppColor.withOpacity(0.8),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20.r),
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
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.privacy_tip_outlined,
                      size: 48.sp,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    "نحن نهتم بخصوصيتك",
                    style: TextStyle(
                      fontFamily: Fonts.font,
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    "نلتزم بحماية بياناتك وحقوقك",
                    style: TextStyle(
                      fontFamily: Fonts.font,
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
            ),

            // مقدمة
            _buildContentCard(
              context: context,
              icon: Icons.info_outline,
              iconColor: Colors.blue,
              title: "مقدمة",
              content:
              "إن اتفاقية الاستخدام هذه وخصوصية الاستخدام، والشروط والبنود، وجميع السياسات التي تم نشرها على تطبيق (لحج دوت كوم) وضعت لحماية وحفظ حقوق كل من (لحج دوت كوم) الذي يصل إلى التطبيق بتسجيل مجاناً أو من دون تسجيل. لكونك مستخدماً فأنك توافق على الالتزام بكل ما يرد بهذه الاتفاقية في حال استخدامك للتطبيق (لحج دوت كوم) أو في حال الوصول إليه أو في حالة التسجيل في الخدمة. يحق لتطبيق (لحج دوت كوم) التعديل على هذه الاتفاقية في أي وقت وتعتبر ملزمة لجميع الأطراف بعد الإعلان.",
            ),

            // شروط الاستخدام
            _buildListCard(
              context: context,
              icon: Icons.rule_outlined,
              iconColor: Colors.orange,
              title: "شروط الاستخدام",
              subtitle: "بصفتك طرف ثاني في هذه الاتفاقية فإنه بموافقتك على الاستفادة من خدمات التطبيق فعليك الالتزام بما يلي:",
              items: [
                "عدم نشر أي إعلان أو تحميل محتوى أو عناصر غير ملائمة للتصنيفات المتاحة في التطبيق والمسموح بها، سيتم حذفها من الموقع.",
                "بعدم استخدام السلع المقشوشة كونها سلع أصلية.",
                "بعدم التلاعب بأسعار السلع سواء في البيع أو الشراء وإلحاق الضرر بالمستخدمين الآخرين.",
                "بعدم نشر إعلانات أو تعليقات كاذبة أو غير دقيقة أو مضللة أو خادعة أو قذف، أو تشهير.",
                "بعدم جمع معلومات عن مستخدمي الموقع الآخرين لأغراض تجارية أو غيرها.",
                "بعدم انتهاك حقوق ملكية الآخرين."
              ],
            ),

            // مسؤولية التطبيق
            _buildContentCard(
              context: context,
              icon: Icons.business_center_outlined,
              iconColor: Colors.purple,
              title: "مسؤولية تطبيق لحج دوت كوم للتسويق الإلكتروني",
              content:
              "يقدم تطبيق (لحج دوت كوم) خدمة تمكين المستخدمين من عرض سلعتهم وفق السياسة المتفق عليها ولا نقدم أي ضمانات ولا نتحمل أي مسؤولية في حالة عدم التزام المستخدمين بسياسة استخدام التطبيق ولا نتحمل المسؤولية عن أي مخاطرة أو أضرار أو تبعات أو خسائر تقع على البائع أو المشتري أو أي طرف آخر.",
            ),

            // السياسة الأمنية
            _buildContentCard(
              context: context,
              icon: Icons.security_outlined,
              iconColor: Colors.red,
              title: "السياسة الأمنية تطبيق لحج دوت كوم للتسويق الإلكتروني",
              content:
              "تلتزم التطبيق لحج دوت كوم للتسويق الإلكتروني باتفاقية الاستخدام وخصوصية الاستخدام ولكننا لسنا طرفاً في أي خلاف أو قضايا تنشأ بين المستخدمين لمخالفة أحدهما أو كلاهما اتفاقية الاستخدام إلا أنه يسعى لتعزيز الجانب الأمني في التطبيق وذلك للحد والقضاء على التعديات التي يقوم بها بعض من مستخدمي التطبيق بشكل يخالف اتفاقية، سياسة، خصوصية وشروط الاستخدام وذلك تحقيقاً لنزاهة البيع والشراء ومحاربة النصب والاحتيال والغش.",
            ),

            // الخصوصية وبيان المعلومات
            _buildSectionTitle(
              context: context,
              icon: Icons.lock_outline,
              iconColor: Colors.teal,
              title: "الخصوصية وبيان المعلومات",
            ),

            _buildSimpleCard(
              context: context,
              content:
              "نقدر مخاوفكم واهتمامكم بشأن خصوصية بياناتكم على شبكة الإنترنت. لقد تم إعداد هذه السياسة لمساعدتكم في تفهم طبيعة البيانات التي نقوم بتجميعها منكم عند زيارتكم تطبيقنا على شبكة الانترنت وكيفية تعاملنا مع هذه البيانات الشخصية.",
            ),

            // التصفح
            _buildSubSectionCard(
              context: context,
              title: "التصفح",
              content:
              "لم نقم بتصميم هذا التطبيق من أجل تجميع بياناتك الشخصية من جهاز الجوال أو الكمبيوتر الخاص بك أثناء تصفحك لهذا التطبيق.",
            ),

            // عنوان بروتوكول شبكة الإنترنت
            _buildSubSectionCard(
              context: context,
              title: "عنوان بروتوكول شبكة الإنترنت (IP)",
              content:
              "في أي وقت تزور فيه أي موقع انترنت بما فيها هذا الموقع، سيقوم السيرفر المضيف بتسجيل عنوان بروتوكول شبكة الإنترنت (IP) الخاص بك، تاريخ ووقت الزيارة ونوع متصفح الإنترنت الذي تستخدمه والعنوان URL الخاص بأي موقع من مواقع الإنترنت التي تقوم بإحالتك إلى هذا الموقع على الشبكة.",
            ),

            // عمليات المسح على الشبكة
            _buildSubSectionCard(
              context: context,
              title: "عمليات المسح على الشبكة",
              content:
              "إن عمليات المسح التي نقوم بها مباشرة على الشبكة تمكننا من تجميع بيانات محددة مثل البيانات المطلوبة منك بخصوص نظرتك وشعورك تجاه تطبيقنا. تعتبر ردودك ذات أهمية قصوى، ومحل تقديرنا حيث أنها تمكننا من تحسين مستوى التطبيق، ولك كامل الحرية والاختيار في تقديم البيانات المتعلقة بإسمك والبيانات الأخرى.",
            ),

            // الروابط بالمواقع الأخرى
            _buildSubSectionCard(
              context: context,
              title: "الروابط بالمواقع الأخرى على شبكة الإنترنت",
              content:
              "قد يشتمل موقعنا أو تطبيقنا على روابط لتطبيقات أخرى على شبكة الإنترنت أو إعلانات من مواقع أخرى ولا نعتبر مسؤولين عن أساليب تجميع البيانات من قبل تلك المواقع، يمكنك الاطلاع على سياسات السرية والمحتويات الخاصة بتلك المواقع التي يتم الدخول إليها من خلال أي رابط ضمن هذا الموقع.\n\nنحن قد نستعين بشركات إعلان لأطراف ثالثة لعرض الإعلانات عندما تزور موقعنا على الويب. يحق لهذه الشركات أن تستخدم معلومات حول زياراتك لهذا الموقع ولمواقع الويب الأخرى (باستثناء الاسم أو العنوان أو عنوان البريد الإلكتروني أو رقم الهاتف)، وذلك من أجل تقديم إعلانات حول البضائع والخدمات التي تهمك.",
            ),

            // إفشاء المعلومات
            _buildSubSectionCard(
              context: context,
              title: "إفشاء المعلومات",
              content:
              "سنحافظ في كافة الأوقات على خصوصية وسرية كافة البيانات الشخصية التي نتحصل عليها. ولن يتم إفشاء هذه المعلومات إلا إذا كان ذلك مطلوباً بموجب أي قانون أو عندما نعتقد بحسن نية أن مثل هذا الإجراء سيكون مطلوباً أو مرغوباً فيه للتمشي مع القانون، أو للدفاع عن أو حماية حقوق الملكية الخاصة بهذا الموقع أو الجهات المستفيدة منه.",
            ),

            // البيانات اللازمة لتنفيذ المعاملات
            _buildSubSectionCard(
              context: context,
              title: "البيانات اللازمة لتنفيذ المعاملات المطلوبة من قبلك",
              content:
              "عندما نحتاج إلى أية بيانات خاصة بك، فإننا سنطلب منك تقديمها بمحض إرادتك. حيث ستساعدنا هذه المعلومات في الاتصال بك وتنفيذ طلباتك حيثما كان ذلك ممكناً. لن يتم إطلاقاً بيع البيانات المقدمة من قبلك إلى أي طرف ثالث بغرض تسويقها لمصلحته الخاصة دون الحصول على موافقتك المسبقة والمكتوبة ما لم يتم ذلك على أساس أنها ضمن بيانات جماعية تستخدم للأغراض الإحصائية والأبحاث دون اشتمالها على أية بيانات من الممكن استخدامها للتعريف بك.",
            ),

            // عند الاتصال بنا
            _buildSubSectionCard(
              context: context,
              title: "عند الاتصال بنا",
              content:
              "سيتم التعامل مع كافة البيانات المقدمة من قبلك على أساس أنها سرية. تتطلب النماذج التي يتم تقديمها مباشرة على الشبكة تقديم البيانات التي ستساعدنا في تحسين موقعنا. سيتم استخدام البيانات التي يتم تقديمها من قبلك في الرد على كافة استفساراتك، ملاحظاتك، أو طلباتك من قبل هذا الموقع أو أياً من المواقع التابعة.",
            ),

            // إفشاء المعلومات لأي طرف ثالث
            _buildSubSectionCard(
              context: context,
              title: "إفشاء المعلومات لأي طرف ثالث",
              content:
              "لن نقوم ببيع، المتاجرة، تأجير، أو إفشاء أية معلومات لمصلحة أي طرف ثالث خارج هذا الموقع، أو المواقع التابعة له. وسيتم الكشف عن المعلومات فقط في حالة صدور أمر بذلك من قبل أي سلطة قضائية.",
            ),

            // التعديلات على سياسة السرية
            _buildSubSectionCard(
              context: context,
              title: "التعديلات على سياسة سرية وخصوصية المعلومات",
              content:
              "نحتفظ بالحق في تعديل بنود وشروط سياسة سرية وخصوصية المعلومات إن لزم الأمر ومتى كان ذلك ملائماً. سيتم تنفيذ التعديلات هنا أو على صفحة سياسة الخصوصية الرئيسية وسيتم بصفة مستمرة إخطارك بالبيانات التي حصلنا عليها، وكيف سنستخدمها والجهة التي سنقوم بتزويدها بهذه البيانات.",
            ),

            // أخيراً
            _buildSubSectionCard(
              context: context,
              title: "أخيراً",
              content:
              "إن مخاوفك واهتمامك بشأن سرية وخصوصية البيانات تعتبر مسألة في غاية الأهمية بالنسبة لنا. نحن نأمل أن يتم تحقيق ذلك من خلال هذه السياسة.\n\nشاكرين ومقدرين حسن تعاونكم معنا،،،",
            ),

            SizedBox(height: 24.h),

            // Footer
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.w),
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.mainAppColor.withOpacity(0.1),
                    AppColors.mainAppColor.withOpacity(0.05),
                  ],
                ),
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(
                  color: AppColors.mainAppColor.withOpacity(0.3),
                  width: 1.5,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.check_circle,
                    color: AppColors.mainAppColor,
                    size: 28.sp,
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(
                      "باستخدامك للتطبيق فإنك توافق على هذه الشروط",
                      style: TextStyle(
                        fontFamily: Fonts.font,
                        fontSize: 14.sp,
                        color: AppColors.mainAppColor,
                        fontWeight: FontWeight.w600,
                        height: 1.4,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 32.h),
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
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
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
                  style: TextStyle(
                    fontFamily: Fonts.font,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
              SizedBox(width: 12.w),
              Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 28.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.grey[200]!, width: 1),
            ),
            child: Text(
              content,
              style: TextStyle(
                fontFamily: Fonts.font,
                height: 1.8,
                fontSize: 14.sp,
                color: Colors.black87,
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
    required String subtitle,
    required List<String> items,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
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
                  style: TextStyle(
                    fontFamily: Fonts.font,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
              SizedBox(width: 12.w),
              Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 28.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            subtitle,
            style: TextStyle(
              fontFamily: Fonts.font,
              fontSize: 14.sp,
              color: Colors.grey[700],
              height: 1.6,
            ),
            textAlign: TextAlign.right,
          ),
          SizedBox(height: 16.h),
          ...List.generate(items.length, (index) {
            return Container(
              margin: EdgeInsets.only(bottom: 12.h),
              padding: EdgeInsets.all(14.w),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(12.r),
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
                    margin: EdgeInsets.only(top: 2.h, left: 8.w),
                    padding: EdgeInsets.all(6.w),
                    decoration: BoxDecoration(
                      color: iconColor,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      "${index + 1}",
                      style: TextStyle(
                        fontFamily: Fonts.font,
                        color: Colors.white,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      items[index],
                      style: TextStyle(
                        fontFamily: Fonts.font,
                        height: 1.6,
                        fontSize: 13.sp,
                        color: Colors.black87,
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

  Widget _buildSectionTitle({
    required BuildContext context,
    required IconData icon,
    required Color iconColor,
    required String title,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            iconColor.withOpacity(0.1),
            iconColor.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: iconColor.withOpacity(0.3),
          width: 1.5,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontFamily: Fonts.font,
                fontSize: 17.sp,
                fontWeight: FontWeight.bold,
                color: iconColor,
              ),
              textAlign: TextAlign.right,
            ),
          ),
          SizedBox(width: 12.w),
          Icon(
            icon,
            color: iconColor,
            size: 26.sp,
          ),
        ],
      ),
    );
  }

  Widget _buildSimpleCard({
    required BuildContext context,
    required String content,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        content,
        style: TextStyle(
          fontFamily: Fonts.font,
          height: 1.8,
          fontSize: 14.sp,
          color: Colors.black87,
        ),
        textAlign: TextAlign.right,
      ),
    );
  }

  Widget _buildSubSectionCard({
    required BuildContext context,
    required String title,
    required String content,
  }) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
    padding: EdgeInsets.all(16.w),
    decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(12.r),
    border: Border.all(
    color: Colors.grey[200]!,
    width: 1,
    ),
    boxShadow: [
    BoxShadow(
    color: Colors.black.withOpacity(0.03),
    blurRadius: 6,
    offset: Offset(0, 2),
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
    style: TextStyle(
    fontFamily: Fonts.font,
    fontSize: 15.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.mainAppColor,
    ),
    textAlign: TextAlign.right,
    ),
    ),
    SizedBox(width: 8.w),
    Icon(
    Icons.circle,
    size: 8.sp,
    color: AppColors.mainAppColor,
    ),
    ],
    ),
      SizedBox(height: 10.h),
      Text(
        content,
        style: TextStyle(
          fontFamily: Fonts.font,
          height: 1.7,
          fontSize: 14.sp,
          color: Colors.black87,
        ),
        textAlign: TextAlign.right,
      ),
    ],
    ));
  }
}