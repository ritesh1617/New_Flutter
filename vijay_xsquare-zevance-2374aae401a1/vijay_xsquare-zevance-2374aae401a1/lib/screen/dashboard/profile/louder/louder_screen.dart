import 'dart:async';
import 'dart:collection';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:grievance/common/widget/LouderItemWidget.dart';
import 'package:grievance/model/Grievance.dart';
import 'package:grievance/model/LouderModel.dart';
import 'package:grievance/provider/PeopleProvider.dart';
import 'package:grievance/theme/color.dart';
import 'package:grievance/theme/string.dart';
import 'package:grievance/theme/style.dart';
import 'package:grievance/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LouderScreen extends StatefulWidget {
  final dynamic _argument;

  const LouderScreen(this._argument, {Key? key}) : super(key: key);

  @override
  _LouderScreenState createState() => _LouderScreenState();
}

class _LouderScreenState extends State<LouderScreen>
    with TickerProviderStateMixin {
  String userId = "";
  String grievanceId = "";
  final TextEditingController _searchController = TextEditingController();
  bool _isLoadinglouder = false;
  List<LouderModel> list = [];
  int louderPage = 1;
  String searchText = "";
  ScrollController louderController = ScrollController();
  Grievance? model;
  void _scrollLouderListener() {
    if (!_isLoadinglouder) {
      if (louderController.position.pixels ==
          louderController.position.maxScrollExtent) {
        louderPage = louderPage + 1;
        LouderListApiCall(louderPage);
      }
    }
  }

  void _searchListener() {
    var text = _searchController.text.toString();
    print(text);
    searchText = text;

    Timer(const Duration(microseconds: 400), () {
      LouderListApiCall(1);
    });
  }

  @override
  void initState() {
    super.initState();
   model = widget._argument as Grievance;
    print(model!.users);
   getUserID();
    grievanceId =model!.id!;
    _searchController.addListener(_searchListener);
    louderController = ScrollController()
      ..addListener(_scrollLouderListener);
    LouderListApiCall(1);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.backgroundColor,
      appBar: AppBar(
        backgroundColor: colors.backgroundColor,
        leading: GestureDetector(
            onTap: () {
              navigatorKey.currentState!.pop();
            },
            child: Container(padding: const EdgeInsets.all(15),child: const Image(image: AssetImage(Images.ic_back)),)),
        title: Text(
          "Make it louder",
          style: boldBlack18,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _totalLouder(),
          Expanded(child: _getLouderList())
        ],
      ),
    );
  }

  _getLouderList() {
    return (_isLoadinglouder && louderPage == 1) ? shimmerlouder(
        context) : _louderWidget();
  }
  _totalLouder() {
    return Column(
      children: [
        const SizedBox(height: 10,),
        Row(
          children: [
            const SizedBox(width: 20,),
            Image.asset(Images.ic_louder,color: colors.secondary,width: 20,height: 20,),
            const SizedBox(width: 10),
            Text("${model?.totalLoud}",style: boldBlack14,)
          ],
        ),
        const SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(width: 100,height: 3,color: colors.blackTemp,),
            Expanded(child: Container(height: 1,color: colors.blackTemp,))
          ],),
      ],
    );
  }

  _louderWidget() {
    return ListView.builder(
        padding: const EdgeInsets.only(top: 7.5),
        itemCount: list.length,
        shrinkWrap: true,
        controller: louderController,
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext ctxt, int index) {
          return LouderItemWidget(list[index],userId,onFollowClick: ()=>{
            _clickFollow(index)
          },);
        });
  }




  Future<void> LouderListApiCall(int page) async {
    louderPage = page;
    print(_isLoadinglouder);
    // if (!_isLoadinglouder) {}
    setState(() {
      _isLoadinglouder = true;
    });
    try {
      await Provider.of<PeopleProvider>(context, listen: false)
          .getLouderList(page,grievanceId)
          .then((value) => {LouderListResponse(value, page)});
    } on HttpException catch (error) {
      setState(() {
        _isLoadinglouder = false;
      });
      print(error);
    } catch (error) {
      setState(() {
        _isLoadinglouder = false;
      });
      print(error);
    }
    // }
  }

  void LouderListResponse(List<LouderModel> data, int page) async {
    if (page == 1) {
      list.clear();
    }
    setState(() {
      _isLoadinglouder = false;
      print(data.length);
      list.addAll(data);
    });
  }

  Widget shimmerlouder(BuildContext context) {
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

  _clickFollow(int index) {
    if(list[index].user!=null) {
      setState(() {
        list[index].user!.follow = !list[index].user!.follow!;
      });
      updateFollowApiCall(list[index].user!.id!,FollowType.user);
    }
  }

  Future<void> updateFollowApiCall(String userId,String userType) async {
    try {
      await Provider.of<PeopleProvider>(context, listen: false)
          .updateFollowApi(context,userId,userType)
          .then((value) => {});
    } on HttpException catch (error) {
    } catch (error) {
    }
  }
  void getUserID() async{
    final prefs = await SharedPreferences.getInstance();
    userId = ((prefs.getString(Constants.user_id) != null)
        ? prefs.getString(Constants.user_id)
        : "")!;
    print("===== $userId");
  }
}
