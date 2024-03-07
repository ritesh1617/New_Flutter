import 'package:grievance/model/Company.dart';
import 'package:grievance/model/UserModel.dart';
import 'package:grievance/utils/constants.dart';

class Follower {
  String? id;
  String? userId;
  String? followerableType;
  String? followerableId;
  String? createdAt;
  String? updatedAt;
  Users? users;
  Company? company;

  Follower.fromJson(Map<String, dynamic> json) {
    id = json['id'] != null ? json["id"].toString() : "";
    userId = json['user_id'] != null ? json["user_id"].toString() : "";
    followerableType = json["followerable_type"] != null
        ? json["followerable_type"].toString()
        : "";
    followerableId = json['followerable_id'] != null
        ? json["followerable_id"].toString()
        : "";
    createdAt = json['created_at'] != null ? json["created_at"].toString() : "";
    updatedAt = json['updated_at'] != null ? json["updated_at"].toString() : "";
    if (json['followers'] != null) {
      users = json['followers'] != null
         // ? (json["followerable_type"] == Usertype.user)
              ? Users.fromJson(json['followers'])
              : null;
          //: null;

      // company = json['followers'] != null
      //     ? (json["followerable_type"] == Usertype.company)
      //         ? Company.fromJson(json['followers'])
      //         : null
      //     : null;
    }
    if (json['following'] != null) {
      users = json['following'] != null
          ? (json["followerable_type"] == Usertype.user)
          ? Users.fromJson(json['following'])
          : null
          : null;

      company = json['following'] != null
          ? (json["followerable_type"] == Usertype.company)
          ? Company.fromJson(json['following'])
          : null
          : null;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['followerable_type'] = followerableType;
    data['followerable_id'] = followerableId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (users != null) {
      data['followerable'] = users!.toJson();
    }
    if (company != null) {
      data['followerable'] = company!.toJson();
    }
    return data;
  }
}
