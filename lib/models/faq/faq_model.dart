class FAQRes {
  bool? success;
  List<FAQData>? data;
  String? message;

  FAQRes({success, data, message});

  FAQRes.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <FAQData>[];
      json['data'].forEach((v) {
        data!.add(FAQData.fromJson(v));
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

class FAQData {
  int? id;
  String? question;
  String? text;
  String? createdAt;
  String? updatedAt;

  FAQData({id, question, text, createdAt, updatedAt});

  FAQData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    text = json['answer'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['question'] = question;
    data['answer'] = text;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
