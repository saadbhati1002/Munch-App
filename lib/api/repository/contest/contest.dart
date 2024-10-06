import 'dart:io';

import 'package:app/api/network/contest/contest.dart';
import 'package:dio/dio.dart';

class ContestRepository {
  Future<dynamic> getContestApiCall() async {
    return await ContestNetwork.getContest();
  }

  Future<dynamic> participateInContestApiCall(
      {String? contestID,
      String? title,
      String? description,
      File? media}) async {
    final param = FormData.fromMap({
      "id": contestID,
      "title": title,
      "description": description,
      "media": media != null
          ? await MultipartFile.fromFile(media.path,
              filename: media.path.split('/').last)
          : null,
    });
    return await ContestNetwork.participateInContest(param);
  }

  Future<dynamic> getContestParticipateApiCall({String? contestID}) async {
    return await ContestNetwork.getContestParticipate(contestID);
  }
}
