import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lahijcenter/core/sharde/widget/default_button.dart';

import '../../../../../core/constans/fonts.dart';
import '../../main/bottomNavbar/Bottomnav.dart';


class PasswordChangedSuccess extends StatelessWidget {
  const PasswordChangedSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 150.h,
              ),
              Image.asset("assets/image/circle-check.png"),
              SizedBox(
                height: 15.h,
              ),
              const Text("تم تحديث كلمة المرور بنجاح",
                  style:  TextStyle(  fontFamily: Fonts.font,
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w700)),
              SizedBox(
                height: 30.h,
              ),
              const SizedBox(
                height: 15,
              ),
              DefaultButton(
                  function: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) =>
                            const Bottomnav()));
                  },
                  text: 'حسناً')
            ],
          ),
        ),
      ),
    );
  }
}
