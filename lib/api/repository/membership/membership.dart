import 'package:app/api/network/membership/membership.dart';

class MembershipRepository {
  Future<dynamic> getMembershipListApiCall() async {
    return await MembershipNetwork.getMembershipList();
  }

  Future<dynamic> getMyMembershipApiCall() async {
    return await MembershipNetwork.getMyMembership();
  }
}
