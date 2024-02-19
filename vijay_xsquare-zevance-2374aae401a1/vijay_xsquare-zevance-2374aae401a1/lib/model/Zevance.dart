import 'package:grievance/model/UserModel.dart';

class Zevance {
  String? id;
  String? userId;
  String? name;
  String? address;
  String? mobileNo;
  String? email;
  String? gstNumber;
  String? gstCert;
  String? cinNumber;
  String? cinCert;
  String? panNumber;
  String? panCard;
  String? country;
  String? state;
  String? city;
  String? pincode;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? gstCertMediaType;
  String? cinCertMediaType;
  String? panCerdMediaType;
  String? image;
  String? coverImage;


  Zevance.fromJson(Map<String, dynamic> json) {
    id = json['id']!=null?json['id'].toString():"";
    userId = json['user_id']!=null?json['user_id'].toString():"";
    name = json['name']!=null?json['name'].toString():"";
    address = json['address']!=null?json['address'].toString():"";
    mobileNo = json['mobile_no']!=null?json['mobile_no'].toString():"";
    email = json['email']!=null?json['email'].toString():"";
    gstNumber = json['gst_number']!=null?json['gst_number'].toString():"";
    gstCert = json['gst_cert']!=null?json['gst_cert'].toString():"";
    cinNumber = json['cin_number']!=null?json['cin_number'].toString():"";
    cinCert = json['cin_cert']!=null?json['cin_cert'].toString():"";
    panNumber = json['pan_number']!=null?json['pan_number'].toString():"";
    panCard = json['pan_card']!=null?json['pan_card'].toString():"";
    createdAt = json['created_at']!=null?json['created_at'].toString():"";
    updatedAt = json['updated_at']!=null?json['updated_at'].toString():"";
    deletedAt = json['deleted_at']!=null?json['deleted_at'].toString():"";
    country = json['country']!=null?json['country'].toString():"";
    state = json['state']!=null?json['state'].toString():"";
    city = json['city']!=null?json['city'].toString():"";
    pincode = json['pincode']!=null?json['pincode'].toString():"";
    image = json['image']!=null?json['image'].toString():"";
    coverImage = json['cover_image']!=null?json['cover_image'].toString():"";
    gstCertMediaType = json['gst_cert_media_type']!=null?json['gst_cert_media_type'].toString():"";
    cinCertMediaType = json['cin_cert_media_type']!=null?json['cin_cert_media_type'].toString():"";
    panCerdMediaType = json['pan_card_media_type']!=null?json['pan_card_media_type'].toString():"";

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['name'] = name;
    data['address'] = address;
    data['mobile_no'] = mobileNo;
    data['email'] = email;
    data['gst_number'] = gstNumber;
    data['gst_cert'] = gstCert;
    data['cin_number'] = cinNumber;
    data['cin_cert'] = cinCert;
    data['pan_number'] = panNumber;
    data['pan_card'] = panCard;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['cover_image'] = coverImage;
    data['gst_cert_media_type'] = gstCertMediaType;
    data['cin_cert_media_type'] = cinCertMediaType;
    data['pan_card_media_type'] = panCerdMediaType;
    return data;
  }
}