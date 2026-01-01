import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditAdReplySettings extends StatelessWidget {
  final bool? isReplyClosed;
  final Function(bool?) onChanged;
  final Color green;

  const EditAdReplySettings({
    super.key,
    required this.isReplyClosed,
    required this.onChanged,
    required this.green,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 100.w, child: label('اغلاق الردود', green)),
            Radio<bool>(
              value: true,
              groupValue: isReplyClosed,
              onChanged: onChanged,
              activeColor: green,
            ),
            const Text("نعم"),
            SizedBox(width: 20.w),
            Radio<bool>(
              value: false,
              groupValue: isReplyClosed,
              onChanged: onChanged,
              activeColor: green,
            ),
            const Text("لا"),
          ],
        ),
        const Divider(color: Color(0xff868686), thickness: 1.5),
      ],
    );
  }

  Widget label(String text, Color color) => Center(
    child: Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 12.sp,
        color: color,
      ),
      textAlign: TextAlign.center,
    ),
  );
}
