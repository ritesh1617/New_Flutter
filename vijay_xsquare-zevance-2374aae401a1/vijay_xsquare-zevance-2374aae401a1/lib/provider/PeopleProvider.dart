import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grievance/model/FeelModel.dart';
import 'package:grievance/model/Follower.dart';
import 'package:grievance/model/LouderModel.dart';
import 'package:grievance/model/UserModel.dart';
import 'package:grievance/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PeopleProvider with ChangeNotifier {
  Future<List<Users>> getPeopleList(BuildContext context,int page, String q) async {
    bool connection=await ConnectionChecker.check(context);
    if(!connection){
      return [];
    }
    const url = BASE_URL + '/get_all_users';
    final prefs = await SharedPreferences.getInstance();
    var accessToken = prefs.getString(Constants.access_token);
    var token = "Bearer " + accessToken!;
    try {
      final response = await http.post(Uri.parse(url),
          headers: {Constants.authorization: token},
          body: {Constants.page: page.toString(), Constants.q: q});
      final responseData = json.decode(response.body);
      if (response.statusCode == 200) {
        return (responseData['users']['data'] as List)
            .map((data) => Users.fromJson(data))
            .toList();
      } else {
        return [];
      }
    } catch (error) {
      print("Error " + error.toString());
      rethrow;
    }
  }

  Future<Users?> getProfileById(String userID) async {
    const url = BASE_URL + '/get_profile_by_id';
    final prefs = await SharedPreferences.getInstance();
    var accessToken = prefs.getString(Constants.access_token);
    var token = "Bearer " + accessToken!;
    try {
      final response = await http.post(Uri.parse(url),
          headers: {Constants.authorization: token},
          body: {Constants.user_id: userID});
      final responseData = json.decode(response.body);
      if (response.statusCode == 200) {
        return Users.fromJson(responseData['user'][0]);
      } else {
        return null;
      }
    } catch (error) {
      print("Error " + error.toString());
      rethrow;
    }
  }

  Future<bool> updateFollowApi(
      BuildContext context, String id, String type) async {
    bool connection=await ConnectionChecker.check(context);
    if(!connection){
      return false;
    }
    const url = BASE_URL + '/update_follow';
    final prefs = await SharedPreferences.getInstance();
    var accessToken = prefs.getString(Constants.access_token);
    var token = "Bearer " + accessToken!;
    try {
      final response = await http.post(Uri.parse(url), headers: {
        Constants.authorization: token
      }, body: {
        Constants.type: type,
        (FollowType.company == type) ? Constants.company_id : Constants.user_id: id,
      });
      final responseData = json.decode(response.body);
      if (kDebugMode) {
        print(responseData);
      }
      bool status = false;
      // try {
      //   ToastUtils.setSnackBar(context, responseData['message']);
      // } catch (e) {
      //   rethrow;
      // }
      if (response.statusCode == 200) {
        status = true;
      }
      return status;
    } catch (error) {
      rethrow;
    }
  }

  Future<List<Follower>> getFollowingList(int page, String q,String type,String userId,String profileType) async {
    var url = BASE_URL;
    if(type==FollowerType.following){
      url=url+'/following';
    }else{
      url=url+'/follower';
    }
    final prefs = await SharedPreferences.getInstance();
    var accessToken = prefs.getString(Constants.access_token);
    var token = "Bearer " + accessToken!;
    print(token);
    print({Constants.page: page.toString(), Constants.q: q,Constants.user_id:userId});

    try {
      final response = await http.post(Uri.parse(url),
          headers: {Constants.authorization: token},
          body: {Constants.page: page.toString(), Constants.q: q,Constants.user_id:userId,Constants.type:profileType});
      final responseData = json.decode(response.body);
      print(responseData);
      if (response.statusCode == 200) {
        if(type==FollowerType.following){
          return (responseData['following']['data'] as List)
              .map((data) => Follower.fromJson(data))
              .toList();
        }else{
          return (responseData['follower']['data'] as List)
              .map((data) => Follower.fromJson(data))
              .toList();
        }

      } else {
        return [];
      }
    } catch (error) {
      print("Error " + error.toString());
      rethrow;
    }
  }

  Future<List<FeelModel>> getIFeelYouList(int page,String grievanceId) async {
    var url = "$BASE_URL_V2/get_feel_you";
    final prefs = await SharedPreferences.getInstance();
    var accessToken = prefs.getString(Constants.access_token);
    var token = "Bearer ${accessToken!}";
    try {
      final response = await http.post(Uri.parse(url),
          headers: {Constants.authorization: token},
          body: {Constants.page: page.toString(),Constants.grievance_id:grievanceId});
      final responseData = json.decode(response.body);
      print(responseData);
      if (response.statusCode == 200) {
        return (responseData['data']['data'] as List)
            .map((data) => FeelModel.fromJson(data))
            .toList();
      } else {
        return [];
      }
    } catch (error) {
      print("Error $error");
      rethrow;
    }
  }

  Future<List<LouderModel>> getLouderList(int page,String grievanceId) async {
    var url = "$BASE_URL_V2/get_louder";
    final prefs = await SharedPreferences.getInstance();
    var accessToken = prefs.getString(Constants.access_token);
    var token = "Bearer ${accessToken!}";
    try {
      final response = await http.post(Uri.parse(url),
          headers: {Constants.authorization: token},
          body: {Constants.page: page.toString(),Constants.grievance_id:grievanceId});
      final responseData = json.decode(response.body);
      print(responseData);
      if (response.statusCode == 200) {
        return (responseData['data']['data'] as List)
            .map((data) => LouderModel.fromJson(data))
            .toList();
      } else {
        return [];
      }
    } catch (error) {
      print("Error $error");
      rethrow;
    }
  }

}
