import 'package:app/models/list/list_model.dart';

class AddListRes {
  bool? success;
  ListData? data;
  String? message;

  AddListRes({success, data, message});

  AddListRes.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? ListData.fromJson(json['data']) : null;
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
