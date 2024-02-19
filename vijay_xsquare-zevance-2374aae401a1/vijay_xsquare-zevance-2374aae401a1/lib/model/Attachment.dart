class AttachmentData {
  String? id;
  String? userId;
  String? attachmentableType;
  String? attachmentableId;
  String? type;
  String? mediaType;
  String? url;
  String? image_path;
  String? createdAt;
  String? updatedAt;

  AttachmentData(
      {this.id,
        this.userId,
        this.attachmentableType,
        this.attachmentableId,
        this.type,
        this.mediaType,
        this.url,
        this.createdAt,
        this.updatedAt});

  AttachmentData.fromJson(Map<String, dynamic> json) {
    id = json['id']!=null?json['id'].toString():"";
    userId = json['user_id']!=null?json['user_id'].toString():"";
    attachmentableType = json['attachmentable_type']!=null?json['attachmentable_type'].toString():"";
    attachmentableId = json['attachmentable_id']!=null?json['attachmentable_id'].toString():"";
    type = json['type']!=null?json['type'].toString():"";
    mediaType = json['media_type']!=null?json['media_type'].toString():"";
    url = json['url']!=null?json['url'].toString():"";
    image_path = json['image_path']!=null?json['image_path'].toString():"";
    createdAt = json['created_at']!=null?json['created_at'].toString():"";
    updatedAt = json['updated_at']!=null?json['updated_at'].toString():"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['attachmentable_type'] = attachmentableType;
    data['attachmentable_id'] = attachmentableId;
    data['type'] = type;
    data['media_type'] = mediaType;
    data['url'] = url;

    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}