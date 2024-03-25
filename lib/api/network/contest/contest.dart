import 'package:app/api/http_manager.dart';
import 'package:app/models/common_model.dart';

import 'package:app/models/contest/contest_model.dart';

class ContestNetwork {
  static const String contestUrl = "contests";
  static const String participateInContestUrl = "participate";
  static Future<dynamic> getContest() async {
    final result = await httpManager.get(url: contestUrl);
    ContestRes loginRes = ContestRes.fromJson(result);
    return loginRes;
  }

  static Future<dynamic> participateInContest(params) async {
    final result =
        await httpManager.post(url: participateInContestUrl, data: params);
    CommonRes response = CommonRes.fromJson(result);
    return response;
  }
}
