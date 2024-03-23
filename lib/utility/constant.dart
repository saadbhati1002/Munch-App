import 'package:app/models/user/user_model.dart';
import 'package:app/utility/color.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:share_plus/share_plus.dart';

class AppConstant {
  static const String appName = 'Munch Monday';
  static const String baseUrl = 'https://alghurfah.net/munch/public/api/';
  static const String imagePath = 'https://alghurfah.net/munch/public/';
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
      "I'm inviting you to use $appName, a simple and easy app to find new recipes and article. Here i am sending  you app link  https://alghurfah.net/munch/public/ - use it to download the app.";
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
