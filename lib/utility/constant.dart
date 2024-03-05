import 'package:app/models/user/user_model.dart';
import 'package:app/utility/color.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppConstant {
  static const String appName = 'Munch Monday';
  static const String baseUrl = 'https://alghurfah.net/munch/public/api/';
  static const String imagePath = 'https://alghurfah.net/munch/public/';
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
