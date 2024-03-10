import 'package:app/api/network/q_and_a/q_and_a.dart';

class QAndARepository {
  Future<dynamic> getQuestionListApiCall() async {
    return await QAndANetwork.getQuestionList();
  }

  Future<dynamic> questionLikeApiCall({String? questionID}) async {
    final pram = {
      "id": questionID,
    };
    return await QAndANetwork.questionLike(pram);
  }

  Future<dynamic> questionUnlikeApiCall({String? questionID}) async {
    final pram = {
      "id": questionID,
    };
    return await QAndANetwork.questionUnlike(pram);
  }

  Future<dynamic> addQuestionApiCall(
      {String? question, String? description}) async {
    final param = {
      "title": question,
      "answer": description,
    };
    return await QAndANetwork.addQuestion(param);
  }

  Future<dynamic> getRelyListApiCall({String? questionID}) async {
    return await QAndANetwork.getReply(questionID);
  }

  Future<dynamic> replyLikeApiCall({String? replyID}) async {
    final pram = {
      "id": replyID,
    };
    return await QAndANetwork.replyLike(pram);
  }

  Future<dynamic> replyUnlikeApiCall({String? replyID}) async {
    final pram = {
      "id": replyID,
    };
    return await QAndANetwork.replyUnlike(pram);
  }
}
