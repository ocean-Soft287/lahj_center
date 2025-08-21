import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lahijcenter/Feature/my_ads/presentaion/widget/radio_option.dart';

import '../../../../core/constans/fonts.dart';
import '../../../../core/constans/responsve_font.dart';
import '../../../../core/sharde/widget/default_button.dart';
import '../../mange/myadd_cubit.dart';
import 'custom_delete_success_dialog.dart';

class DeleteAdDialog extends StatefulWidget {
  const DeleteAdDialog({super.key, required this.id});
  final int id;

  @override
  State<DeleteAdDialog> createState() => _DeleteAdDialogState();
}

class _DeleteAdDialogState extends State<DeleteAdDialog> {
  String? selectedReason;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MyaddCubit, MyaddState>(
      listener: (context, state) {
        if (state is Deletemyadditemsuccful) {
          Navigator.pop(context); // close the delete dialog
          showDialog(
            context: context,
            builder: (context) => const CustomDeleteSuccessDialog(),
          );
        }
      },
      builder: (context, state) {
        MyaddCubit myaddCubit = context.read<MyaddCubit>();

        return AlertDialog(
          titlePadding: const EdgeInsets.all(8),
          title: IconButton(
            alignment: Alignment.topLeft,
            icon: const Icon(Icons.close, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "لماذا تريد حذف اعلانك ؟",
                style: TextStyle(
                  fontFamily: Fonts.font,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: getFontSize(context, 14),
                ),
              ),
              const SizedBox(height: 20),
              RadioOption(
                title: "تم البيع في لحج دوت كوم",
                isSelected: selectedReason == "تم البيع في لحج دوت كوم",
                onChanged: (value) {
                  setState(() {
                    selectedReason = "تم البيع في لحج دوت كوم";
                  });
                },
              ),
              RadioOption(
                title: "تم البيع خارج لحج دوت كوم",
                isSelected: selectedReason == "تم البيع خارج لحج دوت كوم",
                onChanged: (value) {
                  setState(() {
                    selectedReason = "تم البيع خارج لحج دوت كوم";
                  });
                },
              ),
              RadioOption(
                title: "لم اعد مهتماً بالبيع",
                isSelected: selectedReason == "لم اعد مهتماً بالبيع",
                onChanged: (value) {
                  setState(() {
                    selectedReason = "لم اعد مهتماً بالبيع";
                  });
                },
              ),
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xfffcd7da),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                child: Row(
                  children: [
                    const Icon(Icons.error_outline, color: Colors.red),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        "اذا حذفت هذا الإعلان , لن تتمكن من نشر إعلان جديد قبل 2 ساعات",
                        style: TextStyle(
                          fontFamily: Fonts.font,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: getFontSize(context, 14),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          actions: [
            const SizedBox(height: 20),
            Center(
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width * .25,
                height: 35,
                child: DefaultButton(
                  function: () {
                    if (selectedReason != null) {
                      myaddCubit.deletemyadd(widget.id, selectedReason!);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("من فضلك اختر سبب الحذف")),
                      );
                    }
                  },
                  text: "حذف",
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
