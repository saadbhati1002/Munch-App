class CommentRes {
  String? recipe;
  List<CommentData> comments = [];

  CommentRes({recipe, comments});

  CommentRes.fromJson(Map<String, dynamic> json) {
    recipe = json['recipe'];
    if (json['comments'] != null) {
      comments = <CommentData>[];
      json['comments'].forEach((v) {
        comments.add(CommentData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['recipe'] = recipe;
    if (comments.isNotEmpty) {
      data['comments'] = comments.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CommentData {
  int? id;
  int? userId;
  int? recipeId;
  String? title;
  String? description;
  String? recipeName;
  String? userName;
  String? userImage;
  int count = 0;
  bool isLikedByMe = false;

  CommentData(
      {id,
      userId,
      recipeId,
      title,
      description,
      recipeName,
      userName,
      userImage});

  CommentData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    recipeId = json['recipe_id'];
    title = json['title'];
    description = json['description'];
    recipeName = json['recipe_name'];
    userName = json['user_name'];
    userImage = json['user_image'];
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
    return data;
  }
}
