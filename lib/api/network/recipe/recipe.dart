import 'package:app/api/http_manager.dart';
import 'package:app/models/recipe/recipe_model.dart';

class RecipeNetwork {
  static const String recipeUrl = "recipie";
  static Future<dynamic> getRecipeList() async {
    final result = await httpManager.get(url: recipeUrl);
    RecipeRes loginRes = RecipeRes.fromJson(result);
    return loginRes;
  }
}
