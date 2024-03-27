class ListRes {
  bool? success;
  List<ListData>? data;
  String? message;

  ListRes({success, data, message});

  ListRes.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <ListData>[];
      json['data'].forEach((v) {
        data!.add(ListData.fromJson(v));
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

class ListData {
  String? id;
  String? recipeName;
  String? servingPortion;
  List? ingredient = [];
  String? userId;
  String? user;

  ListData({id, recipeName, servingPortion, ingredient, userId, user});

  ListData.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    recipeName = json['recipe_name'];
    servingPortion = json['serving_portion'];
    ingredient = json['ingredent'] != null ? json['ingredent'].split(',') : [];
    userId = json['user_id'].toString();
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['recipe_name'] = recipeName;
    data['serving_portion'] = servingPortion;
    data['ingredent'] = ingredient;
    data['user_id'] = userId;
    data['user'] = user;
    return data;
  }
}
