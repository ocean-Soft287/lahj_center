import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Home/presentaion/screen/chat/presentation/chat_screen.dart';
import '../../../Home/presentaion/screen/home_screen_wi.dart';
import '../widget/drawer.dart';
import '../widget/screen/inbox_screen.dart';
import '../widget/screen/notification_screen.dart';

import 'Bottom_state.dart';

class Bottomcubit extends Cubit<Bottomstate> {
  Bottomcubit() : super(InitializeHome());

  int currentIndex = 0;
  changeSelectIndexBottom({required int index}) {
    currentIndex = index;
    emit(ChangeIndexBottom());
  }

  List<Widget> get screen => [
    const HomeScreenWi(),
     ChatListScreen(),
    const NotificationScreen(),
    Customdrawer(),
  ];

  Future<void> whatsapp() async {
    final Uri url = Uri.parse("https://wa.me/+966783616108");
    if (await canLaunchUrl(url)) {
      launchUrl(url);
    } else {
      throw Exception("Could not launch $url");
    }
  }

  Future<void> whatsappuser(String number) async {
    final Uri url = Uri.parse("https://wa.me/+$number");
    if (await canLaunchUrl(url)) {
      launchUrl(url);
    } else {
      throw Exception("Could not launch $url");
    }
  }

  Future<void> calling() async {
    final Uri url = Uri.parse("tel:+966783616108");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw Exception("Could not launch $url");
    }
  }

  Future<void> callinguser(String number) async {
    final Uri url = Uri.parse("tel:+$number");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw Exception("Could not launch $url");
    }
  }

  Future<void> shareFacebook() async {
    final Uri url = Uri.parse("https://www.facebook.com/share/1A3uS6jmfT/");
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw Exception("Could not launch $url");
    }
  }

  Future<void> sendhi(String number) async {
    final Uri url = Uri.parse('sms:$number}');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw Exception('Could not launch $url');
    }
  }

  int categoryIndex = 0;
  changeSelectCategory({required int index}) {
    categoryIndex = index;
    emit(ChangeCategoryIndex());
  }
}
