import 'package:app/api/http_manager.dart';

import 'package:app/models/membership/my_membership/my_membership_model.dart';

class MembershipNetwork {
  static const String myMembershipUrl = "subscriptions";
  static Future<dynamic> getMyMembership() async {
    final result = await httpManager.get(url: myMembershipUrl);
    MyMembershipRes loginRes = MyMembershipRes.fromJson(result);
    return loginRes;
  }
}
