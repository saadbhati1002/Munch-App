class CommentRes {
  String? recipe;
  List<CommentData> comments = [];

  CommentRes({recipe, comments});

  CommentRes.fromJson(Map<String, dynamic> json) {
    recipe = json['recipe'];
    if (json['data'] != null) {
      comments = <CommentData>[];
      json['data'].forEach((v) {
        comments.add(CommentData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['recipe'] = recipe;
    if (comments.isNotEmpty) {
      data['data'] = comments.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CommentData {
  dynamic id;
  dynamic userId;
  dynamic recipeId;
  dynamic articleID;
  String? title;
  String? description;
  String? recipeName;
  String? userName;
  String? userImage;
  int count = 0;
  bool isLikedByMe = false;
  bool isLoading = false;
  List<LikedUsers> likedUsers = [];

  CommentData(
      {id,
      userId,
      recipeId,
      title,
      description,
      recipeName,
      userName,
      userImage,
      this.articleID});

  CommentData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    recipeId = json['recipe_id'];
    articleID = json["artical_id"];
    title = json['title'];
    description = json['description'];
    recipeName = json['recipe_name'];
    userName = json['user_name'];
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
    data['user_id'] = userId;
    data['recipe_id'] = recipeId;
    data['title'] = title;
    data['description'] = description;
    data['recipe_name'] = recipeName;
    data['user_name'] = userName;
    data['user_image'] = userImage;
    data["artical_id"] = articleID;
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
