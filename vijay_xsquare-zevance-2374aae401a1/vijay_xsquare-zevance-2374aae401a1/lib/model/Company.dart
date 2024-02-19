import 'package:grievance/model/UserModel.dart';

class Company {
  String? id;
  String? companyName;
  String? logo;
  String? description;
  String? address;
  String? website;
  String? yearOfEstl;
  String? founder;
  String? ceo;
  String? dinOrCinNumber;
  String? gstNumber;
  String? noOfEmployees;
  String? isApproved;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? follower;
  String? openTickets;
  String? closedTickets;
  String? ClosureRation;
  String? zeescore;
  String? is_verified;
  bool? follow;
  List<Users>? users;
  Company.fromJson(Map<String, dynamic> json) {
    id = json['id']!=null?json['id'].toString():"";
    companyName = json['company_name']!=null?json['company_name'].toString():"";
    logo = json['logo']!=null?json['logo'].toString():"";
    description = json['description']!=null?json['description'].toString():"";
    address = json['address']!=null?json['address'].toString():"";
    website = json['website']!=null?json['website'].toString():"";
    yearOfEstl = json['year_of_estl']!=null?json['year_of_estl'].toString():"";
    founder = json['founder']!=null?json['founder'].toString():"";
    ceo = json['ceo']!=null?json['ceo'].toString():"";
    dinOrCinNumber = json['din_or_cin_number']!=null?json['din_or_cin_number'].toString():"";
    gstNumber = json['gst_number']!=null?json['gst_number'].toString():"";
    noOfEmployees = json['no_of_employees']!=null?json['no_of_employees'].toString():"";
    isApproved = json['is_approved']!=null?json['is_approved'].toString():"";
    createdAt = json['created_at']!=null?json['created_at'].toString():"";
    updatedAt = json['updated_at']!=null?json['updated_at'].toString():"";
    deletedAt = json['deleted_at']!=null?json['deleted_at'].toString():"";
    follower = json['follower']!=null?json['follower'].toString():"0";
    closedTickets = json['closed_tickets']!=null?json['closed_tickets'].toString():"";
    ClosureRation = json['ClosureRation']!=null?json['ClosureRation'].toString():"";
    openTickets = json['open_tickets']!=null?json['open_tickets'].toString():"";
    is_verified = json['is_verified']!=null?json['is_verified'].toString():"";
    zeescore = json['zeescore']!=null?json['zeescore'].toString():"0";
    follow = json['follow'];
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
    data['company_name'] = companyName;
    data['logo'] = logo;
    data['description'] = description;
    data['address'] = address;
    data['website'] = website;
    data['year_of_estl'] = yearOfEstl;
    data['founder'] = founder;
    data['ceo'] = ceo;
    data['din_or_cin_number'] = dinOrCinNumber;
    data['gst_number'] = gstNumber;
    data['no_of_employees'] = noOfEmployees;
    data['is_approved'] = isApproved;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['follow'] = follow;
    data['follower'] = follower;
    data['closed_tickets'] = closedTickets;
    data['zeescore'] = zeescore;
    data['open_tickets'] = openTickets;
    data['ClosureRation'] = ClosureRation;
    data['is_verified'] = is_verified;
    if (users != null) {
      data['users'] = users!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}