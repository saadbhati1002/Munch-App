import 'package:app/api/http_manager.dart';
import 'package:app/models/q_and_a/add/add_question_model.dart';
import 'package:app/models/q_and_a/question_model.dart';
import 'package:app/models/q_and_a/reply/reply_model.dart';
import 'package:app/models/recipe/like_unlike/like_unlike_model.dart';

class QAndANetwork {
  static const String addQuestionUrl = "question";
  static const String questionsListUrl = "questions";
  static const String questionLikeUrl = "question/like";
  static const String questionUnlikeUrl = "question/unlike";
  static const String addReplyUrl = "question/reply";
  static const String replyListUrl = "question/replies?id=";
  static const String replyLikeUrl = "reply/like";
  static const String replyUnlikeUrl = "reply/unlike";

  static Future<dynamic> addQuestion(param) async {
    final result = await httpManager.post(url: addQuestionUrl, data: param);

    AddQuestionRes loginRes = AddQuestionRes.fromJson(result);
    return loginRes;
  }

  static Future<dynamic> getQuestionList() async {
    final result = await httpManager.get(url: questionsListUrl);
    QuestionRes response = QuestionRes.fromJson(result);

    return response;
  }

  static Future<dynamic> questionLike(param) async {
    final result = await httpManager.post(url: questionLikeUrl, data: param);
    LikeUnlikeRes loginRes = LikeUnlikeRes.fromJson(result);
    return loginRes;
  }

  static Future<dynamic> questionUnlike(param) async {
    final result = await httpManager.post(url: questionUnlikeUrl, data: param);
    LikeUnlikeRes loginRes = LikeUnlikeRes.fromJson(result);
    return loginRes;
  }

  static Future<dynamic> addReply(param) async {
    final result = await httpManager.post(url: addReplyUrl, data: param);

    AddQuestionRes loginRes = AddQuestionRes.fromJson(result);
    return loginRes;
  }

  static Future<dynamic> getReply(param) async {
    final result = await httpManager.get(url: "$replyListUrl$param");

    ReplyRes response = ReplyRes.fromJson(result);

    return response;
  }

  static Future<dynamic> replyLike(param) async {
    print(param);
    final result = await httpManager.post(url: replyLikeUrl, data: param);
    print(result);
    LikeUnlikeRes loginRes = LikeUnlikeRes.fromJson(result);
    return loginRes;
  }

  static Future<dynamic> replyUnlike(param) async {
    final result = await httpManager.post(url: replyUnlikeUrl, data: param);
    LikeUnlikeRes loginRes = LikeUnlikeRes.fromJson(result);
    return loginRes;
  }
}
