
import 'package:share_plus/share_plus.dart';

abstract interface class ShareAppHelper {
  static Future<void> shareAndroidAppLink() async {
    const androidAppLink =
        'https://play.google.com/store/apps/details?id=YOUR_PACKAGE_NAME';

    final message =
        'Check out this amazing app!\n'
        ' $androidAppLink';

    await Share.share(( message));
  }
  static Future<void> shareIOSAppLink() async {

    const iosAppLink = 'https://apps.apple.com/app/YOUR_APP_ID';


    final message =
        'Check out this amazing app!\n'
        ' $iosAppLink';

    await Share.share(( message));
  }
}
