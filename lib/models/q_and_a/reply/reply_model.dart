class ReplyRes {
  bool? success;
  List<ReplyData>? data;
  String? message;

  ReplyRes({success, data, message});

  ReplyRes.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <ReplyData>[];
      json['data'].forEach((v) {
        data!.add(ReplyData.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataResponse = <String, dynamic>{};
    dataResponse['success'] = success;
    if (data != null) {
      dataResponse['data'] = data!.map((v) => v.toJson()).toList();
    }
    dataResponse['message'] = message;
    return dataResponse;
  }
}

class ReplyData {
  int? id;
  String? questionId;
  String? questionTitle;
  String? replyText;
  String? likeCount;
  String? user;
  String? userImage;
  List<LikedUsers> likedUsers = [];
  bool isLikedByMe = false;
  bool isLoading = false;

  ReplyData(
      {id,
      questionId,
      questionTitle,
      replyText,
      likeCount,
      user,
      userImage,
      likedUsers});

  ReplyData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    questionId = json['question_id'];
    questionTitle = json['question_title'];
    replyText = json['reply_text'];
    likeCount = json['like_count'];
    user = json['user'];
    userImage = json['user_image'];
    if (json['liked_users'] != null) {
      likedUsers = <LikedUsers>[];
      json['liked_users'].forEach((v) {
        likedUsers.add(LikedUsers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['question_id'] = questionId;
    data['question_title'] = questionTitle;
    data['reply_text'] = replyText;
    data['like_count'] = likeCount;
    data['user'] = user;
    data['user_image'] = userImage;
    if (likedUsers.isNotEmpty) {
      data['liked_users'] = likedUsers.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LikedUsers {
  int? id;
  String? name;

  LikedUsers({id, name});

  LikedUsers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
