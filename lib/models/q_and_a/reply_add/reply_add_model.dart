class ReplyAddRes {
  bool? success;
  ReplyAddData? data;
  String? message;

  ReplyAddRes({success, data, message});

  ReplyAddRes.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? ReplyAddData.fromJson(json['data']) : null;
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

class ReplyAddData {
  int? questionId;
  int? userId;
  String? text;
  String? updatedAt;
  String? createdAt;
  int? id;

  ReplyAddData({questionId, userId, text, updatedAt, createdAt, id});

  ReplyAddData.fromJson(Map<String, dynamic> json) {
    questionId = json['question_id'];
    userId = json['user_id'];
    text = json['text'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['question_id'] = questionId;
    data['user_id'] = userId;
    data['text'] = text;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    return data;
  }
}
