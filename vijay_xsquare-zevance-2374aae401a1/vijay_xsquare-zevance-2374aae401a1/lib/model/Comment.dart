import 'package:grievance/model/UserModel.dart';

class Comment {
  String? id;
  String? userId;
  String? grievanceId;
  String? parentCommentId;
  String? comment;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  int? totalLouder;
  bool? isLouder;
  Users? user;

  Comment(
      {this.id,
        this.userId,
        this.grievanceId,
        this.parentCommentId,
        this.comment,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.isLouder,
        this.user});

  Comment.fromJson(Map<String, dynamic> json) {
    id = json['id']!=null?json['id'].toString():"";
    userId = json['user_id']!=null?json['user_id'].toString():"";
    grievanceId = json['grievance_id']!=null?json['grievance_id'].toString():"";
    parentCommentId = json['parent_comment_id']!=null?json['parent_comment_id'].toString():"";
    comment = json['comment'];
    totalLouder = json['total_louder']!=null?int.parse(json['total_louder'].toString()):0;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    isLouder = json['is_louder'];
    user = json['user'] != null ? Users.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['grievance_id'] = grievanceId;
    data['parent_comment_id'] = parentCommentId;
    data['comment'] = comment;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['total_louder'] = totalLouder;
    data['is_louder'] = isLouder;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}
