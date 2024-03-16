import 'package:app/api/network/category/category.dart';

class CategoryRepository {
  Future<dynamic> getCategoryApiCall() async {
    return await CategoryNetwork.getCategory();
  }
}
