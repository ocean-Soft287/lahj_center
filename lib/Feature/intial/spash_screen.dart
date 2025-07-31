
import 'package:flutter/material.dart';
import 'package:lahijcenter/Feature/intial/welcome_screen.dart';

import '../../core/constans/app_assets.dart';
import '../../core/constans/constants.dart';
import '../../core/sharde/widget/navigation.dart';




class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds:5 ),(){
      if(customerID!=null)
        {

    //      navigatofinsh(context,  HomeScreen(), false);
          navigatofinsh(context,const   WelcomeScreen(), false);

        }
      else
        {

          navigatofinsh(context, const  WelcomeScreen(), false);

        }



    },);
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
       color: Colors.white,
        child: TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: -1, end: 0),
          duration: const Duration(seconds: 3),
          builder: (context, value, child) {
            return Transform.translate(
              offset: Offset(0, value * MediaQuery.of(context).size.height),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: Padding(
                    padding:const EdgeInsets.symmetric(horizontal: 50),
                    child: Image.asset(AppAssets.splashLogo),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
