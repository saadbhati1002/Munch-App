import 'package:app/api/network/article/article.dart';

class ArticleRepository {
  Future<dynamic> getArticlesApiCall() async {
    return await ArticleNetwork.getArticleList();
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
}
