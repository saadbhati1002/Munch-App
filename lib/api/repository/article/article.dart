import 'package:app/api/network/article/article.dart';

class ArticleRepository {
  Future<dynamic> getArticlesApiCall({int? count, String? search}) async {
    final params = {
      "count": count,
      "search": search,
    };
    return await ArticleNetwork.getArticleList(params);
  }

  Future<dynamic> articleLikeApiCall({String? articleID}) async {
    final pram = {
      "id": articleID,
    };
    return await ArticleNetwork.articleLike(pram);
  }

  Future<dynamic> articleUnlikeApiCall({String? articleID}) async {
    final pram = {
      "id": articleID,
    };
    return await ArticleNetwork.articleUnlike(pram);
  }

  Future<dynamic> addCommentApiCall(
      {String? articleID, String? title, String? comment}) async {
    final param = {
      "artical_id": articleID,
      "title": title,
      "desc": comment,
    };
    return await ArticleNetwork.addComment(param);
  }

  Future<dynamic> getCommentListApiCall({String? articleID}) async {
    return await ArticleNetwork.getCommentList(articleID);
  }

  Future<dynamic> commentLikeApiCall({String? commentID}) async {
    final pram = {
      "id": commentID,
    };
    return await ArticleNetwork.commentLike(pram);
  }

  Future<dynamic> commentUnlikeApiCall({String? commentID}) async {
    final pram = {
      "id": commentID,
    };
    return await ArticleNetwork.commentUnlike(pram);
  }
}
