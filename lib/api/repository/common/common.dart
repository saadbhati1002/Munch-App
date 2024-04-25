import 'package:app/api/network/common/common.dart';

class CommonRepository {
  Future<dynamic> getFAQApiCall() async {
    return await CommonNetwork.getFAQ();
  }
}
