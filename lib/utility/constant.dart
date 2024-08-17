import 'package:app/models/user/user_model.dart';
import 'package:app/utility/color.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:share_plus/share_plus.dart';

// http://13.200.250.55
// https://alghurfah.net/munch/public/
class AppConstant {
  static const String appName = 'Munch Monday';
  static int pageAnimationDuration = 300;
  static const String stripePublic =
      'pk_live_51PKbcOSByjgYxhiE8mZfBsZCJHTeMVNA1iWrLKHaguuRT5PjWzkKwnfKnIjsTcN0RIIL0s13AiY784m5U8YuK2ze00BoYLYJPh';
  static const String stripeSecretKey =
      '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';
  static const String baseUrl = 'http://13.200.250.55/api/';
  static const String imagePath =
      'https://munch-media.s3.ap-south-1.amazonaws.com/';
  static const String instagramUrl = 'https://www.instagram.com/';
  static const String facebookUrl = 'https://www.facebook.com/';
  static const String whatsAppUrl = 'https://wa.me/+971 50 348 2117?text=';
  static String bearerToken = "null";
  static UserData? userData;
  static userDetailSaved(String userDetail) async {
    final pref = await SharedPreferences.getInstance();
    pref.setString('userDetail', userDetail);
  }

  static Future getUserDetail() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString('userDetail');
  }

  static String appShareMessage =
      "I'm inviting you to use $appName, a simple and easy app to find new recipes and Community. Here i am sending  you app link  https://alghurfah.net/munch/public/ - use it to download the app.";
  static Future shareAppLink() async {
    return Share.share(appShareMessage);
  }
}

toastShow({String? message}) {
  return Fluttertoast.showToast(
      msg: message!,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: ColorConstant.mainColor,
      textColor: ColorConstant.white,
      fontSize: 16.0);
}
