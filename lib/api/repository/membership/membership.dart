import 'package:app/api/network/membership/membership.dart';

class MembershipRepository {
  Future<dynamic> getMyMembershipApiCall() async {
    return await MembershipNetwork.getMyMembership();
  }
}
