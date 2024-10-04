class BannerRes {
  bool? success;
  List<BannerData> data = [];
  String? message;

  BannerRes({success, data, message});

  BannerRes.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <BannerData>[];
      json['data'].forEach((v) {
        data.add(BannerData.fromJson(v));
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

class BannerData {
  int? id;
  String? image;
  String? url;
  String? recipeID;
  String? articleID;
  String? homeMakerID;
  String? bannerType;
  String? createdAt;
  String? updatedAt;

  BannerData({id, image, url, createdAt, updatedAt, recipeID});

  BannerData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    url = json['url'];
    recipeID = json['recipie_id'].toString();
    articleID = json['artical_id'].toString();
    homeMakerID = json['home_maker_id'].toString();
    bannerType = json['banner_type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['url'] = url;
    data["recipie_id"] = recipeID;
    data["artical_id"] = articleID;
    data["home_maker_id"] = homeMakerID;
    data["banner_type"] = bannerType;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
