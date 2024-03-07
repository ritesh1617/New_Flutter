

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:grievance/common/widget/PostChatWidget.dart';
import 'package:grievance/model/Grievance.dart';
import 'package:grievance/model/UserModel.dart';
import 'package:grievance/provider/GrievanceProvider.dart';
import 'package:grievance/theme/color.dart';
import 'package:grievance/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchGrievanceScreen extends StatefulWidget {
  TextEditingController searchController;

  SearchGrievanceScreen(this.searchController, {Key? key}) : super(key: key);

  @override
  _SearchGrievanceScreenState createState() => _SearchGrievanceScreenState();
}

class _SearchGrievanceScreenState extends State<SearchGrievanceScreen> {


  var _isLoadingGrievance = false;
  List<Grievance> grievanceList = [];
  int grievancePage = 1;
  String searchText = "";
  ScrollController grievanceController = ScrollController();
  Users? users=null;
  void _scrollGrievanceListener() {
    if (!_isLoadingGrievance) {
      if (grievanceController.position.pixels ==
          grievanceController.position.maxScrollExtent) {
        grievancePage = grievancePage + 1;
        grievanceListApiCall(grievancePage);
      }
    }
  }

  void _searchListener() {

    var text = widget.searchController.text.toString();
    print(text);
    searchText = text;

    Timer(const Duration(microseconds: 400), () {
      grievanceListApiCall(1);
    });
  }

  @override
  void initState() {
    super.initState();
    getUserDetails();
    widget.searchController.addListener(_searchListener);
    searchText = widget.searchController.text;
    grievanceController = ScrollController()
      ..addListener(_scrollGrievanceListener);
    grievanceListApiCall(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.backgroundColor,
      body: SafeArea(
        child: _getGrievanceList(),
      ),
    );
  }


  _getGrievanceList() {
    return (_isLoadingGrievance && grievancePage == 1) ? shimmerGrievance(
        context) : _grievanceWidget();
  }

  _grievanceWidget() {
    return ListView.builder(
        padding: const EdgeInsets.only(top: 7.5),
        itemCount: grievanceList.length,
        shrinkWrap: true,
        controller: grievanceController,
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext ctxt, int index) {
          return PostChatWidget(
            model: grievanceList[index],
            userID: users?.id,
            onMakeLouder: () => {
              _clickMakeLouder(index)
            },
            onFeelYou: () => {
              _clickFeelYou(index)
            },
          );
        });
  }

  void getUserDetails() async {
    final prefs = await SharedPreferences.getInstance();
    var userDate = prefs.getString(Constants.user);
    setState(() {
      users = Users.fromJson(json.decode(userDate!));
    });
  }


  //+++++++++++++ Grievance API +++++++++++

  Future<void> grievanceListApiCall(int page) async {
    grievancePage=page;
    print(_isLoadingGrievance);
   // if (!_isLoadingGrievance) {
      setState(() {
        _isLoadingGrievance = true;
      });
      try {
        await Provider.of<GrievanceProvider>(context, listen: false)
            .searchGrievance(context,page, searchText)
            .then((value) => {grievanceListResponse(value,page)});
      } on HttpException catch (error) {
        setState(() {
          _isLoadingGrievance = false;
        });
        print(error);
      } catch (error) {
        setState(() {
          _isLoadingGrievance = false;
        });
        print(error);
      }
   // }
  }

  void grievanceListResponse(List<Grievance> data,int page) async {
    print("page "+grievancePage.toString());
    if (page == 1) {
      grievanceList.clear();
    }


    setState(() {
      _isLoadingGrievance = false;
      print(data.length);
      grievanceList.addAll(data);
    });

//     if(!list.isEmpty){
// searchProductApiCall();
//     }
  }

  Widget shimmerGrievance(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Shimmer.fromColors(
        baseColor: Theme
            .of(context)
            .colorScheme
            .simmerBase,
        highlightColor: Theme
            .of(context)
            .colorScheme
            .simmerHigh,
        child: SingleChildScrollView(
          child: Column(
            children: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
                .map((_) =>
                Padding(
                  padding: const EdgeInsetsDirectional.only(bottom: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          height: 180.0,
                          color: Theme
                              .of(context)
                              .colorScheme
                              .white,
                        ),
                      ),
                    ],
                  ),
                ))
                .toList(),
          ),
        ),
      ),
    );
  }


  _clickFeelYou(int index) {
    setState(() {
      if (grievanceList[index].isFeel) {
        grievanceList[index].totalFeel =
            (int.parse(grievanceList[index].totalFeel!) - 1).toString();
      } else {
        grievanceList[index].totalFeel =
            (int.parse(grievanceList[index].totalFeel!) + 1).toString();
      }
      grievanceList[index].isFeel = !grievanceList[index].isFeel;
    });
    updateFeelApiCall(grievanceList[index].id!);
  }

  Future<void> updateFeelApiCall(String grievanceId) async {
    try {
      await Provider.of<GrievanceProvider>(context, listen: false)
          .updateFeelYouApi(context,grievanceId)
          .then((value) => {});
    } on HttpException catch (error) {
    }
    catch (error) {
    }
  }

  _clickMakeLouder(int index) {
    setState(() {
      if (grievanceList[index].isLouder) {
        grievanceList[index].totalLoud =
            (int.parse(grievanceList[index].totalLoud!) - 1).toString();
      } else {
        grievanceList[index].totalLoud =
            (int.parse(grievanceList[index].totalLoud!) + 1).toString();
      }
      grievanceList[index].isLouder = !grievanceList[index].isLouder;
    });
    updateLouderApiCall(grievanceList[index].id!);
  }

  Future<void> updateLouderApiCall(String grievanceId) async {
    try {
      await Provider.of<GrievanceProvider>(context, listen: false)
          .updateLouderApi(context,grievanceId,LouderType.grievance)
          .then((value) => {});
    } on HttpException catch (error) {
    } catch (error) {
    }
  }
}
