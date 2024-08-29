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

  UserData(
      {token,
      name,
      image,
      this.userEmail,
      this.userBio,
      this.id,
      this.address,
      this.dateOfBirth,
      this.phoneNumber});

  UserData.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    name = json['name'];
    image = json['image'];
    id = json['id'].toString();
    dateOfBirth = json['dob'];
    address = json['address'];
    phoneNumber = json['mobile_number'];
    userBio = json['bio'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    data['name'] = name;
    data['image'] = image;
    data['id'] = id;
    data['address'] = address;
    data['dob'] = dateOfBirth;
    data['mobile_number'] = phoneNumber;
    data['bio'] = userBio;

    return data;
  }
}
