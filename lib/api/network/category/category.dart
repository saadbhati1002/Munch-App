import 'package:app/api/http_manager.dart';
import 'package:app/models/category/category_model.dart';

class CategoryNetwork {
  static const String categoryUrl = "categories";
  static Future<dynamic> getCategory() async {
    final result = await httpManager.get(url: categoryUrl);
    CategoryRes loginRes = CategoryRes.fromJson(result);
    return loginRes;
  }
}
