class AddQuestionRes {
  bool? success;
  AddQuestionData? data;
  String? message;

  AddQuestionRes({success, data, message});

  AddQuestionRes.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? AddQuestionData.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataResponse = <String, dynamic>{};
    dataResponse['success'] = success;
    if (data != null) {
      dataResponse['data'] = data!.toJson();
    }
    dataResponse['message'] = message;
    return dataResponse;
  }
}

class AddQuestionData {
  int? userId;
  String? questionTitle;
  String? questionAnswer;
  String? updatedAt;
  String? createdAt;
  int? id;

  AddQuestionData(
      {userId, questionTitle, questionAnswer, updatedAt, createdAt, id});

  AddQuestionData.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    questionTitle = json['question_title'];
    questionAnswer = json['question_answer'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['question_title'] = questionTitle;
    data['question_answer'] = questionAnswer;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    return data;
  }
}
