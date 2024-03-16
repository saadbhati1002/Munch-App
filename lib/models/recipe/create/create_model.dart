class RecipeCreateRes {
  bool? success;
  RecipeCreateData? data;
  String? message;

  RecipeCreateRes({success, data, message});

  RecipeCreateRes.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data =
        json['data'] != null ? RecipeCreateData.fromJson(json['data']) : null;
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

class RecipeCreateData {
  String? media;
  String? categoryId;
  String? nameDish;
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
  int? userId;
  String? updatedAt;
  String? createdAt;
  int? id;

  RecipeCreateData(
      {media,
      categoryId,
      nameDish,
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
      userId,
      updatedAt,
      createdAt,
      id});

  RecipeCreateData.fromJson(Map<String, dynamic> json) {
    media = json['media'];
    categoryId = json['category_id'];
    nameDish = json['name_dish'];
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
    userId = json['user_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['media'] = media;
    data['category_id'] = categoryId;
    data['name_dish'] = nameDish;
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
    data['user_id'] = userId;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    return data;
  }
}
