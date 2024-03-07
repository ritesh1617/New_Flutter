import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grievance/model/Category.dart';
import 'package:grievance/model/Comment.dart';
import 'package:grievance/model/Company.dart';
import 'package:grievance/model/FileData.dart';
import 'package:grievance/model/Grievance.dart';
import 'package:grievance/model/UserModel.dart';
import 'package:grievance/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CompanyProvider with ChangeNotifier {
  Future<List<Company>> getCompanyList(BuildContext context,int page, String q) async {
    bool connection=await ConnectionChecker.check(context);
    if(!connection){
      return [];
    }
    const url = BASE_URL + '/get_all_company';
    final prefs = await SharedPreferences.getInstance();
    var accessToken = prefs.getString(Constants.access_token);

    var token = "Bearer " + accessToken!;
    print(accessToken);
    print(url);
    print(page);
    print(q);
    try {
      final response = await http.post(Uri.parse(url), headers: {
        Constants.authorization: token,
        "Accept": "application/json"
      }, body: {
        Constants.page: page.toString(),
        Constants.q: q
      });
      //   print("Response : "+response.body);
      final responseData = json.decode(response.body);
      if (response.statusCode == 200) {
        return (responseData['company']['data'] as List)
            .map((data) => Company.fromJson(data))
            .toList();
      } else {
        return [];
      }
    } catch (error) {
      print("Error $error");
      rethrow;
    }
  }

  Future<List<Grievance>> getCompanyGrievance(BuildContext context,int page, String companyId, String filter) async {

    bool connection=await ConnectionChecker.check(context);
    if(!connection){
      return [];
    }
    const url = '$BASE_URL/get_company_grievance';
    final prefs = await SharedPreferences.getInstance();
    var accessToken = prefs.getString(Constants.access_token);
    var token = "Bearer ${accessToken!}";
    try {
      final response = await http.post(Uri.parse(url), headers: {
        Constants.authorization: token
      }, body: {
        Constants.page: page.toString(),
        Constants.company_id: companyId,
        Constants.filter: filter
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

  Future<Company?> getCompany(BuildContext context, String companyId) async {
    bool connection=await ConnectionChecker.check(context);
    if(!connection){
      return null;
    }
    const url = '$BASE_URL/get_company_details';
    final prefs = await SharedPreferences.getInstance();
    var accessToken = prefs.getString(Constants.access_token);
   // print(url);
    var token = "Bearer $accessToken";
    try {
      final response = await http.post(Uri.parse(url),
          headers: {Constants.authorization: token},
          body: {Constants.company_id: companyId});
      final responseData = json.decode(response.body);
      if (kDebugMode) {
        print(responseData);
      }
      Company? data;
      if (response.statusCode == 200) {
        data = Company.fromJson(responseData['company']);
      }
     // print(data?.id);
      return data;
    } catch (error) {
      rethrow;
    }
  }
}
