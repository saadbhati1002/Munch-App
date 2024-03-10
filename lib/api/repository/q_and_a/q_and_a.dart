import 'package:app/api/network/q_and_a/q_and_a.dart';

class QAndARepository {
  Future<dynamic> getQuestionListApiCall() async {
    return await QAndANetwork.getQuestionList();
  }

  Future<dynamic> questionLikeApiCall({String? questionID}) async {
    final pram = {
      "id": questionID,
    };
    return await QAndANetwork.commentLike(pram);
  }

  Future<dynamic> questionUnlikeApiCall({String? questionID}) async {
    final pram = {
      "id": questionID,
    };
    return await QAndANetwork.commentUnlike(pram);
  }

  Future<dynamic> addQuestionApiCall(
      {String? question, String? description}) async {
    final param = {
      "title": question,
      "answer": description,
    };
    return await QAndANetwork.addQuestion(param);
  }
}
