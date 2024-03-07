import 'package:grievance/model/Attachment.dart';
import 'package:grievance/model/Company.dart';
import 'package:grievance/model/UserModel.dart';
import 'package:grievance/utils/constants.dart';

class Grievance {
  String? id;
  String? companyId;
  String? ticketNo;
  String? companyName;
  String? userId;
  String? title;
  String? description;
  String? desireOutcome;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? grievanceActivityStatus;
  String? grievanceActivityTime;
  String? grievanceCloseTime;
  String? totalGrievanceViews;
  bool isHide = false;
  bool isFeel = false;
  bool isLouder = false;
  bool anonymous = false;
  String? totalFeel;
  String? totalLoud;
  String? totalComment;
  Users? users;
  Company? company;
  List<Replies>? replies;
  List<AttachmentData>? attachments;
  AttachmentData? proofOfPurchase;

  Grievance();

  Grievance.fromJson(Map<String, dynamic> json) {
    id = json['id'] != null ? json['id'].toString() : "";
    companyId = json['company_id'] != null ? json['company_id'].toString() : "";
    ticketNo = json['ticket_no'] != null ? json['ticket_no'].toString() : "";
    grievanceActivityStatus = json['grievance_activity_status'] != null
        ? json['grievance_activity_status'].toString()
        : "";
    grievanceActivityTime = json['grievance_activity_time'] != null
        ? json['grievance_activity_time'].toString()
        : "";
    companyName =
        json['company_name'] != null ? json['company_name'].toString() : "";
    userId = json['user_id'] != null ? json['user_id'].toString() : "";
    title = json['title'] != null ? json['title'].toString() : "";
    description =
        json['description'] != null ? json['description'].toString() : "";
    desireOutcome =
        json['desire_outcome'] != null ? json['desire_outcome'].toString() : "";
    status = json['status'] != null ? json['status'].toString() : "";
    createdAt = json['created_at'] != null ? json['created_at'].toString() : "";
    updatedAt = json['updated_at'] != null ? json['updated_at'].toString() : "";
    deletedAt = json['deleted_at'] != null ? json['deleted_at'].toString() : "";
    isFeel = json['is_feel'];
    isLouder = json['is_louder'];
    anonymous = json['anonymous'] ?? false;
    isHide = (json['is_hide'] != null && json['is_hide'].toString() == "true")
        ? true
        : false;
    totalFeel = json['total_feel'] != null ? json['total_feel'].toString() : "";
    totalLoud = json['total_loud'] != null ? json['total_loud'].toString() : "";
    grievanceCloseTime = json['grievance_close_time'] != null
        ? json['grievance_close_time'].toString()
        : "";
    totalGrievanceViews = json['total_grievance_views'] != null
        ? json['total_grievance_views'].toString()
        : "";
    totalComment =
        json['total_comment'] != null ? json['total_comment'].toString() : "";
    users = json['users'] != null ? Users.fromJson(json['users']) : null;
    company =
        json['company'] != null ? Company.fromJson(json['company']) : null;
    replies = <Replies>[];
    if (json['replies'] != null) {
      json['replies'].forEach((v) {
        replies!.add(Replies.fromJson(v));
      });
    }
    if (json['attachments'] != null) {
      attachments = <AttachmentData>[];
      json['attachments'].forEach((v) {
        attachments!.add(AttachmentData.fromJson(v));
      });
    }
    proofOfPurchase = (json['proofofpurchase'] != null)?AttachmentData.fromJson(json['proofofpurchase']):null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['company_id'] = companyId;
    data['ticket_no'] = ticketNo;
    data['company_name'] = companyName;
    data['grievance_activity_status'] = grievanceActivityStatus;
    data['grievance_activity_time'] = grievanceActivityTime;
    data['grievance_close_time'] = grievanceCloseTime;
    data['user_id'] = userId;
    data['title'] = title;
    data['description'] = description;
    data['desire_outcome'] = desireOutcome;
    data['status'] = status;
    data['anonymous'] = anonymous;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['is_feel'] = isFeel;
    data['is_hide'] = isHide;
    data['is_louder'] = isLouder;
    data['total_feel'] = totalFeel;
    data['total_loud'] = totalLoud;
    data['total_comment'] = totalComment;
    data['total_grievance_views'] = totalGrievanceViews;
    if (users != null) {
      data['users'] = users!.toJson();
    }
    if (company != null) {
      data['company'] = company!.toJson();
    }
    if (replies != null) {
      data['replies'] = replies!.map((v) => v.toJson()).toList();
    }
    if (attachments != null) {
      data['attachments'] = attachments!.map((v) => v.toJson()).toList();
    }
    if (proofOfPurchase != null) {
      data['proofofpurchase'] = proofOfPurchase!.toJson();
    }
    return data;
  }
}

class Replies {
  String? id;
  String? userId;
  String? grievanceId;
  String? reply;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  DateTime? date;
  AttachmentData? singleattachment;
  Users? user;

  Replies({
    this.id,
    this.userId,
    this.grievanceId,
    this.reply,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.singleattachment,
    this.user,
    this.date
  });

  Replies.fromJson(Map<String, dynamic> json) {
    id = json['id'] != null ? json['id'].toString() : "";
    userId = json['user_id'] != null ? json['user_id'].toString() : "";
    grievanceId =
        json['grievance_id'] != null ? json['grievance_id'].toString() : "";
    reply = json['reply'];
    createdAt = json['created_at'];
    date = json['created_at']!= null ? Utils.date(json['created_at'].toString()) : DateTime.now();
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    singleattachment = json['singleattachment'] != null
        ? AttachmentData.fromJson(json['singleattachment'])
        : null;
    user = json['user'] != null ? Users.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['grievance_id'] = grievanceId;
    data['reply'] = reply;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    if (singleattachment != null) {
      data['singleattachment'] = singleattachment!.toJson();
    }
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}
