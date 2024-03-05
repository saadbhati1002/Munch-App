class RecipeRes {
  bool? success;
  List<RecipeData> data = [];
  String? message;

  RecipeRes({success, data, message});

  RecipeRes.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <RecipeData>[];
      json['data'].forEach((v) {
        data.add(RecipeData.fromJson(v));
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

class RecipeData {
  String? nameDish;
  List<String>? categories;
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
  String? user;
  String? userImage;
  int? likeCount = 0;
  bool? isLikedByMe = false;
  String? videoThumbnail;
  bool? isVideoThumbnailLoading = false;

  RecipeData(
      {nameDish,
      categories,
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
      user,
      userImage,
      this.isLikedByMe,
      this.likeCount,
      this.isVideoThumbnailLoading});

  RecipeData.fromJson(Map<String, dynamic> json) {
    nameDish = json['name_dish'];
    categories = json['categories'].cast<String>();
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
    user = json['user'];
    userImage = json['user_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name_dish'] = nameDish;
    data['categories'] = categories;
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
    data['user'] = user;
    data['user_image'] = userImage;
    return data;
  }
}
