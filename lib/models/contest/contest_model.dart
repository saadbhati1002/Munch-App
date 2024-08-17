class ContestRes {
  bool? success;
  List<ContestData>? data;
  String? message;

  ContestRes({success, data, message});

  ContestRes.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <ContestData>[];
      json['data'].forEach((v) {
        data!.add(ContestData.fromJson(v));
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

class ContestData {
  int? id;
  String? title;
  String? titleTagline;
  List? rules;
  String? numOfParticipate;

  ContestData({id, title, titleTagline, rules, numOfParticipate});

  ContestData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    titleTagline = json['title_tagline'];
    rules = json['rules'] != null ? json['rules'].split(',') : [];
    numOfParticipate = json['num_of_participate'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['title_tagline'] = titleTagline;
    data['rules'] = rules;
    data['num_of_participate'] = numOfParticipate;
    return data;
  }
}
