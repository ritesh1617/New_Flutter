import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:grievance/common/widget/ifeelyouItemWidget.dart';
import 'package:grievance/model/FeelModel.dart';
import 'package:grievance/model/Grievance.dart';
import 'package:grievance/provider/PeopleProvider.dart';
import 'package:grievance/theme/color.dart';
import 'package:grievance/theme/string.dart';
import 'package:grievance/theme/style.dart';
import 'package:grievance/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IFeelYouScreen extends StatefulWidget {
  final dynamic _argument;

  const IFeelYouScreen(this._argument, {Key? key}) : super(key: key);

  @override
  _IFeelYouScreenState createState() => _IFeelYouScreenState();
}

class _IFeelYouScreenState extends State<IFeelYouScreen>
    with TickerProviderStateMixin {
  String userId = "";
  String grievanceId = "";
  final TextEditingController _searchController = TextEditingController();
  bool _isLoadingifeelyou = false;
  List<FeelModel> list = [];
  int ifeelyouPage = 1;
  String searchText = "";
  ScrollController ifeelyouController = ScrollController();
  Grievance? model;
  void _scrollFeelListener() {
    if (!_isLoadingifeelyou) {
      if (ifeelyouController.position.pixels ==
          ifeelyouController.position.maxScrollExtent) {
        ifeelyouPage = ifeelyouPage + 1;
        feelListApiCall(ifeelyouPage);
      }
    }
  }

  void _searchListener() {
    var text = _searchController.text.toString();
    print(text);
    searchText = text;

    Timer(const Duration(microseconds: 400), () {
      feelListApiCall(1);
    });
  }

  @override
  void initState() {
    super.initState();
   model = widget._argument as Grievance;
    print("========================");
    getUserID();
    grievanceId = model!.id!;
    _searchController.addListener(_searchListener);
    ifeelyouController = ScrollController()..addListener(_scrollFeelListener);
    feelListApiCall(1);
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
            child: Container(
              padding: const EdgeInsets.all(15),
              child: const Image(image: AssetImage(Images.ic_back)),
            )),
        title: Text(
          "I Feel You",
          style: boldBlack18,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _totalFeelYou(),
          Expanded(child: _getFeelList())],
      ),
    );
  }

  _getFeelList() {
    return (_isLoadingifeelyou && ifeelyouPage == 1)
        ? shimmerifeelyou(context)
        : _iFeelYouWidget();
  }

  _iFeelYouWidget() {
    return ListView.builder(
        padding: const EdgeInsets.only(top: 7.5),
        itemCount: list.length,
        shrinkWrap: true,
        controller: ifeelyouController,
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext ctxt, int index) {
          return IFeelYouItemWidget(
            list[index],
            userId,
            onFollowClick: () => {_clickFollow(index)},
          );
        });
  }

  Future<void> feelListApiCall(int page) async {
    ifeelyouPage = page;
    print(_isLoadingifeelyou);
    // if (!_isLoadingifeelyou) {
    setState(() {
      _isLoadingifeelyou = true;
    });
    try {
      await Provider.of<PeopleProvider>(context, listen: false)
          .getIFeelYouList(page, grievanceId)
          .then((value) => {FeelListResponse(value, page)});
    } on HttpException catch (error) {
      setState(() {
        _isLoadingifeelyou = false;
      });
      print(error);
    } catch (error) {
      setState(() {
        _isLoadingifeelyou = false;
      });
      print(error);
    }
    // }
  }

  void FeelListResponse(List<FeelModel> data, int page) async {
    if (page == 1) {
      list.clear();
    }
    setState(() {
      _isLoadingifeelyou = false;
      print(data.length);
      list.addAll(data);
    });
  }

  Widget shimmerifeelyou(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Shimmer.fromColors(
        baseColor: Theme.of(context).colorScheme.simmerBase,
        highlightColor: Theme.of(context).colorScheme.simmerHigh,
        child: SingleChildScrollView(
          child: Column(
            children: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
                .map((_) => Padding(
                      padding: const EdgeInsetsDirectional.only(bottom: 8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                              height: 180.0,
                              color: Theme.of(context).colorScheme.white,
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
    if (list[index].user != null) {
      setState(() {
        list[index].user!.follow = !list[index].user!.follow!;
      });
      updateFollowApiCall(list[index].user!.id!, FollowType.user);
    }
  }

  Future<void> updateFollowApiCall(String userId, String userType) async {
    try {
      await Provider.of<PeopleProvider>(context, listen: false)
          .updateFollowApi(context, userId, userType)
          .then((value) => {});
    } on HttpException catch (error) {
    } catch (error) {}
  }

  void getUserID() async{
    final prefs = await SharedPreferences.getInstance();
    userId = ((prefs.getString(Constants.user_id) != null)
        ? prefs.getString(Constants.user_id)
        : "")!;
    print("===== $userId");
  }

  _totalFeelYou() {
    return Column(
      children: [
        const SizedBox(height: 10,),
        Row(
        children: [
          const SizedBox(width: 20,),
          Image.asset(Images.ic_feel_selected,width: 20,height: 20,),
          const SizedBox(width: 10),
          Text("${model?.totalFeel}",style: boldBlack14,)
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
}
