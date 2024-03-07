import 'package:app/api/http_manager.dart';
import 'package:app/models/recipe/comment/add_comment_model.dart';
import 'package:app/models/recipe/comment/comment_model.dart';
import 'package:app/models/recipe/like_unlike/like_unlike_model.dart';
import 'package:app/models/recipe/recipe_model.dart';

class ArticleNetwork {
  static const String articleUrl = "artical";
  static const String articleLikeUrl = "artical/like";
  static const String articleUnlikeUrl = "artical/unlike";
  static const String articleCommentAddUrl = "comment";
  static const String commentListUrl = "artical/comments?id=";
  static const String commentLikeUrl = "comment/like";
  static const String commentUnlikeUrl = "comment/unlike";
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

  static Future<dynamic> addComment(param) async {
    final result =
        await httpManager.post(url: articleCommentAddUrl, data: param);

    AddCommentRes loginRes = AddCommentRes.fromJson(result);
    return loginRes;
  }

  static Future<dynamic> getCommentList(param) async {
    final result = await httpManager.get(url: "$commentListUrl$param");

    CommentRes loginRes = CommentRes.fromJson(result);
    return loginRes;
  }

  static Future<dynamic> commentLike(param) async {
    final result = await httpManager.post(url: commentLikeUrl, data: param);
    LikeUnlikeRes loginRes = LikeUnlikeRes.fromJson(result);
    return loginRes;
  }

  static Future<dynamic> commentUnlike(param) async {
    final result = await httpManager.post(url: commentUnlikeUrl, data: param);
    LikeUnlikeRes loginRes = LikeUnlikeRes.fromJson(result);
    return loginRes;
  }
}
