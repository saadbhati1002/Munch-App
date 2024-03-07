import 'package:app/models/recipe/comment/comment_model.dart';

class AddCommentRes {
  bool? success;
  CommentData? data;
  String? message;

  AddCommentRes({success, data, message});

  AddCommentRes.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? CommentData.fromJson(json['data']) : null;
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
