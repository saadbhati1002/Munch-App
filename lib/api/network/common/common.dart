import 'package:app/api/http_manager.dart';
import 'package:app/models/faq/faq_model.dart';

class CommonNetwork {
  static const String faqUrl = "faq";
  static Future<dynamic> getFAQ() async {
    final result = await httpManager.get(url: faqUrl);
    FAQRes response = FAQRes.fromJson(result);
    return response;
  }
}
