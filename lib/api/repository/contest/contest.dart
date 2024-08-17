import 'package:app/api/network/contest/contest.dart';

class ContestRepository {
  Future<dynamic> getContestApiCall() async {
    return await ContestNetwork.getContest();
  }

  Future<dynamic> participateInContestApiCall({String? contestID}) async {
    final param = {"id": contestID};
    return await ContestNetwork.participateInContest(param);
  }

  Future<dynamic> getContestParticipateApiCall({String? contestID}) async {
    return await ContestNetwork.getContestParticipate(contestID);
  }
}
