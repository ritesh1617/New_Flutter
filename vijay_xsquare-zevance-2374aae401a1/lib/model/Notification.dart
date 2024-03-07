class NotificationData {
  String? id;
  String? notificationType;
  String? title;
  String? description;
  String? userType;
  String? userId;
  String? companyId;
  String? status;
  String? createdAt;
  String? updatedAt;

  NotificationData.fromJson(Map<String, dynamic> json) {
    id = json['id'] != null ? json['id'].toString() : "";
    notificationType = json['notification_type'] != null
        ? json['notification_type'].toString()
        : "";
    title = json['title'] != null ? json['title'].toString() : "";
    description =
        json['description'] != null ? json['description'].toString() : "";
    userType = json['user_type'] != null ? json['user_type'].toString() : "";
    userId = json['user_id'] != null ? json['user_id'].toString() : "";
    companyId = json['company_id'] != null ? json['company_id'].toString() : "";
    status = json['status'] != null ? json['status'].toString() : "";
    createdAt = json['created_at'] != null ? json['created_at'].toString() : "";
    updatedAt = json['updated_at'] != null ? json['updated_at'].toString() : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['notification_type'] = notificationType;
    data['title'] = title;
    data['description'] = description;
    data['user_type'] = userType;
    data['user_id'] = userId;
    data['company_id'] = companyId;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
