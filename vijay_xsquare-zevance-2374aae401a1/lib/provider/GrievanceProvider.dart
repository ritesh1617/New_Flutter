import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grievance/model/Category.dart';
import 'package:grievance/model/Comment.dart';
import 'package:grievance/model/FileData.dart';
import 'package:grievance/model/Follower.dart';
import 'package:grievance/model/Grievance.dart';
import 'package:grievance/model/UserModel.dart';
import 'package:grievance/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class GrievanceProvider with ChangeNotifier {
  // Future<bool> addGrievance(BuildContext context, String title, String details,
  //     String companyId, String companyName, String desiredOutcome) async {
  //   const url = BASE_URL + '/submit_grievance';
  //   final prefs = await SharedPreferences.getInstance();
  //   var accessToken = prefs.getString(Constants.access_token);
  //   var token = "Bearer " + accessToken!;
  //   var userId = prefs.getString(Constants.user_id);
  //   print("Request");
  //   print({
  //     Constants.title: title,
  //     Constants.grievance_detail: details,
  //     Constants.company_id: companyId,
  //     Constants.company_name: companyName,
  //     Constants.desired_outcome: desiredOutcome,
  //     Constants.user_id: userId,
  //   });
  //   try {
  //     final response = await http.post(Uri.parse(url), headers: {
  //       Constants.authorization: token
  //     }, body: {
  //       Constants.title: title,
  //       Constants.grievance_detail: details,
  //       Constants.company_id: companyId,
  //       Constants.company_name: companyName,
  //       Constants.desired_outcome: desiredOutcome,
  //       Constants.user_id: userId,
  //     });
  //     final responseData = json.decode(response.body);
  //     if (kDebugMode) {
  //       print(responseData);
  //     }
  //     bool status = false;
  //     try {
  //       ToastUtils.setSnackBar(context, responseData['message']);
  //     } catch (e) {
  //       rethrow;
  //     }
  //     if (response.statusCode == 200) {
  //       status = true;
  //     }
  //     return status;
  //   } catch (error) {
  //     rethrow;
  //   }
  // }

  Future<Grievance?> addGrievance(
      BuildContext context,
      String title,
      String details,
      String companyId,
      String companyName,
      String desiredOutcome,
      String desiredOutcomeDetails,
      FileData? attachment,
      FileData? purchaseProof,
      bool anonymous) async {

    bool connection=await ConnectionChecker.check(context);
    if(!connection){
      return null;
    }
    const url = '$BASE_URL/submit_grievance';
    final prefs = await SharedPreferences.getInstance();
    var accessToken = prefs.getString(Constants.access_token);
    var token = "Bearer ${accessToken!}";
    var userId = prefs.getString(Constants.user_id);
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(url),
      );
      Map<String, String> headers = {
        Constants.authorization: token,
        "Content-type": "multipart/form-data"
      };
      if (attachment != null) {
        String gstFilename = attachment.file.path.split('/').last;
        request.files.add(
          http.MultipartFile(
            Constants.attachment,
            attachment.file.readAsBytes().asStream(),
            attachment.file.lengthSync(),
            filename: gstFilename,
          ),
        );
        request.fields.addAll({Constants.media_type: attachment.type});
      }
      if (purchaseProof != null) {
        String gstFilename = purchaseProof.file.path.split('/').last;
        request.files.add(
          http.MultipartFile(
            Constants.proof_of_purchase,
            purchaseProof.file.readAsBytes().asStream(),
            purchaseProof.file.lengthSync(),
            filename: gstFilename,
          ),
        );
        request.fields.addAll({Constants.proof_media_type: purchaseProof.type});
      }

      request.headers.addAll(headers);
      request.fields.addAll({
        Constants.title: title,
        Constants.grievance_detail: details,
        Constants.company_id: companyId,
        Constants.company_name: companyName,
        Constants.desired_outcome: desiredOutcome,
        Constants.desire_outcome_description: desiredOutcomeDetails,
        Constants.user_id: userId!,
        Constants.anonymous: anonymous.toString(),
      });
      print("request: " + request.toString());
      print({
        Constants.title: title,
        Constants.grievance_detail: details,
        Constants.company_id: companyId,
        Constants.company_name: companyName,
        Constants.desired_outcome: desiredOutcome,
        Constants.desire_outcome_description: desiredOutcomeDetails,
        Constants.user_id: userId,
        Constants.anonymous: anonymous.toString(),
      });
      http.StreamedResponse res = await request.send();
      // final responseData = json.decode(res.body);
      Grievance? data=null;
      try {
        var response = await http.Response.fromStream(res);
        final result = jsonDecode(response.body) as Map<String, dynamic>;
        print("=====================");
        print(result);
        data = Grievance.fromJson(result["grievances"]);
      }catch(e){

      }
      return data;
    } catch (error) {
      print("error" + error.toString());
      throw (error);
    }
  }

  Future<Grievance?> addProofOfPurchase(
      BuildContext context,
      String grievanceId,
      FileData? purchaseProof,
     ) async {

    bool connection=await ConnectionChecker.check(context);
    if(!connection){
      return null;
    }
    const url = '$BASE_URL/update_proof_of_purchase';
    final prefs = await SharedPreferences.getInstance();
    var accessToken = prefs.getString(Constants.access_token);
    var token = "Bearer ${accessToken!}";
    var userId = prefs.getString(Constants.user_id);
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(url),
      );
      Map<String, String> headers = {
        Constants.authorization: token,
        "Content-type": "multipart/form-data"
      };

      if (purchaseProof != null) {
        String gstFilename = purchaseProof.file.path.split('/').last;
        request.files.add(
          http.MultipartFile(
            Constants.proof_of_purchase,
            purchaseProof.file.readAsBytes().asStream(),
            purchaseProof.file.lengthSync(),
            filename: gstFilename,
          ),
        );
        request.fields.addAll({Constants.proof_media_type: purchaseProof.type});
      }
      request.headers.addAll(headers);
      request.fields.addAll({
        Constants.grievance_id: grievanceId,

      });
      print("request: " + request.toString());
      http.StreamedResponse res = await request.send();
      // final responseData = json.decode(res.body);
      Grievance? data=null;
      try {
        var response = await http.Response.fromStream(res);
        final result = jsonDecode(response.body) as Map<String, dynamic>;
        print("=====================");
        log(result.toString());
        data = Grievance.fromJson(result["data"]);
      }catch(e){

      }
      return data;
    } catch (error) {
      print("error" + error.toString());
      throw (error);
    }
  }

  Future<List<Grievance>> getGrievanceByPageAndType(BuildContext context, int page, String type) async {

    bool connection=await ConnectionChecker.check(context);
    if(!connection){
      return [];
    }

    const url = BASE_URL + '/get_grievance';
    print(url);
    final prefs = await SharedPreferences.getInstance();
    var accessToken = prefs.getString(Constants.access_token);
    var token = "Bearer " + accessToken!;
    print(token);
    var userId = prefs.getString(Constants.user_id);
    try {
      final response = await http.post(Uri.parse(url),
          headers: {Constants.authorization: token},
          body: {Constants.page: page.toString(), Constants.type: type});
      print(response);
      final responseData = json.decode(response.body);
      print(responseData);
      if (response.statusCode == 200) {
        return (responseData['grievances']['data'] as List)
            .map((data) => Grievance.fromJson(data))
            .toList();
      } else {
        return [];
      }
    } catch (error) {
      print(error.toString());
      rethrow;
    }
  }

  Future<List<Grievance>> searchGrievance(BuildContext context,int page, String searchText) async {
    bool connection=await ConnectionChecker.check(context);
    if(!connection){
      return [];
    }

    const url = BASE_URL + '/get_all_grievances';
    final prefs = await SharedPreferences.getInstance();
    var accessToken = prefs.getString(Constants.access_token);
    var token = "Bearer " + accessToken!;
    print("Search text= " + searchText);
    try {
      final response = await http.post(Uri.parse(url),
          headers: {Constants.authorization: token},
          body: {Constants.page: page.toString(), Constants.q: searchText});
      final responseData = json.decode(response.body);
      print(responseData);
      if (response.statusCode == 200) {
        return (responseData['grievances']['data'] as List)
            .map((data) => Grievance.fromJson(data))
            .toList();
      } else {
        return [];
      }
    } catch (error) {
      print(error.toString());
      rethrow;
    }
  }

  Future<Grievance?> getGrievanceById(BuildContext context,String grievanceId) async {
    bool connection=await ConnectionChecker.check(context);
    if(!connection){
      return null;
    }
    const url = BASE_URL + '/get_grievance_by_id';
    final prefs = await SharedPreferences.getInstance();
    var accessToken = prefs.getString(Constants.access_token);
    var token = "Bearer " + accessToken!;
    log(token);
    try {
      final response = await http.post(Uri.parse(url),
          headers: {Constants.authorization: token},
          body: {Constants.grievance_id: grievanceId});
      final responseData = json.decode(response.body);
      print(responseData);
      if (response.statusCode == 200) {
        return Grievance.fromJson(responseData['grievance']);
      } else {
        return null;
      }
    } catch (error) {
      print(error.toString());
      rethrow;
    }
  }

  Future<bool> usernameVerifyApi(BuildContext context, String username) async {
    const url = BASE_URL + '/check_username_availabily';
    final prefs = await SharedPreferences.getInstance();
    var accessToken = prefs.getString(Constants.access_token);
    var token = "Bearer " + accessToken!;
    try {
      final response = await http.post(Uri.parse(url), headers: {
        Constants.authorization: token
      }, body: {
        Constants.username: username,
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

  Future<bool> hidePostApi(BuildContext context, String grievanceId) async {
    bool connection=await ConnectionChecker.check(context);
    if(!connection){
      return false;
    }
    const url = '$BASE_URL_V2/hide_post';
    final prefs = await SharedPreferences.getInstance();
    var accessToken = prefs.getString(Constants.access_token);
    var token = "Bearer ${accessToken!}";
    try {
      final response = await http.post(Uri.parse(url), headers: {
        Constants.authorization: token
      }, body: {
        Constants.grievance_id: grievanceId,
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

  Future<bool> updateFeelYouApi(BuildContext context, String grievanceId) async {
    bool connection=await ConnectionChecker.check(context);
    if(!connection){
      return false;
    }
    const url = BASE_URL + '/update_feel';
    final prefs = await SharedPreferences.getInstance();
    var accessToken = prefs.getString(Constants.access_token);
    var token = "Bearer " + accessToken!;
    try {
      final response = await http.post(Uri.parse(url), headers: {
        Constants.authorization: token
      }, body: {
        Constants.grievance_id: grievanceId,
        Constants.feel: 'yes',
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

  Future<bool> updateLouderApi(BuildContext context, String id, String type) async {
    bool connection=await ConnectionChecker.check(context);
    if(!connection){
      return false;
    }
    const url = BASE_URL + '/update_louder';
    final prefs = await SharedPreferences.getInstance();
    var accessToken = prefs.getString(Constants.access_token);
    var token = "Bearer " + accessToken!;
    try {
      final response = await http.post(Uri.parse(url), headers: {
        Constants.authorization: token
      }, body: {
        (type == LouderType.grievance)
            ? Constants.grievance_id
            : Constants.comment_id: id,
        Constants.type: type,
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

  Future<bool> updateGrievanceStatusApi(BuildContext context, String id, String gStatus) async {
    bool connection=await ConnectionChecker.check(context);
    if(!connection){
      return false;
    }
    const url = BASE_URL + '/update_grievance_status';
    final prefs = await SharedPreferences.getInstance();
    var accessToken = prefs.getString(Constants.access_token);
    var token = "Bearer " + accessToken!;
    try {
      final response = await http.post(Uri.parse(url), headers: {
        Constants.authorization: token
      }, body: {
        Constants.status: gStatus,
        Constants.grievance_id: id,
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

  Future<bool> submitGrievanceApi(BuildContext context, String id) async {
    bool connection=await ConnectionChecker.check(context);
    if(!connection){
      return false;
    }
    const url = BASE_URL + '/submit_grievance';
    final prefs = await SharedPreferences.getInstance();
    var accessToken = prefs.getString(Constants.access_token);
    var token = "Bearer " + accessToken!;
    try {
      final response = await http.post(Uri.parse(url), headers: {
        Constants.authorization: token
      }, body: {
        Constants.parent_grievance_id: id,
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

  Future<bool> makeCommentApi(BuildContext context, String grievanceId, String comment) async {
    bool connection=await ConnectionChecker.check(context);
    if(!connection){
      return false;
    }
    print(grievanceId);
    print(comment);
    const url = BASE_URL + '/store_comment';
    final prefs = await SharedPreferences.getInstance();
    var accessToken = prefs.getString(Constants.access_token);
    var token = "Bearer " + accessToken!;
    try {
      final response = await http.post(Uri.parse(url), headers: {
        Constants.authorization: token
      }, body: {
        Constants.grievance_id: grievanceId,
        Constants.comment: comment,
      });
      final responseData = json.decode(response.body);
      print(responseData);
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
      print(error);
      return false;
    }
  }

  Future<bool?> makeRepliesWithAttachmentApi(
      BuildContext context,
      String grievanceId,
      FileData? attachment,
      ) async {

    bool connection=await ConnectionChecker.check(context);
    if(!connection){
      return null;
    }
    const url = '$BASE_URL/grievance_reply';
    final prefs = await SharedPreferences.getInstance();
    var accessToken = prefs.getString(Constants.access_token);
    var token = "Bearer ${accessToken!}";
    var userId = prefs.getString(Constants.user_id);
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(url),
      );
      Map<String, String> headers = {
        Constants.authorization: token,
        "Content-type": "multipart/form-data"
      };

      if (attachment != null) {
        String gstFilename = attachment.file.path.split('/').last;
        request.files.add(
          http.MultipartFile(
            Constants.attachment,
            attachment.file.readAsBytes().asStream(),
            attachment.file.lengthSync(),
            filename: gstFilename,
          ),
        );
        request.fields.addAll({Constants.media_type: attachment.type});
      }
      request.headers.addAll(headers);
      request.fields.addAll({
        Constants.grievance_id: grievanceId,

      });
      print("request: " + request.toString());
      http.StreamedResponse res = await request.send();
      // final responseData = json.decode(res.body);
      bool data=false;
      try {
        var response = await http.Response.fromStream(res);
        if(response.statusCode==200){
          data=true;
        }
      }catch(e){

      }
      return data;
    } catch (error) {
      print("error" + error.toString());
      throw (error);
    }
  }

  Future<bool> makeRepliesApi(BuildContext context, String grievanceId, String grievance_detail) async {
    bool connection=await ConnectionChecker.check(context);
    if(!connection){
      return false;
    }
    const url = BASE_URL + '/grievance_reply';
    final prefs = await SharedPreferences.getInstance();
    var accessToken = prefs.getString(Constants.access_token);
    var token = "Bearer " + accessToken!;
    try {
      final response = await http.post(Uri.parse(url), headers: {
        Constants.authorization: token
      }, body: {
        Constants.grievance_id: grievanceId,
        Constants.grievance_detail: grievance_detail,
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

  Future<List<Comment>> getComment(BuildContext context,int page, String grievanceId) async {
    bool connection=await ConnectionChecker.check(context);
    if(!connection){
      return [];
    }
    const url = '$BASE_URL/get_comment';
    final prefs = await SharedPreferences.getInstance();
    var accessToken = prefs.getString(Constants.access_token);
    var token = "Bearer ${accessToken!}";
    var userId = prefs.getString(Constants.user_id);
    try {
      final response = await http.post(Uri.parse(url), headers: {
        Constants.authorization: token
      }, body: {
        Constants.page: page.toString(),
        Constants.grievance_id: grievanceId
      });
      final responseData = json.decode(response.body);
      print(responseData);
      if (response.statusCode == 200) {
        return (responseData['comment']['data'] as List)
            .map((data) => Comment.fromJson(data))
            .toList();
      } else {
        return [];
      }
    } catch (error) {
      print(error.toString());
      rethrow;
    }
  }

  Future<List<Replies>> getReplies(BuildContext context,int page, String grievanceId) async {
    const url = BASE_URL + '/grievance_reply_list';
    final prefs = await SharedPreferences.getInstance();
    var accessToken = prefs.getString(Constants.access_token);
    var token = "Bearer " + accessToken!;
    var userId = prefs.getString(Constants.user_id);
    try {
      final response = await http.post(Uri.parse(url), headers: {
        Constants.authorization: token
      }, body: {
        Constants.page: page.toString(),
        Constants.grievance_id: grievanceId
      });
      final responseData = json.decode(response.body);
      print(responseData);
      if (response.statusCode == 200) {
        return (responseData['replies']['data'] as List)
            .map((data) => Replies.fromJson(data))
            .toList();
      } else {
        return [];
      }
    } catch (error) {
      print(error.toString());
      rethrow;
    }
  }

  Future<List<Grievance>> getGrievanceListByUserID(BuildContext context,int page, String filter, String userId) async {
    bool connection=await ConnectionChecker.check(context);
    if(!connection){
      return [];
    }
    const url = BASE_URL + '/get_grievance_by_user_id';
    final prefs = await SharedPreferences.getInstance();
    var accessToken = prefs.getString(Constants.access_token);
    var token = "Bearer " + accessToken!;
    print("Search text= " + filter);
    try {
      final response = await http.post(Uri.parse(url), headers: {
        Constants.authorization: token
      }, body: {
        Constants.page: page.toString(),
        Constants.filter: filter,
        Constants.user_id: userId
      });
      final responseData = json.decode(response.body);
      print(responseData);
      if (response.statusCode == 200) {
        return (responseData['grievance']['data'] as List)
            .map((data) => Grievance.fromJson(data))
            .toList();
      } else {
        return [];
      }
    } catch (error) {
      print(error.toString());
      rethrow;
    }
  }

  Future<bool> feedbackApi(BuildContext context, String grievanceId, String feedback,String rating) async {
    bool connection=await ConnectionChecker.check(context);
    if(!connection){
      return false;
    }
    const url = BASE_URL + '/store_grievance_feedback';
    final prefs = await SharedPreferences.getInstance();
    var accessToken = prefs.getString(Constants.access_token);
    var token = "Bearer " + accessToken!;
    try {
      final response = await http.post(Uri.parse(url), headers: {
        Constants.authorization: token
      }, body: {
        Constants.grievance_id: grievanceId,
        Constants.rating: rating,
        Constants.comment: feedback,
      });
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

  Future<int> getNotificationCount() async {
    const url = BASE_URL + '/get_notification_count';
    final prefs = await SharedPreferences.getInstance();
    var accessToken = prefs.getString(Constants.access_token);
    var token = "Bearer " + accessToken!;
    var userId = prefs.getString(Constants.user_id);
    try {
      final response = await http.post(Uri.parse(url), headers: {
        Constants.authorization: token
      });
      final responseData = json.decode(response.body);
      print(responseData);
      if (response.statusCode == 200) {
        return int.parse(responseData['notifications'].toString());
      } else {
        return 0;
      }
    } catch (error) {
      print(error.toString());
      rethrow;
    }
  }

  Future<List<Follower>> getFollowingList(int page, String q,String type,String userId) async {
    var url = BASE_URL;
    if(type==FollowerType.following){
      url=url+'/following';
    }else{
      url=url+'/follower';
    }
    final prefs = await SharedPreferences.getInstance();
    var accessToken = prefs.getString(Constants.access_token);
    var token = "Bearer " + accessToken!;
    try {
      final response = await http.post(Uri.parse(url),
          headers: {Constants.authorization: token},
          body: {Constants.page: page.toString(), Constants.q: q,Constants.user_id:userId});
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

}
