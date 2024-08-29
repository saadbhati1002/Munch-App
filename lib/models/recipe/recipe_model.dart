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
  String? id;
  String? nameDish;
  List<String>? categories;
  String? media;
  String? tagLine;
  String? preparationTime;
  String? cookingTime;
  String? smallDesc;
  String? servingPotions;
  List ingredientList = [];
  String? method;
  String? methodTagline;
  String? chefsWhisper;
  String? chefsWhisperTagline;
  String? isApproved;
  String? user;
  String? userImage;
  int? likeCount = 0;
  int? commentCount = 0;
  bool? isLikedByMe = false;
  String? videoThumbnail;
  List<LikedUsers> likedUsers = [];
  bool? isVideoThumbnailLoading = false;
  String? userID;
  bool isLoading = false;
  String? createdAt;
  int? featured;
  String? thumbnail;

  RecipeData({
    nameDish,
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
    likedUsers,
    this.isLikedByMe,
    this.likeCount,
    this.isVideoThumbnailLoading,
    this.id,
    this.userID,
    isLoading,
    this.createdAt,
    this.featured,
    this.thumbnail,
  });

  RecipeData.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    nameDish = json['name_dish'];
    categories =
        json['categories'] != null ? json['categories'].cast<String>() : [];
    media = json['media'];
    tagLine = json['tag_line'];
    preparationTime = json['preparation_time'];
    cookingTime = json['cooking_time'];
    smallDesc = json['small_desc'];
    servingPotions = json['serving_potions'];
    ingredientList = json['ingredient_list'] != null
        ? json['ingredient_list'].split(',')
        : [];
    method = json['method'];
    methodTagline = json['method_tagline'];
    chefsWhisper = json['chefs_whisper'];
    chefsWhisperTagline = json['chefs_whisper_tagline'];
    isApproved = json['is_approved'].toString();
    user = json['user'];
    userImage = json['user_image'];
    likeCount = int.parse(json['like_count'].toString());
    commentCount = int.parse(json['comment_count'].toString());
    userID = json['user_id'].toString();
    createdAt = json['created_at'].toString();
    thumbnail = json['thumbnail'];

    featured =
        json["featured"] != null ? int.parse(json["featured"].toString()) : 0;
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
    data['comment_count'] = commentCount;
    data['created_at'] = createdAt;
    data["featured"] = featured;
    data["thumbnail"] = thumbnail;

    if (likedUsers.isNotEmpty) {
      data['liked_users'] = likedUsers.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LikedUsers {
  int? id;
  String? name;

  LikedUsers({this.id, this.name});

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
