import 'package:app/api/http_manager.dart';
import 'package:app/models/user/user_model.dart';

class AuthNetwork {
  static const String registerUserUrl = "register";
  static Future<dynamic> registerUser(prams) async {
    print(prams);
    final result = await httpManager.post(url: registerUserUrl, data: prams);

    UserRes loginRes = UserRes.fromJson(result);
    return loginRes;
  }
}
