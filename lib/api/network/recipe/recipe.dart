import 'package:app/api/http_manager.dart';
import 'package:app/models/common_model.dart';
import 'package:app/models/recipe/calender/calender_model.dart';
import 'package:app/models/recipe/comment/add_comment_model.dart';
import 'package:app/models/recipe/comment/comment_model.dart';
import 'package:app/models/recipe/create/create_model.dart';
import 'package:app/models/recipe/like_unlike/like_unlike_model.dart';
import 'package:app/models/recipe/recipe_model.dart';

class RecipeNetwork {
  static const String recipeUrl = "recipie";
  static const String recipeLikeUrl = "recipy/like";
  static const String recipeUnlikeUrl = "recipy/unlike";
  static const String commentAddUrl = "comment";
  static const String commentListUrl = "comments?id=";
  static const String commentLikeUrl = "comment/like";
  static const String commentUnlikeUrl = "comment/unlike";
  static const String recipeAddToCalenderUrl = "recipy/calender";
  static const String recipeRemoveFromCalenderUrl = "recipy/calender/delete";
  static const String calenderRecipeUrl = "recipy/calenders";
  static const String myLikedRecipeUrl = "liked-recipes";
  static const String createRecipeUrl = "create/recipie";
  static const String myRecipeUrl = "user/recipie";
  static const String deleteRecipeUrl = "recipy/delete";

  static Future<dynamic> getRecipeList(params) async {
    final result = await httpManager.get(url: recipeUrl, params: params);
    print(result);
    RecipeRes response = RecipeRes.fromJson(result);
    return response;
  }

  static Future<dynamic> recipeLike(param) async {
    final result = await httpManager.post(url: recipeLikeUrl, data: param);
    LikeUnlikeRes response = LikeUnlikeRes.fromJson(result);
    return response;
  }

  static Future<dynamic> recipeUnlike(param) async {
    final result = await httpManager.post(url: recipeUnlikeUrl, data: param);

    LikeUnlikeRes response = LikeUnlikeRes.fromJson(result);
    return response;
  }

  static Future<dynamic> addComment(param) async {
    final result = await httpManager.post(url: commentAddUrl, data: param);

    AddCommentRes response = AddCommentRes.fromJson(result);
    return response;
  }

  static Future<dynamic> getCommentList(param) async {
    final result = await httpManager.get(url: "$commentListUrl$param");

    CommentRes response = CommentRes.fromJson(result);
    return response;
  }

  static Future<dynamic> commentLike(param) async {
    final result = await httpManager.post(url: commentLikeUrl, data: param);
    LikeUnlikeRes response = LikeUnlikeRes.fromJson(result);
    return response;
  }

  static Future<dynamic> commentUnlike(param) async {
    final result = await httpManager.post(url: commentUnlikeUrl, data: param);
    LikeUnlikeRes response = LikeUnlikeRes.fromJson(result);
    return response;
  }

  static Future<dynamic> saveToMyCalender(param) async {
    final result =
        await httpManager.post(url: recipeAddToCalenderUrl, data: param);

    LikeUnlikeRes response = LikeUnlikeRes.fromJson(result);
    return response;
  }

  static Future<dynamic> getSavedCalenderRecipe() async {
    final result = await httpManager.get(url: calenderRecipeUrl);

    CalenderRes response = CalenderRes.fromJson(result);
    return response;
  }

  static Future<dynamic> getMyLikeRecipe(param) async {
    final result = await httpManager.get(url: myLikedRecipeUrl, params: param);

    RecipeRes response = RecipeRes.fromJson(result);
    return response;
  }

  static Future<dynamic> createRecipe(param) async {
    final result = await httpManager.post(url: createRecipeUrl, data: param);

    RecipeCreateRes response = RecipeCreateRes.fromJson(result);
    return response;
  }

  static Future<dynamic> getMyRecipeList() async {
    final result = await httpManager.get(url: myRecipeUrl);

    RecipeRes response = RecipeRes.fromJson(result);
    return response;
  }

  static Future<dynamic> deleteRecipe(param) async {
    final result = await httpManager.post(url: deleteRecipeUrl, data: param);

    CommonRes response = CommonRes.fromJson(result);
    return response;
  }
}
