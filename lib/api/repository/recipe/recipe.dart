import 'package:app/api/network/recipe/recipe.dart';

class RecipeRepository {
  Future<dynamic> getRecipesApiCall() async {
    return await RecipeNetwork.getRecipeList();
  }

  Future<dynamic> recipeLikeApiCall({String? recipeID}) async {
    final pram = {
      "id": recipeID,
    };
    return await RecipeNetwork.recipeLike(pram);
  }

  Future<dynamic> recipeUnlikeApiCall({String? recipeID}) async {
    final pram = {
      "id": recipeID,
    };
    return await RecipeNetwork.recipeUnlike(pram);
  }
}
