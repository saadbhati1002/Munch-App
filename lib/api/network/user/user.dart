import 'package:app/api/http_manager.dart';
import 'package:app/models/user/admin_user/admin_model.dart';

class UserNetwork {
  static const String adminUsersUrl = "admin/user";
  static Future<dynamic> getAdminUsers() async {
    final result = await httpManager.get(url: adminUsersUrl);
    AdminRes loginRes = AdminRes.fromJson(result);
    return loginRes;
  }
}
