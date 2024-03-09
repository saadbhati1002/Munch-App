class LikeUnlikeRes {
  bool? success;
  Data? data;
  String? message;

  LikeUnlikeRes({success, data, message});

  LikeUnlikeRes.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    // data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataResponse = <String, dynamic>{};
    dataResponse['success'] = success;
    // if (data != null) {
    //   dataResponse['data'] = data!.toJson();
    // }
    dataResponse['message'] = message;
    return dataResponse;
  }
}

class Data {
  int? recipeId;
  int? userId;
  int? likeCount;
  String? updatedAt;
  String? createdAt;
  int? id;

  Data({recipeId, userId, likeCount, updatedAt, createdAt, id});

  Data.fromJson(Map<String, dynamic> json) {
    recipeId = json['recipy_id'];
    userId = json['user_id'];
    likeCount = json['like_count'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['recipy_id'] = recipeId;
    data['user_id'] = userId;
    data['like_count'] = likeCount;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    return data;
  }
}
