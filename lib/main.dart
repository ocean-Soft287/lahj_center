import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:device_preview/device_preview.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'Feature/Home/presentaion/screen/item_details_screen.dart';
import 'Feature/intial/welcome_screen.dart';
import 'Feature/main/bottomNavbar/Bottomnav.dart';
import 'core/constans/bloc_observer.dart';
import 'core/constans/constants.dart';
import 'core/network/local/chachehelper.dart';
import 'core/network/local/flutter_secure_storage.dart';
import 'core/sharde/widget/navigation.dart';
import 'core/utils/notifications/notifcations.dart';
import 'core/utils/services/services_locator.dart';
import 'firebase_options.dart';
Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  setup();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await EasyLocalization.ensureInitialized();
  await CacheHelper.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FcmApi().initNotifications();
  await Hive.initFlutter();

  currentLang = CacheHelper.getData(key: 'changeLang') ?? 'ar';

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      fallbackLocale: const Locale('ar'),
      startLocale: const Locale('ar'),
      path: 'assets/lang',
      child: MyApp(locale: Locale(currentLang!)),
    ),
  );
}

class MyApp extends StatelessWidget {
  final Locale locale;

  const MyApp({super.key, required this.locale});

  @override
  Widget build(BuildContext context) {
    return DevicePreview(
      enabled: false,
      builder: (context) => ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        child: MaterialApp(
          builder: DevicePreview.appBuilder,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          debugShowCheckedModeBanner: false,
          home: const StartApp(),
        ),
      ),
    );
  }
}

class StartApp extends StatefulWidget {
  const StartApp({super.key});

  @override
  State<StartApp> createState() => _StartAppState();
}

class _StartAppState extends State<StartApp> {
  StreamSubscription<Uri>? _sub;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkLoginAndNavigate();
    });
  }

  void _handleLink(Uri uri) {
    if (uri.pathSegments.contains('Advertisements')) {
      final id = uri.pathSegments.last;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => ItemDetailsScreen(x: int.parse(id)),
        ));
      });
    }
  }

  Future<void> _checkLoginAndNavigate() async {
    final token = await SecureStorageService.read(SecureStorageService.token);

    FlutterNativeSplash.remove();

    // Debug
    print("TOKEN: $token");

    if (token != null && token.isNotEmpty) {
      navigatofinsh(context, const Bottomnav(), false);
    } else {
      navigatofinsh(context, const WelcomeScreen(), false);
    }
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}