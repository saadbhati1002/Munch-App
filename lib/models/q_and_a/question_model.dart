class QuestionRes {
  bool? success;
  List<QuestionData>? data;
  String? message;

  QuestionRes({success, data, message});

  QuestionRes.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <QuestionData>[];
      json['data'].forEach((v) {
        data!.add(QuestionData.fromJson(v));
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

class QuestionData {
  int? id;
  String? questionTitle;
  String? questionAnswer;
  String? replyCount;
  String? likeCount;
  String? user;
  String? userImage;
  List<LikedUsers> likedUsers = [];
  bool isLikedByMe = false;
  bool isLoading = false;

  QuestionData(
      {id,
      questionTitle,
      questionAnswer,
      replyCount,
      likeCount,
      user,
      userImage,
      likedUsers});

  QuestionData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    questionTitle = json['question_title'];
    questionAnswer = json['question_answer'];
    replyCount = json['reply_count'].toString();
    likeCount = json['like_count'].toString();
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
    data['question_title'] = questionTitle;
    data['question_answer'] = questionAnswer;
    data['reply_count'] = replyCount;
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
