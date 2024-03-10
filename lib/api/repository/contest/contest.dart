import 'package:app/api/network/contest/contest.dart';

class ContestRepository {
  Future<dynamic> getContestApiCall() async {
    return await ContestNetwork.getContest();
  }
}
