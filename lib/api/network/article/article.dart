import 'package:app/api/http_manager.dart';
import 'package:app/models/recipe/comment/add_comment_model.dart';
import 'package:app/models/recipe/comment/comment_model.dart';
import 'package:app/models/recipe/like_unlike/like_unlike_model.dart';
import 'package:app/models/recipe/recipe_model.dart';

class ArticleNetwork {
  static const String articleUrl = "artical";
  static const String articleLikeUrl = "artical/like";
  static const String articleUnlikeUrl = "artical/unlike";
  static const String articleCommentAddUrl = "artical/comment";
  static const String commentListUrl = "artical/comments?id=";
  static const String commentLikeUrl = "artical/comment/like";
  static const String commentUnlikeUrl = "artical/comment/unlike";
  static Future<dynamic> getArticleList(params) async {
    final result = await httpManager.get(url: articleUrl, params: params);

    RecipeRes response = RecipeRes.fromJson(result);
    return response;
  }

  static Future<dynamic> articleLike(param) async {
    final result = await httpManager.post(url: articleLikeUrl, data: param);
    LikeUnlikeRes response = LikeUnlikeRes.fromJson(result);
    return response;
  }

  static Future<dynamic> articleUnlike(param) async {
    final result = await httpManager.post(url: articleUnlikeUrl, data: param);

    LikeUnlikeRes response = LikeUnlikeRes.fromJson(result);
    return response;
  }

  static Future<dynamic> addComment(param) async {
    final result =
        await httpManager.post(url: articleCommentAddUrl, data: param);

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
}
