import 'package:app/api/http_manager.dart';
import 'package:app/models/user/user_model.dart';

class AuthNetwork {
  static const String registerUserUrl = "register";
  static const String loginUserUrl = "login";
  static const String userUpdateUrl = "user/update";
  static Future<dynamic> registerUser(prams) async {
    final result = await httpManager.post(url: registerUserUrl, data: prams);

    UserRes loginRes = UserRes.fromJson(result);
    return loginRes;
  }

  static Future<dynamic> loginUser(prams) async {
    final result = await httpManager.post(url: loginUserUrl, data: prams);

    UserRes loginRes = UserRes.fromJson(result);
    return loginRes;
  }

  static Future<dynamic> updateUserUser(prams) async {
    final result = await httpManager.post(url: userUpdateUrl, data: prams);

    UserRes loginRes = UserRes.fromJson(result);
    return loginRes;
  }
}
