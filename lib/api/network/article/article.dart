import 'package:app/api/http_manager.dart';
import 'package:app/models/recipe/like_unlike/like_unlike_model.dart';
import 'package:app/models/recipe/recipe_model.dart';

class ArticleNetwork {
  static const String articleUrl = "artical";
  static const String articleLikeUrl = "artical/like";
  static const String articleUnlikeUrl = "artical/unlike";
  static Future<dynamic> getArticleList() async {
    final result = await httpManager.get(url: articleUrl);

    RecipeRes loginRes = RecipeRes.fromJson(result);
    return loginRes;
  }

  static Future<dynamic> articleLike(param) async {
    final result = await httpManager.post(url: articleLikeUrl, data: param);
    LikeUnlikeRes loginRes = LikeUnlikeRes.fromJson(result);
    return loginRes;
  }

  static Future<dynamic> articleUnlike(param) async {
    final result = await httpManager.post(url: articleUnlikeUrl, data: param);

    LikeUnlikeRes loginRes = LikeUnlikeRes.fromJson(result);
    return loginRes;
  }
}
