import 'package:app/api/network/recipe/recipe.dart';
import 'package:app/utility/constant.dart';

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

  Future<dynamic> addCommentApiCall(
      {String? recipeID, String? title, String? comment}) async {
    final param = {
      "recipy_id": recipeID,
      "title": title,
      "desc": comment,
    };
    return await RecipeNetwork.addComment(param);
  }

  Future<dynamic> getCommentListApiCall({String? recipeID}) async {
    return await RecipeNetwork.getCommentList(recipeID);
  }

  Future<dynamic> commentLikeApiCall({String? commentID}) async {
    final pram = {
      "id": commentID,
    };
    return await RecipeNetwork.commentLike(pram);
  }

  Future<dynamic> commentUnlikeApiCall({String? commentID}) async {
    final pram = {
      "id": commentID,
    };
    return await RecipeNetwork.commentUnlike(pram);
  }

  Future<dynamic> saveToMyCalenderApiCall(
      {String? recipeID, String? date}) async {
    final pram = {"id": recipeID, "date": date};
    return await RecipeNetwork.saveToMyCalender(pram);
  }

  Future<dynamic> getCalenderRecipeApiCall() async {
    return await RecipeNetwork.getSavedCalenderRecipe();
  }

  Future<dynamic> getMyLikedRecipeApiCall() async {
    final param = {"id": AppConstant.userData!.id};
    return await RecipeNetwork.getMyLikeRecipe(param);
  }
}
