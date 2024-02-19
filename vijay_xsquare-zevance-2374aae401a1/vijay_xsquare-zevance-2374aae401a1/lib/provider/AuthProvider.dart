import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grievance/model/Category.dart';
import 'package:grievance/model/UserModel.dart';
import 'package:grievance/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../model/FileData.dart';

class AuthProvider with ChangeNotifier {
  Future<Users?> login(BuildContext context, String email, String paswword,
      String type, String fcmToken) async {
    bool connection = await ConnectionChecker.check(context);
    if (!connection) {
      return null;
    }

    const url = BASE_URL + '/login';
    print(url);
    try {
      final response = await http.post(Uri.parse(url), body: {
        (type == "mobile") ? Constants.mobile_no : Constants.email: email,
        Constants.type: type,
        Constants.password: paswword,
        Constants.fcm_token: fcmToken,
      });

      print("sss");
      print(response.statusCode);
      print(response.body);

      final responseData = json.decode(response.body);

      if (kDebugMode) {
        print(responseData);
      }

      Users? users;
      try {
        ToastUtils.setSnackBar(context, responseData['message']);
      } catch (e) {
        rethrow;
      }
      if (response.statusCode == 200) {
        final prefs = await SharedPreferences.getInstance();
        prefs.setString(
            Constants.user,
            json.encode(
                Users.fromJson(responseData['user']['users'][0]).toJson()));
        prefs.setString(Constants.user_id,
            UserModel.fromJson(responseData['user']).users![0].id!);
        prefs.setString(
            Constants.access_token, responseData['access_token'].toString());
        users = Users.fromJson(responseData['user']['users'][0]);
        if (users.name!.isNotEmpty) {
          prefs.setBool(Constants.isLogin, true);
        }
      }
      return users;
    } catch (error) {
      rethrow;
    }
  }

  Future<Users?> loginV2(BuildContext context, String mobile_no, String country_code, String fcmToken) async {
    bool connection = await ConnectionChecker.check(context);
    if (!connection) {
      return null;
    }

    const url = BASE_URL_V2 + '/login';
    print(url);
    print({
      Constants.mobile_no : mobile_no,
      Constants.country_code: country_code,
      Constants.fcm_token: fcmToken,
    });
    try {
      final response = await http.post(Uri.parse(url), body: {
        Constants.mobile_no : mobile_no,
        Constants.country_code: country_code,
        Constants.fcm_token: fcmToken,
      });

      print("sss");
      print(response.statusCode);
      print(response.body);

      final responseData = json.decode(response.body);

      if (kDebugMode) {
        print(responseData);
      }

      Users? users;

      if (response.statusCode == 200) {
        final prefs = await SharedPreferences.getInstance();
        prefs.setString(
            Constants.user,
            json.encode(
                Users.fromJson(responseData['user']).toJson()));
        prefs.setString(Constants.user_id, Users.fromJson(responseData['user']).id!);
        prefs.setString(Constants.access_token, responseData['access_token'].toString());
        users = Users.fromJson(responseData['user']);
        prefs.setBool(Constants.isLogin, true);
        if (users.userable!.firstName! !=null && users.userable!.firstName!="") {
          prefs.setBool(Constants.isCreateProfile, true);
        }
      }else{
        try {
          ToastUtils.setSnackBar(context, responseData['message']);
        } catch (e) {
          rethrow;
        }
      }
      return users;
    } catch (error) {
      rethrow;
    }
  }

  Future<Users?> socialLogin(BuildContext context, String email, String token,
      String type, String fcmToken, String platform) async {
    bool connection = await ConnectionChecker.check(context);
    if (!connection) {
      return null;
    }
    const url = BASE_URL + '/social_media_login';
    print(url);
    try {
      final response = await http.post(Uri.parse(url), body: {
        (type == "mobile") ? Constants.mobile_no : Constants.email: email,
        Constants.type: type,
        Constants.token: token,
        Constants.fcm_token: fcmToken,
        Constants.platform: platform,
      });
      final responseData = json.decode(response.body);
      if (kDebugMode) {
        print(responseData);
      }
      Users? users;
      try {
        ToastUtils.setSnackBar(context, responseData['message']);
      } catch (e) {
        rethrow;
      }
      if (response.statusCode == 200) {
        print(responseData['access_token']);
        final prefs = await SharedPreferences.getInstance();
        prefs.setString(Constants.user,
            json.encode(Users.fromJson(responseData['user_object']).toJson()));
        prefs.setString(Constants.user_id,
            UserModel.fromJson(responseData['user_object']).users![0].id!);
        prefs.setString(
            Constants.access_token, responseData['access_token'].toString());
        prefs.setBool(Constants.isLogin, true);
        users = Users.fromJson(responseData['user_object']['users'][0]);
      }
      return users;
    } catch (error) {
      rethrow;
    }
  }

  Future<bool> signUp(BuildContext context, String email, String type) async {
    bool connection = await ConnectionChecker.check(context);
    if (!connection) {
      return false;
    }
    const url = BASE_URL + '/sign_up';
    try {
      final response = await http.post(Uri.parse(url), body: {
        (type == "mobile") ? Constants.mobile_no : Constants.email: email,
        Constants.type: type
      });
      final responseData = json.decode(response.body);
      if (kDebugMode) {
        print(responseData);
      }
      bool status = false;
      try {
        if (responseData['message'] != "success")
          ToastUtils.setSnackBar(context, responseData['message']);
      } catch (e) {
        rethrow;
      }
      if (response.statusCode == 200) {
        status = true;
      }
      return status;
    } catch (error) {
      ToastUtils.setSnackBar(context, "Server Error!");
      rethrow;
    }
  }

  Future<bool> forgotPassword(
      BuildContext context, String email, String type) async {
    bool connection = await ConnectionChecker.check(context);
    if (!connection) {
      return false;
    }
    const url = BASE_URL + '/forget_password';
    try {
      final response = await http.post(Uri.parse(url), body: {
        (type == "mobile") ? Constants.mobile_no : Constants.email: email,
        Constants.type: type
      });
      final responseData = json.decode(response.body);
      if (kDebugMode) {
        print(responseData);
      }
      bool status = false;
      try {
        ToastUtils.setSnackBar(context, responseData['message']);
      } catch (e) {
        rethrow;
      }
      if (response.statusCode == 200) {
        final prefs = await SharedPreferences.getInstance();
        prefs.setString(
            Constants.user,
            json.encode(
                UserModel.fromJson(responseData['user']['users'][0]).toJson()));
        prefs.setString(Constants.user_id,
            UserModel.fromJson(responseData['user']).users![0].id!);
        status = true;
      }
      return status;
    } catch (error) {
      ToastUtils.setSnackBar(context, "Server Error!");
      rethrow;
    }
  }

  Future<Users?> verifyOtp(
      BuildContext context, String email, String type, String otp) async {
    bool connection = await ConnectionChecker.check(context);
    if (!connection) {
      return null;
    }
    const url = BASE_URL + '/verify_otp';
    try {
      final response = await http.post(Uri.parse(url), body: {
        (type == "mobile") ? Constants.mobile_no : Constants.email: email,
        Constants.type: type,
        Constants.otp: otp,
      });
      final responseData = json.decode(response.body);
      if (kDebugMode) {
        print(responseData);
      }
      Users? users;
      try {
        ToastUtils.setSnackBar(context, responseData['message']);
      } catch (e) {
        rethrow;
      }
      if (response.statusCode == 200) {
        final prefs = await SharedPreferences.getInstance();
        prefs.setString(
            Constants.user,
            json.encode(
                Users.fromJson(responseData['user']['users'][0]).toJson()));
        prefs.setString(Constants.user_id,
            UserModel.fromJson(responseData['user']).users![0].id!);
        prefs.setString(Constants.access_token, responseData['access_token']);
        users = Users.fromJson(responseData['user']['users'][0]);
      }
      return users;
    } catch (error) {
      rethrow;
    }
  }

  Future<bool> createProfile(
      BuildContext context,
      String firstName,
      String lastName,
      String headline,
      String pincode,
      FileData? fileProfile,
      FileData? fileCover) async {
    bool connection = await ConnectionChecker.check(context);
    if (!connection) {
      return false;
    }

    const url = BASE_URL_V2 + '/create_profile';
    final prefs = await SharedPreferences.getInstance();
    var access_token = prefs.getString(Constants.access_token);
    var token = "Bearer " + access_token.toString();
    var userId = prefs.getString(Constants.user_id);

    print(url);
    try {
      var request =http.MultipartRequest(
        'POST',Uri.parse(url),
      );
      Map<String,String> headers={
        Constants.authorization:token,
        "Content-type": "multipart/form-data"
      };
      if(fileProfile!=null) {
        String gstFilename = fileProfile
            .file.path
            .split('/')
            .last;
        request.files.add(
          http.MultipartFile(
            Constants.profile_pic,
            fileProfile.file.readAsBytes().asStream(),
            fileProfile.file.lengthSync(),
            filename: gstFilename,
          ),
        );
      }
      if(fileCover!=null) {
        String cinFilename = fileCover
            .file.path
            .split('/')
            .last;
        request.files.add(
          http.MultipartFile(
            Constants.cover_image,
            fileCover.file.readAsBytes().asStream(),
            fileCover.file.lengthSync(),
            filename: cinFilename,
          ),
        );
      }
      request.headers.addAll(headers);
      request.fields.addAll({
        Constants.first_name: firstName,
        Constants.last_name: lastName,
        Constants.headline: headline,
        Constants.pincode: pincode,
      });
      bool status = false;
      http.StreamedResponse res = await request.send();
      print(res.statusCode);
      try {

        //ToastUtils.setSnackBar(context,result['message']);
        if (res.statusCode == 200) {
          final prefs = await SharedPreferences.getInstance();
          prefs.setBool(Constants.isCreateProfile, true);
          status = true;
        }else{
          var response = await http.Response.fromStream(res);
          final result = jsonDecode(response.body) as Map<String, dynamic>;
          ToastUtils.setSnackBar(context, result['message']);
          print(result);
        }
      }catch(e){
        print(e);
      }

      return status;
    } catch (error) {
      rethrow;
    }
  }

  Future<bool> resetPassword(BuildContext context, String password) async {
    bool connection = await ConnectionChecker.check(context);
    if (!connection) {
      return false;
    }

    const url = BASE_URL + '/reset_password';
    final prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString(Constants.user_id);
    print(userId);
    try {
      final response = await http.post(Uri.parse(url), body: {
        Constants.password: password,
        Constants.user_id: userId,
      });
      final responseData = json.decode(response.body);
      if (kDebugMode) {
        print(responseData);
      }
      bool status = false;
      try {
        ToastUtils.setSnackBar(context, responseData['message']);
      } catch (e) {
        rethrow;
      }
      if (response.statusCode == 200) {
        status = true;
      }
      return status;
    } catch (error) {
      rethrow;
    }
  }

  Future<List<Category>> getCategory(BuildContext context) async {
    bool connection = await ConnectionChecker.check(context);
    if (!connection) {
      return [];
    }
    const url = BASE_URL + '/get_category';
    final prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString(Constants.user_id);
    print(userId);
    try {
      final response = await http.get(Uri.parse(url));
      final responseData = json.decode(response.body);
      if (kDebugMode) {
        print(responseData);
      }
      return (responseData['catogories'] as List)
          .map((data) => Category.fromJson(data))
          .toList();
    } catch (error) {
      rethrow;
    }
  }

  Future<bool> updateCategory(BuildContext context, String ids) async {
    bool connection = await ConnectionChecker.check(context);
    if (!connection) {
      return false;
    }

    const url = BASE_URL + '/update_user_category';
    final prefs = await SharedPreferences.getInstance();
    var access_token = prefs.getString(Constants.access_token);
    var token = "Bearer " + access_token.toString();
    var userId = prefs.getString(Constants.user_id);
    print(userId);
    try {
      final response = await http.post(Uri.parse(url), headers: {
        Constants.authorization: token
      }, body: {
        Constants.category_ids: ids,
        Constants.user_id: userId,
      });
      final responseData = json.decode(response.body);
      if (kDebugMode) {
        print(responseData);
      }
      bool status = false;
      try {
        ToastUtils.setSnackBar(context, responseData['message']);
      } catch (e) {
        rethrow;
      }
      if (response.statusCode == 200) {
        status = true;
      }
      return status;
    } catch (error) {
      rethrow;
    }
  }

  Future<List<Category>> getUserInterest(BuildContext context) async {
    bool connection = await ConnectionChecker.check(context);
    if (!connection) {
      return [];
    }

    const url = BASE_URL + '/get_user_interest';
    final prefs = await SharedPreferences.getInstance();
    var accessToken = prefs.getString(Constants.access_token);
    print(accessToken);
    var token = "Bearer " + accessToken.toString();
    var userId = prefs.getString(Constants.user_id);
    print(userId);
    try {
      final response = await http.post(Uri.parse(url),
          headers: {Constants.authorization: token},
          body: {Constants.user_id: userId});

      print(response.body);
      final responseData = json.decode(response.body);
      if (kDebugMode) {
        print(responseData);
      }
      if (responseData['interest'] != null) {
        return (responseData['interest'] as List)
            .map((data) => Category.fromJson(data))
            .toList();
      } else {
        return [];
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<bool> deleteAccountApi(BuildContext context) async {
    bool connection=await ConnectionChecker.check(context);
    if(!connection){
      return false;
    }
    const url = '$BASE_URL/delete_profile';
    final prefs = await SharedPreferences.getInstance();
    var accessToken = prefs.getString(Constants.access_token);
    var token = "Bearer ${accessToken!}";
    try {
      final response = await http.post(Uri.parse(url), headers: {
        Constants.authorization: token
      },);
      final responseData = json.decode(response.body);
      if (kDebugMode) {
        print(responseData);
      }
      bool status = false;
      if (response.statusCode == 200) {
        status = true;
      }
      return status;
    } catch (error) {
      rethrow;
    }
  }
}
