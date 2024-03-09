import 'package:app/api/network/banner/banner.dart';

class BannerRepository {
  Future<dynamic> getBannerApiCall() async {
    return await BannerNetwork.getBanners();
  }
}
