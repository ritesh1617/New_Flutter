import 'package:grievance/model/Company.dart';
import 'package:grievance/model/UserModel.dart';
import 'package:grievance/utils/constants.dart';

class FeelModel {
  String? id;
  String? userId;
  String? feel;
  String? grievanceId;
  String? createdAt;
  String? updatedAt;
  Users? user;

  FeelModel(
      {this.id,
        this.userId,
        this.feel,
        this.grievanceId,
        this.createdAt,
        this.updatedAt,
        this.user});

  FeelModel.fromJson(Map<String, dynamic> json) {
    id = json['id']!=null?json['id'].toString():"";
    userId = json['user_id']!=null?json['user_id'].toString():"";
    feel = json['feel']!=null?json['feel'].toString():"";
    grievanceId = json['grievance_id']!=null?json['grievance_id'].toString():"";
    createdAt = json['created_at']!=null?json['created_at'].toString():"";
    updatedAt = json['updated_at']!=null?json['updated_at'].toString():"";
    user = json['user'] != null ? new Users.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['feel'] = this.feel;
    data['grievance_id'] = this.grievanceId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}
