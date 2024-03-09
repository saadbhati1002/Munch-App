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
  String? createdAt;
  String? updatedAt;

  BannerData({id, image, url, createdAt, updatedAt});

  BannerData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    url = json['url'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['url'] = url;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
