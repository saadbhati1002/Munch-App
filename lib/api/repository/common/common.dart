import 'package:app/api/network/common/common.dart';

class CommonRepository {
  Future<dynamic> getFAQApiCall() async {
    return await CommonNetwork.getFAQ();
  }

  Future<dynamic> submitFeedbackApiCall(
      {String? rating, String? review}) async {
    final params = {"rating": rating, "review": review};
    return await CommonNetwork.feedback(params);
  }
}
