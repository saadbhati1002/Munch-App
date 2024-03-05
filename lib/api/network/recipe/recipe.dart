import 'package:app/api/http_manager.dart';
import 'package:app/models/recipe/like_unlike/like_unlike_model.dart';
import 'package:app/models/recipe/recipe_model.dart';

class RecipeNetwork {
  static const String recipeUrl = "recipie";
  static const String recipeLikeUrl = "recipy/like";
  static const String recipeUnlikeUrl = "recipy/unlike";
  static Future<dynamic> getRecipeList() async {
    final result = await httpManager.get(url: recipeUrl);
    RecipeRes loginRes = RecipeRes.fromJson(result);
    return loginRes;
  }

  static Future<dynamic> recipeLike(param) async {
    final result = await httpManager.post(url: recipeLikeUrl, data: param);
    LikeUnlikeRes loginRes = LikeUnlikeRes.fromJson(result);
    return loginRes;
  }

  static Future<dynamic> recipeUnlike(param) async {
    final result = await httpManager.post(url: recipeUnlikeUrl, data: param);
    LikeUnlikeRes loginRes = LikeUnlikeRes.fromJson(result);
    return loginRes;
  }
}
