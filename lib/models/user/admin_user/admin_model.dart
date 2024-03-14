class AdminRes {
  bool? success;
  List<AdminUser> data = [];
  String? message;

  AdminRes({success, data, message});

  AdminRes.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <AdminUser>[];
      json['data'].forEach((v) {
        data.add(AdminUser.fromJson(v));
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

class AdminUser {
  int? id;
  String? name;
  String? email;
  String? image;
  dynamic emailVerifiedAt;
  String? apiToken;
  dynamic token;
  String? isAdmin;
  String? desc;
  dynamic video;
  dynamic bio;
  dynamic mobileNumber;
  dynamic address;
  dynamic dob;
  String? createdAt;
  String? updatedAt;
  bool isVideoThumbnailLoading = false;
  String? videoThumbnail;

  AdminUser(
      {id,
      name,
      email,
      image,
      emailVerifiedAt,
      apiToken,
      token,
      isAdmin,
      desc,
      video,
      bio,
      mobileNumber,
      address,
      dob,
      createdAt,
      updatedAt});

  AdminUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    image = json['image'];
    emailVerifiedAt = json['email_verified_at'];
    apiToken = json['api_token'];
    token = json['token'];
    isAdmin = json['is_admin'];
    desc = json['desc'];
    video = json['video'];
    bio = json['bio'];
    mobileNumber = json['mobile_number'];
    address = json['address'];
    dob = json['dob'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['image'] = image;
    data['email_verified_at'] = emailVerifiedAt;
    data['api_token'] = apiToken;
    data['token'] = token;
    data['is_admin'] = isAdmin;
    data['desc'] = desc;
    data['video'] = video;
    data['bio'] = bio;
    data['mobile_number'] = mobileNumber;
    data['address'] = address;
    data['dob'] = dob;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
