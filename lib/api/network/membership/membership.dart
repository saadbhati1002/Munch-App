import 'package:app/api/http_manager.dart';
import 'package:app/models/common_model.dart';
import 'package:app/models/membership/list/membership_list_model.dart';

import 'package:app/models/membership/my_membership/my_membership_model.dart';

class MembershipNetwork {
  static const String membershipListUrl = "plan";
  static const String myMembershipUrl = "subscriptions";
  static const String byMemberShipUrl = "subscription";

  static Future<dynamic> getMembershipList() async {
    final result = await httpManager.get(url: membershipListUrl);

    MembershipRes response = MembershipRes.fromJson(result);
    return response;
  }

  static Future<dynamic> getMyMembership() async {
    final result = await httpManager.get(url: myMembershipUrl);
    MyMembershipRes response = MyMembershipRes.fromJson(result);
    return response;
  }

  static Future<dynamic> byMemberShip(param) async {
    final result = await httpManager.post(url: byMemberShipUrl, data: param);
    CommonRes response = CommonRes.fromJson(result);
    return response;
  }
}
