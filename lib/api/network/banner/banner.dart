import 'package:app/api/http_manager.dart';
import 'package:app/models/banner/banner_model.dart';

class BannerNetwork {
  static const String bannerUrl = "banner";
  static Future<dynamic> getBanners() async {
    final result = await httpManager.get(url: bannerUrl);
    BannerRes response = BannerRes.fromJson(result);
    return response;
  }
}
