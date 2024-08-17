import 'package:app/api/http_manager.dart';
import 'package:app/models/common_model.dart';
import 'package:app/models/faq/faq_model.dart';

class CommonNetwork {
  static const String faqUrl = "faq";
  static const String feedbackUrl = "feedback";
  static Future<dynamic> getFAQ() async {
    final result = await httpManager.get(url: faqUrl);

    FAQRes response = FAQRes.fromJson(result);
    return response;
  }

  static Future<dynamic> feedback(params) async {
    final result = await httpManager.post(url: feedbackUrl, data: params);
    CommonRes response = CommonRes.fromJson(result);
    return response;
  }
}
