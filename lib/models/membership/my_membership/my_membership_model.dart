class MyMembershipRes {
  bool? success;
  List<MyMembershipData>? data;
  String? message;

  MyMembershipRes({success, data, message});

  MyMembershipRes.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <MyMembershipData>[];
      json['data'].forEach((v) {
        data!.add(MyMembershipData.fromJson(v));
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

class MyMembershipData {
  String? userId;
  String? createdAt;
  String? user;
  String? planId;
  String? planName;
  String? planDesc;
  String? planAmount;
  String? planDays;

  MyMembershipData(
      {userId,
      createdAt,
      user,
      planId,
      planName,
      planDesc,
      planAmount,
      planDays});

  MyMembershipData.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    createdAt = json['created_at'];
    user = json['user'];
    planId = json['plan_id'];
    planName = json['plan_name'];
    planDesc = json['plan_desc'];
    planAmount = json['plan_amount'];
    planDays = json['plan_days'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = userId;
    data['created_at'] = createdAt;
    data['user'] = user;
    data['plan_id'] = planId;
    data['plan_name'] = planName;
    data['plan_desc'] = planDesc;
    data['plan_amount'] = planAmount;
    data['plan_days'] = planDays;
    return data;
  }
}
