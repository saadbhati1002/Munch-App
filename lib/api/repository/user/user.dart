import 'package:app/api/network/user/user.dart';

class UserRepository {
  Future<dynamic> getUserApiCall() async {
    return await UserNetwork.getAdminUsers();
  }

  Future<dynamic> getUserByIdApiCall({String? userID}) async {
    return await UserNetwork.getUserByID(userID);
  }
}
