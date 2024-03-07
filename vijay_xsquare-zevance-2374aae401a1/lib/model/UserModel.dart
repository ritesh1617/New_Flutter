class UserModel {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? mobileNo;
  String? isActive;
  String? otp;
  String? socialMedia;
  String? socialMedialToken;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  List<Users>? users;



  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id']!=null?json['id'].toString():"";
    firstName = json['first_name']!=null?json['first_name'].toString():"";
    lastName = json['last_name']!=null?json['last_name'].toString():"";
    email = json['email']!=null?json['email'].toString():"";
    mobileNo = json['mobile_no']!=null?json['mobile_no'].toString():"";
    isActive = json['is_active']!=null?json['is_active'].toString():"";
    otp = json['otp']!=null?json['otp'].toString():"";
    socialMedia = json['social_media']!=null?json['social_media'].toString():"";
    socialMedialToken = json['social_medial_token']!=null?json['social_medial_token'].toString():"";
    createdAt = json['created_at']!=null?json['created_at'].toString():"";
    updatedAt = json['updated_at']!=null?json['updated_at'].toString():"";
    deletedAt = json['deleted_at']!=null?json['deleted_at'].toString():"";
    if (json['users'] != null) {
      users = <Users>[];
      json['users'].forEach((v) {
        users!.add(Users.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['mobile_no'] = mobileNo;
    data['is_active'] = isActive;
    data['otp'] = otp;
    data['social_media'] = socialMedia;
    data['social_medial_token'] = socialMedialToken;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    if (users != null) {
      data['users'] = users!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Users {
  String? id;
  String? firstName;
  String? lastName;
  String? name;
  String? username;
  String? email;
  String? mobileNumber;
  String? emailVerifiedAt;
  String? image;
  String? bio;
  String? pincode;
  String? headline;
  String? coverImage;
  String? userableType;
  String? userableId;
  String? createdAt;
  String? updatedAt;
  String? followers;
  String? following;
  bool? follow;
  Users? userable;


  Users.fromJson(Map<String, dynamic> json) {
    id = json['id']!=null?json['id'].toString():"";
    firstName = json['first_name']!=null?json['first_name'].toString():"";
    lastName = json['last_name']!=null?json['last_name'].toString():"";
    name = json['name']!=null?json['name'].toString():"";
    username = json['username']!=null?json['username'].toString():"";
    email = json['email']!=null?json['email'].toString():"";
    mobileNumber = json['mobile_no']!=null?json['mobile_no'].toString():"";
    emailVerifiedAt = json['email_verified_at']!=null?json['email_verified_at'].toString():"";
    image = json['image']!=null?json['image'].toString():"";
    bio = json['bio']!=null?json['bio'].toString():"";
    pincode = json['pincode']!=null?json['pincode'].toString():"";
    headline = json['headline']!=null?json['headline'].toString():"";
    coverImage = json['cover_image']!=null?json['cover_image'].toString():"";
    userableType = json['userable_type']!=null?json['userable_type'].toString():"";
    userableId = json['userable_id']!=null?json['userable_id'].toString():"";
    createdAt = json['created_at']!=null?json['created_at'].toString():"";
    updatedAt = json['updated_at']!=null?json['updated_at'].toString():"";
    followers = json['followers']!=null?json['followers'].toString():"0";
    following = json['following']!=null?json['following'].toString():"0";
    follow = json['follow'] ?? false;
    userable = json['userable'] != null ? Users.fromJson(json['userable']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['username'] = username;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['mobile_no'] = mobileNumber;
    data['email_verified_at'] = emailVerifiedAt;
    data['image'] = image;
    data['bio'] = bio;
    data['pincode'] = pincode;
    data['headline'] = headline;
    data['cover_image'] = coverImage;
    data['userable_type'] = userableType;
    data['userable_id'] = userableId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['followers'] = followers;
    data['following'] = following;
    if (userable != null) {
      data['userable'] = userable!.toJson();
    }
    return data;
  }
}
