class ContestUserRes {
  int? contestId;
  String? contestName;
  List<ParticipantsData> participants = [];

  ContestUserRes({contestId, contestName, participants});

  ContestUserRes.fromJson(Map<String, dynamic> json) {
    contestId = json['contest_id'];
    contestName = json['contest_name'];
    if (json['participants'] != null) {
      participants = <ParticipantsData>[];
      json['participants'].forEach((v) {
        participants.add(ParticipantsData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['contest_id'] = contestId;
    data['contest_name'] = contestName;
    if (participants.isNotEmpty) {
      data['participants'] = participants.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ParticipantsData {
  String? userId;
  String? userName;
  String? isWinner;
  String? userImage;

  ParticipantsData({userId, userName, isWinner, userImage});

  ParticipantsData.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'].toString();
    userName = json['user_name'];
    isWinner = json['is_winner'].toString();
    userImage = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['user_name'] = userName;
    data['is_winner'] = isWinner;
    data['image'] = userImage;
    return data;
  }
}
