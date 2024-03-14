class CalenderRes {
  bool? success;
  List<CalenderData> data = [];
  String? message;

  CalenderRes({success, data, message});

  CalenderRes.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <CalenderData>[];
      json['data'].forEach((v) {
        data.add(CalenderData.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataResponse = <String, dynamic>{};
    dataResponse['success'] = success;
    if (data.isNotEmpty) {
      dataResponse['data'] = data.map((v) => v.toJson()).toList();
    }
    dataResponse['message'] = message;
    return dataResponse;
  }
}

class CalenderData {
  String? userId;
  String? user;
  String? recipeId;
  String? nameDish;
  String? media;
  String? tagLine;
  String? preparationTime;
  String? cookingTime;
  String? smallDesc;
  String? servingPotions;
  String? ingredientList;
  String? method;
  String? methodTagline;
  String? chefsWhisper;
  String? chefsWhisperTagline;
  String? isApproved;
  String? likeCount;
  String? date;
  bool? isVideoThumbnailLoading = false;
  String? videoThumbnail;

  CalenderData(
      {userId,
      user,
      recipeId,
      nameDish,
      media,
      tagLine,
      preparationTime,
      cookingTime,
      smallDesc,
      servingPotions,
      ingredientList,
      method,
      methodTagline,
      chefsWhisper,
      chefsWhisperTagline,
      isApproved,
      likeCount,
      date});

  CalenderData.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    user = json['user'];
    recipeId = json['recipy_id'];
    nameDish = json['name_dish'];
    media = json['media'];
    tagLine = json['tag_line'];
    preparationTime = json['preparation_time'];
    cookingTime = json['cooking_time'];
    smallDesc = json['small_desc'];
    servingPotions = json['serving_potions'];
    ingredientList = json['ingredient_list'];
    method = json['method'];
    methodTagline = json['method_tagline'];
    chefsWhisper = json['chefs_whisper'];
    chefsWhisperTagline = json['chefs_whisper_tagline'];
    isApproved = json['is_approved'];
    likeCount = json['like_count'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['user'] = user;
    data['recipy_id'] = recipeId;
    data['name_dish'] = nameDish;
    data['media'] = media;
    data['tag_line'] = tagLine;
    data['preparation_time'] = preparationTime;
    data['cooking_time'] = cookingTime;
    data['small_desc'] = smallDesc;
    data['serving_potions'] = servingPotions;
    data['ingredient_list'] = ingredientList;
    data['method'] = method;
    data['method_tagline'] = methodTagline;
    data['chefs_whisper'] = chefsWhisper;
    data['chefs_whisper_tagline'] = chefsWhisperTagline;
    data['is_approved'] = isApproved;
    data['like_count'] = likeCount;
    data['date'] = date;
    return data;
  }
}
