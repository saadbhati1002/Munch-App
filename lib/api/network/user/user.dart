import 'package:app/api/http_manager.dart';
import 'package:app/models/user/admin_user/admin_model.dart';
import 'package:app/models/user/user_model.dart';

class UserNetwork {
  static const String adminUsersUrl = "admin/user";
  static const String userDetailUrl = "get/user?id=";
  static Future<dynamic> getAdminUsers() async {
    final result = await httpManager.get(url: adminUsersUrl);
    AdminRes response = AdminRes.fromJson(result);
    return response;
  }

  static Future<dynamic> getUserByID(id) async {
    final result = await httpManager.get(url: "$userDetailUrl$id");
    UserRes response = UserRes.fromJson(result);
    return response;
  }
}
