class UserRes {
  bool? success;
  UserData? data;
  String? message;

  UserRes({success, data, message});

  UserRes.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? UserData.fromJson(json['data']) : null;
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

class UserData {
  String? token;
  String? name;
  String? image;
  String? userEmail;
  String? userBio;
  String? id;
  String? dateOfBirth;
  String? address;
  String? phoneNumber;
  bool isPremiumUser = true;
  LatestPlanName? latestPlanName;
  UserData({
    token,
    name,
    image,
    userEmail,
    userBio,
    id,
    address,
    dateOfBirth,
    phoneNumber,
    latestPlanName,
  });

  UserData.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    userEmail = json["email"];
    name = json['name'];
    image = json['image'];
    id = json['id'].toString();
    dateOfBirth = json['dob'];
    address = json['address'];
    phoneNumber = json['mobile_number'];
    userBio = json['bio'];
    latestPlanName = json['latest_plan_name'] != null
        ? LatestPlanName.fromJson(json['latest_plan_name'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    data['name'] = name;
    data['image'] = image;
    data['id'] = id;
    data["email"] = userEmail;
    data['address'] = address;
    data['dob'] = dateOfBirth;
    data['mobile_number'] = phoneNumber;
    data['bio'] = userBio;
    if (latestPlanName != null) {
      data['latest_plan_name'] = latestPlanName!.toJson();
    }
    return data;
  }
}

class LatestPlanName {
  int? id;
  int? userId;
  int? planId;
  String? createdAt;
  String? updatedAt;
  Plan? plan;

  LatestPlanName({id, userId, planId, createdAt, updatedAt, plan});

  LatestPlanName.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    planId = json['plan_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    plan = json['plan'] != null ? Plan.fromJson(json['plan']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['plan_id'] = planId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (plan != null) {
      data['plan'] = plan!.toJson();
    }
    return data;
  }
}

class Plan {
  int? id;
  String? title;
  String? desc;
  String? amount;
  String? days;
  String? createdAt;
  String? updatedAt;

  Plan({id, title, desc, amount, days, createdAt, updatedAt});

  Plan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    desc = json['desc'];
    amount = json['amount'];
    days = json['days'].toString();
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
