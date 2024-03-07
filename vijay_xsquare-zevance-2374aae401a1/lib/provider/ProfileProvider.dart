import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:grievance/model/FileData.dart';
import 'package:grievance/model/Notification.dart' ;
import 'package:grievance/model/UserModel.dart';
import 'package:grievance/model/Zevance.dart';
import 'package:grievance/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProfileProvider with ChangeNotifier {
  Future<int> addZevance(BuildContext context, String name, String address, String mobileNumber,
      String email, String gstNumber, String cin,String pan,String country,String state,String city,String
      pincode,
      FileData? fileGST,FileData? fileCIN,FileData? filePAN,FileData? fileProfile,FileData? fileCover) async {
    bool connection=await ConnectionChecker.check(context);
    if(!connection){
      return 0;
    }
    const url = BASE_URL + '/zevance_store';
    final prefs = await SharedPreferences.getInstance();
    var accessToken = prefs.getString(Constants.access_token);
    var token = "Bearer " + accessToken!;
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
      if(fileGST!=null) {
        String gstFilename = fileGST
            .file.path
            .split('/')
            .last;
        request.files.add(
          http.MultipartFile(
            Constants.gst_cert,
            fileGST.file.readAsBytes().asStream(),
            fileGST.file.lengthSync(),
            filename: gstFilename,
          ),
        );

        request.fields.addAll({Constants.gst_cert_media_type:fileGST.type});
      }
      if(fileCIN!=null) {
        String cinFilename = fileCIN
            .file.path
            .split('/')
            .last;
        request.files.add(
          http.MultipartFile(
            Constants.cin_cert,
            fileCIN.file.readAsBytes().asStream(),
            fileCIN.file.lengthSync(),
            filename: cinFilename,
          ),
        );

        request.fields.addAll({Constants.cin_cert_media_type:fileCIN.type});
      }
      if(filePAN!=null) {
        String panFilename = filePAN
            .file.path
            .split('/')
            .last;
        request.files.add(
          http.MultipartFile(
            Constants.pan_card,
            filePAN.file.readAsBytes().asStream(),
            filePAN.file.lengthSync(),
            filename: panFilename,
          ),
        );

        request.fields.addAll({Constants.pan_card_media_type:filePAN.type});
      }

      request.headers.addAll(headers);
      request.fields.addAll({
        Constants.name: name,
        Constants.address: address,
        Constants.mobile_no: mobileNumber,
        Constants.email: email,
        Constants.gst_no: gstNumber,
        Constants.cin_number: cin,
        Constants.pan_number: pan,
        Constants.county: country,
        Constants.state: state,
        Constants.city: city,
        Constants.pincode: pincode,
      });
      print({
        Constants.name: name,
        Constants.address: address,
        Constants.mobile_no: mobileNumber,
        Constants.email: email,
        Constants.gst_no: gstNumber,
        Constants.cin_number: cin,
        Constants.pan_number: pan,
        Constants.county: country,
        Constants.state: state,
        Constants.city: city,
        Constants.pincode: pincode,
      });
      http.StreamedResponse res = await request.send();
      // final responseData = json.decode(res.body);
      log(res.toString());
      return res.statusCode;
    } catch (error) {
      print("error" + error.toString());
      throw (error);
    }
  }

  Future<int> updateProfile(BuildContext context, String firstName, String lastName, String mobileNo,
      String username, String email, String pincode, String bio,FileData? fileProfile,FileData? fileCover) async {
    bool connection=await ConnectionChecker.check(context);
    if(!connection){
      return 0;
    }
    const url = BASE_URL + '/update_profile';
    final prefs = await SharedPreferences.getInstance();
    var accessToken = prefs.getString(Constants.access_token);
    var token = "Bearer " + accessToken!;
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
        Constants.mobile_no: mobileNo,
        Constants.username: username,
        Constants.email: email,
        Constants.pincode: pincode,
        Constants.bio: bio,
      });
      print("request: "+request.toString());
      http.StreamedResponse res = await request.send();
      try {
        var response = await http.Response.fromStream(res);
        final result = jsonDecode(response.body) as Map<String, dynamic>;
        print("=====================");
        ToastUtils.setSnackBar(context,result['message']);
        print(result);
      }catch(e){

      }
      log("Progress ++ "+res.toString());
      return res.statusCode;
    } catch (error) {
      print("error" + error.toString());
      throw (error);
    }
  }

  Future<Users?> getProfile(BuildContext context) async {
    const url = BASE_URL + '/get_profile';
    final prefs = await SharedPreferences.getInstance();
    var accessToken = prefs.getString(Constants.access_token);
    print(url);
    var token = "Bearer " + accessToken.toString();
    try {
      final response = await http
          .post(Uri.parse(url), headers: {Constants.authorization: token});
      final responseData = json.decode(response.body);
      if (kDebugMode) {
        print(responseData);
      }
      Users? data;
      if (response.statusCode == 200) {
        final prefs = await SharedPreferences.getInstance();
        prefs.setString(Constants.user,
            json.encode(Users.fromJson(responseData['user'][0]).toJson()));
        prefs.setString(
            Constants.user_id, Users.fromJson(responseData['user'][0]).id!);
        data=Users.fromJson(responseData['user'][0]);
      }
      print(data);
      return data;
    } catch (error) {
      rethrow;
    }
  }

  Future<Zevance?> getZevanceDetails() async {
    const url = BASE_URL + '/zevance_business_detail';
    final prefs = await SharedPreferences.getInstance();
    var accessToken = prefs.getString(Constants.access_token);
    print(url);
    var token = "Bearer " + accessToken.toString();
    try {
      final response = await http
          .post(Uri.parse(url), headers: {Constants.authorization: token});
      final responseData = json.decode(response.body);
      if (kDebugMode) {
        print(responseData);
      }
      Zevance? data;
      if (response.statusCode == 200) {
         try {
          data = Zevance.fromJson(responseData['user'][0]);
        }catch(e){}
      }
      print(data);
      return data;
    } catch (error) {
      rethrow;
    }
  }

  Future<List<NotificationData>> getNotificationList(int page) async {
    var url = BASE_URL+'/get_notification';
    final prefs = await SharedPreferences.getInstance();
    var accessToken = prefs.getString(Constants.access_token);
    var token = "Bearer " + accessToken!;
    try {
      final response = await http.post(Uri.parse(url),
          headers: {Constants.authorization: token},
          body: {Constants.page: page.toString()});
      final responseData = json.decode(response.body);
      print(responseData);
      if (response.statusCode == 200) {
          return (responseData['notifications']['data'] as List)
              .map((data) => NotificationData.fromJson(data))
              .toList();
      } else {
        return [];
      }
    } catch (error) {
      print("Error " + error.toString());
      rethrow;
    }
  }
}
