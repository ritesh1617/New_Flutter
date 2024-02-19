class SignupModel {
  String? message;

  SignupModel(
      {this.message});

  SignupModel.fromJson(Map<String, dynamic> json) {
    message = json['message'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['message'] = message;
    return data;
  }

}

