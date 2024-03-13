class CommonRes {
  bool? success;
  String? message;

  CommonRes({success, message});
  CommonRes.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataResponse = <String, dynamic>{};
    dataResponse['success'] = success;
    dataResponse['message'] = message;
    return dataResponse;
  }
}
