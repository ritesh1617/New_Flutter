import 'dart:async';
import 'dart:collection';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:grievance/common/widget/FollowerItemWidget.dart';
import 'package:grievance/model/Follower.dart';
import 'package:grievance/provider/PeopleProvider.dart';
import 'package:grievance/theme/color.dart';
import 'package:grievance/theme/string.dart';
import 'package:grievance/theme/style.dart';
import 'package:grievance/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FollowersScreen extends StatefulWidget {
  final dynamic _argument;

  const FollowersScreen(this._argument, {Key? key}) : super(key: key);

  @override
  _FollowersScreenState createState() => _FollowersScreenState();
}

class _FollowersScreenState extends State<FollowersScreen>
    with TickerProviderStateMixin {
  String total = "";
  String type = "";
  String userId = "";
  String profile_type = "user";
  final TextEditingController _searchController = TextEditingController();
  bool _isLoadingFollower = false;
  List<Follower> followerList = [];
  int followerPage = 1;
  String searchText = "";
  ScrollController followerController = ScrollController();

  void _scrollFollowerListener() {
    if (!_isLoadingFollower) {
      if (followerController.position.pixels ==
          followerController.position.maxScrollExtent) {
        followerPage = followerPage + 1;
        followerListApiCall(followerPage);
      }
    }
  }

  void _searchListener() {
    var text = _searchController.text.toString();
    print(text);
    searchText = text;

    Timer(const Duration(microseconds: 400), () {
      followerListApiCall(1);
    });
  }

  @override
  void initState() {
    super.initState();
    var data = widget._argument as HashMap<String, String>;
    type = data[Constants.type]!;
    total = data[Constants.total]!;
    userId = data[Constants.user_id]!;
    profile_type = data[Constants.profile_type]!;
    getUserID();
    _searchController.addListener(_searchListener);
    followerController = ScrollController()..addListener(_scrollFollowerListener);
    followerListApiCall(1);
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
          (type == FollowerType.follower) ? "Followers":"Following",
          style: boldBlack18,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _searchWidget(),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20,top: 15),
                child: Text(  (type == FollowerType.follower) ? "$total Followers":"$total Following",style: boldBlack14,),
              ),
            ],
          ),
          Expanded(child: _getFollowerList())
        ],
      ),
    );
  }

  _getFollowerList() {
    return (_isLoadingFollower && followerPage == 1) ? shimmerFollower(
        context) : _followerWidget();
  }

  _followerWidget() {
    return ListView.builder(
        padding: const EdgeInsets.only(top: 7.5),
        itemCount: followerList.length,
        shrinkWrap: true,
        controller: followerController,
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext ctxt, int index) {
          return FollowerItemWidget(followerList[index],userId,type,onFollowClick: ()=>{
            _clickFollow(index)
          },);
        });
  }

  _searchWidget() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(left: 15, right: 15),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: colors.grayLight, width: 1)),
            child: TextField(
              controller: _searchController,
              textAlignVertical: TextAlignVertical.center,
              style: regularBlack14,
              decoration: InputDecoration(
                  suffixIcon: Container(
                    width: 20,
                    padding: const EdgeInsets.all(15.0),
                    child: Image.asset(Images.ic_search,),
                  ),
                  hintStyle: regularGray14,
                  hintText:  (type == FollowerType.follower) ? "Search Followers" : "Search Following" ,
                  fillColor: Colors.white),
            ),
          ),
        )
      ],
    );
  }

  Future<void> followerListApiCall(int page) async {
    followerPage = page;
    print(_isLoadingFollower);
    // if (!_isLoadingFollower) {
    setState(() {
      _isLoadingFollower = true;
    });
    try {
      await Provider.of<PeopleProvider>(context, listen: false)
          .getFollowingList(page, searchText,type,userId,profile_type)
          .then((value) => {followerListResponse(value, page)});
    } on HttpException catch (error) {
      setState(() {
        _isLoadingFollower = false;
      });
      print(error);
    } catch (error) {
      setState(() {
        _isLoadingFollower = false;
      });
      print(error);
    }
    // }
  }

  void followerListResponse(List<Follower> data, int page) async {
    if (page == 1) {
      followerList.clear();
    }
    setState(() {
      _isLoadingFollower = false;
      print(data.length);
     followerList.addAll(data);
    });
  }

  Widget shimmerFollower(BuildContext context) {
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
    if(followerList[index].users!=null) {
      setState(() {
        followerList[index].users!.follow = !followerList[index].users!.follow!;
      });
      updateFollowApiCall(followerList[index].users!.id!,FollowType.user);
    }
    if(followerList[index].company!=null) {
      setState(() {
        followerList[index].company!.follow = !followerList[index].company!.follow!;
      });
      updateFollowApiCall(followerList[index].company!.id!,FollowType.company);
    }
  }

  Future<void> updateFollowApiCall(String userId,String userType) async {
    try {
      await Provider.of<PeopleProvider>(context, listen: false)
          .updateFollowApi(context,userId,userType)
          .then((value) => {});
    }catch (error) {

    }
  }

  void getUserID() async{
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = ((prefs.getString(Constants.user_id) != null) ? prefs.getString(Constants.user_id) : "")!;
    });
    print("===== $userId");
  }
}
