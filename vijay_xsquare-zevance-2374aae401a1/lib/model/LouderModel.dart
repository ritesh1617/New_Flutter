import 'package:grievance/model/Company.dart';
import 'package:grievance/model/UserModel.dart';
import 'package:grievance/utils/constants.dart';

class LouderModel {
  String? id;
  String? louderableId;
  String? louderableType;
  String? louder;
  String? userId;
  String? createdAt;
  String? updatedAt;
  Users? user;

  LouderModel(
      {this.id,
        this.louderableId,
        this.louderableType,
        this.louder,
        this.userId,
        this.createdAt,
        this.updatedAt,
        this.user});

  LouderModel.fromJson(Map<String, dynamic> json) {
    id = json['id']!=null?json['id'].toString():"";
    louderableId = json['louderable_id']!=null?json['louderable_id'].toString():"";
    louderableType = json['louderable_type']!=null?json['louderable_type'].toString():"";
    louder = json['louder']!=null?json['louder'].toString():"";
    userId = json['user_id']!=null?json['user_id'].toString():"";
    createdAt = json['created_at']!=null?json['created_at'].toString():"";
    updatedAt = json['updated_at']!=null?json['updated_at'].toString():"";
    user = json['user'] != null ? new Users.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['louderable_id'] = this.louderableId;
    data['louderable_type'] = this.louderableType;
    data['louder'] = this.louder;
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

