import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:grievance/common/widget/PeopleItemWidget.dart';
import 'package:grievance/model/UserModel.dart';
import 'package:grievance/provider/PeopleProvider.dart';
import 'package:grievance/theme/color.dart';
import 'package:grievance/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class SearchPeopleScreen extends StatefulWidget {
  TextEditingController searchController;

  SearchPeopleScreen(this.searchController, {Key? key}) : super(key: key);

  @override
  _SearchPeopleScreenState createState() => _SearchPeopleScreenState();
}

class _SearchPeopleScreenState extends State<SearchPeopleScreen> {


  var _isLoadingPeople = false;
  List<Users> peopleList = [];
  int peoplePage = 1;
  String searchText = "";
  ScrollController peopleController = ScrollController();

  void _scrollPeopleListener() {
    if (!_isLoadingPeople) {
      if (peopleController.position.pixels ==
          peopleController.position.maxScrollExtent) {
        peoplePage = peoplePage + 1;
        peopleListApiCall(peoplePage);
      }
    }
  }

  void _searchListener() {

    var text = widget.searchController.text.toString();
    print(text);
    searchText = text;

    Timer(const Duration(microseconds: 400), () {
      peopleListApiCall(1);
    });
  }

  @override
  void initState() {
    super.initState();

    widget.searchController.addListener(_searchListener);
    searchText = widget.searchController.text;
    peopleController = ScrollController()
      ..addListener(_scrollPeopleListener);
    peopleListApiCall(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.backgroundColor,
      body: SafeArea(
        child: _getPeopleList(),
      ),
    );
  }


  _getPeopleList() {
    return (_isLoadingPeople && peoplePage == 1) ? shimmerPeople(
        context) : _peopleWidget();
  }

  _peopleWidget() {
    return ListView.builder(
        padding: const EdgeInsets.only(top: 7.5),
        itemCount: peopleList.length,
        shrinkWrap: true,
        controller: peopleController,
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext ctxt, int index) {
          return PeopleItemWidget(peopleList[index],onFollowClick: (){
            _clickFollow(index);
          },);
        });
  }


  //+++++++++++++ People API +++++++++++

  Future<void> peopleListApiCall(int page) async {
    peoplePage=page;
    print(_isLoadingPeople);
   // if (!_isLoadingPeople) {
      setState(() {
        _isLoadingPeople = true;
      });
      try {
        await Provider.of<PeopleProvider>(context, listen: false)
            .getPeopleList(context,page, searchText)
            .then((value) => {peopleListResponse(value,page)});
      } on HttpException catch (error) {
        setState(() {
          _isLoadingPeople = false;
        });
        print(error);
      } catch (error) {
        setState(() {
          _isLoadingPeople = false;
        });
        print(error);
      }
   // }
  }

  void peopleListResponse(List<Users> data,int page) async {
    if (page == 1) {
      peopleList.clear();
    }
    setState(() {
      _isLoadingPeople = false;
      print(data.length);
      peopleList.addAll(data);
    });
  }

  Widget shimmerPeople(BuildContext context) {
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
    setState(() {
      peopleList[index].follow = !peopleList[index].follow!;
    });
    updateFollowApiCall(peopleList[index].id!);
  }

  Future<void> updateFollowApiCall(String userId) async {
    try {
      await Provider.of<PeopleProvider>(context, listen: false)
          .updateFollowApi(context,userId,FollowType.user)
          .then((value) => {});
    } on HttpException catch (error) {
    } catch (error) {
    }
  }
}
