import 'package:app/api/network/recipe/recipe.dart';

class RecipeRepository {
  Future<dynamic> getRecipesApiCall() async {
    return await RecipeNetwork.getRecipeList();
  }
}
