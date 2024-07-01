import 'package:app/api/http_manager.dart';
import 'package:app/models/common_model.dart';
import 'package:app/models/user/user_model.dart';

class AuthNetwork {
  static const String registerUserUrl = "register";
  static const String loginUserUrl = "login";
  static const String userUpdateUrl = "user/update";
  static const String changePasswordUrl = "password/change";
  static Future<dynamic> registerUser(prams) async {
    final result = await httpManager.post(url: registerUserUrl, data: prams);

    UserRes response = UserRes.fromJson(result);
    return response;
  }

  static Future<dynamic> loginUser(prams) async {
    final result = await httpManager.post(url: loginUserUrl, data: prams);

    UserRes response = UserRes.fromJson(result);
    return response;
  }

  static Future<dynamic> updateUserUser(prams) async {
    final result = await httpManager.post(url: userUpdateUrl, data: prams);
    print(result);
    UserRes response = UserRes.fromJson(result);
    return response;
  }

  static Future<dynamic> userChangePassword(prams) async {
    final result = await httpManager.post(url: changePasswordUrl, data: prams);

    CommonRes response = CommonRes.fromJson(result);
    return response;
  }
}
