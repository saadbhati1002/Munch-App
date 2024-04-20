class MembershipRes {
  bool? success;
  List<MembershipData>? data;
  String? message;

  MembershipRes({success, data, message});

  MembershipRes.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <MembershipData>[];
      json['data'].forEach((v) {
        data!.add(MembershipData.fromJson(v));
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

class MembershipData {
  int? id;
  String? title;
  String? desc;
  String? amount;
  String? days;
  String? createdAt;
  String? updatedAt;

  MembershipData({id, title, desc, amount, days, createdAt, updatedAt});

  MembershipData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    desc = json['desc'];
    amount = json['amount'];
    days = json['days'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['desc'] = desc;
    data['amount'] = amount;
    data['days'] = days;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
