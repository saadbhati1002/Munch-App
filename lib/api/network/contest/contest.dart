import 'package:app/api/http_manager.dart';

import 'package:app/models/contest/contest_model.dart';

class ContestNetwork {
  static const String contestUrl = "contests";
  static Future<dynamic> getContest() async {
    final result = await httpManager.get(url: contestUrl);
    ContestRes loginRes = ContestRes.fromJson(result);
    return loginRes;
  }
}
