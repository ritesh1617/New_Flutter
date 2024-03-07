import 'dart:io';

import 'package:flutter/material.dart';
import 'package:grievance/common/widget/PersonalGrievanceWidget.dart';
import 'package:grievance/model/Company.dart';
import 'package:grievance/model/Grievance.dart';
import 'package:grievance/provider/CompanyProvider.dart';
import 'package:grievance/provider/PeopleProvider.dart';
import 'package:grievance/theme/color.dart';
import 'package:grievance/theme/string.dart';
import 'package:grievance/theme/style.dart';
import 'package:grievance/utils/constants.dart';
import 'package:shimmer/shimmer.dart';
import 'package:provider/provider.dart';

class CompanyProfileScreen extends StatefulWidget {
  final dynamic _argument;

  const CompanyProfileScreen(this._argument, {Key? key}) : super(key: key);

  @override
  _CompanyProfileScreenState createState() => _CompanyProfileScreenState();
}

class _CompanyProfileScreenState extends State<CompanyProfileScreen>
    with TickerProviderStateMixin {

  Company? model;

  List<Grievance> list = [];


  int page = 1;
  bool _isLoading = false;

  ScrollController controller = ScrollController();
  var selectType = "";

  void _scrollListener() {
    if (!_isLoading) {
      if (controller.position.pixels == controller.position.maxScrollExtent) {
        grievanceListApiCall();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    model = widget._argument as Company;
    controller = ScrollController()
      ..addListener(_scrollListener);
    callCompanyDetailsApi();
    grievanceListApiCall();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.whiteTemp,
      appBar: AppBar(
        backgroundColor: colors.whiteTemp,
        leading: GestureDetector(
            onTap: () {
              navigatorKey.currentState!.pop();
            },
            child: Container(padding: EdgeInsets.all(15),child: const Image(image: AssetImage(Images.ic_back)),)),
        title: Text(
          "Company Profile",
          style: boldBlack18,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        controller: controller,
        child: Column(
          children: [
            _profileInfo(),
            _aboutUs(),
            _grievance(),
          ],
        ),
      ),
    );
  }

  _profileInfo() {
    var height = 150.0;
    return Column(
      children: [
        Stack(
          children: [
            FadeInImage(
                fadeInDuration: const Duration(milliseconds: 150),
                image: (model!.logo!.isNotEmpty)
                    ? NetworkImage(model!.logo!)
                    : const NetworkImage(
                    "https://banksiafdn.com/wp-content/uploads/2019/10/placeholde-image.jpg"),
                height: height,
                width: deviceWidth,
                fit: BoxFit.cover,
                imageErrorBuilder: (context, error, stackTrace) =>
                    Image.asset(
                      Images.rectangle_placeholder,
                      fit: BoxFit.cover,
                      height: height,
                    ),
                placeholderErrorBuilder: (context, error, stackTrace) =>
                    Image.asset(
                      Images.rectangle_placeholder,
                      fit: BoxFit.cover,
                      height: height,
                    ),
                placeholder: const AssetImage(Images.rectangle_placeholder)),
            Container(
              width: 100.0,
              height: 100.0,
              margin: const EdgeInsets.only(top: 80,left: 25),
              decoration: BoxDecoration(
                color: colors.grayLight,
                boxShadow: [BoxShadow(
                  color: colors.grayTemp,
                  blurRadius: 1
                )],
                image: DecorationImage(
                  image: (model!.logo!.isNotEmpty)
                      ? NetworkImage(model!.logo!)
                      : const NetworkImage(
                      "https://banksiafdn.com/wp-content/uploads/2019/10/placeholde-image.jpg"),
                  fit: BoxFit.cover,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(0.0)),
                border: Border.all(
                  color: colors.whiteTemp,
                  width: 4.0,
                ),
              ),
            )
          ],
        ),
        Container(
          margin: const EdgeInsets.only(left: 20,right: 20,top: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    (model!.companyName!=null) ? "${model!.companyName}" : "",
                    style: boldBlack16,
                  ),
                  SizedBox(width: 5,),
                  Image.asset((model!.is_verified=="verified")?Images.ic_verified:Images.ic_unverified,width: 15,height: 15,)
                ],
              ),
              const SizedBox(
                height: 2,
              ),
              Text(
                (model!.address!=null) ? "${model!.address}" : "",
                style: regularBlack14,
              ),
              const SizedBox(
                height: 2,
              ),
              (model!.website!=null) ?  GestureDetector(
                onTap: (){
                  Utils.launchInBrowser("${model!.website}");
                },
                child: Text(
                  (model!.website!=null) ? "${model!.website}" : "",
                  style: regularBlack14.copyWith(color: colors.secondary,decoration: TextDecoration.underline),
                ),
              ):Container(),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        navigatorKey.currentState!
                            .pushNamed(RouteName
                            .addGrievanceScreen,
                            arguments: model);
                      },
                      child: Container(
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                        decoration: BoxDecoration(
                            gradient: const LinearGradient(
                                colors: [colors.firstColor, colors.secondColor]),
                            borderRadius: BorderRadius.circular(15)),
                        child: Center(
                            child: Text(
                              "Submit Grievance",
                              style: regularWhite12,
                            )),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20,),
                  GestureDetector(
                    onTap: () {
                      _clickFollow();
                    },
                    child: Container(
                      width: 90,
                      padding: const EdgeInsets.only(top: 5, bottom: 5),
                      decoration: BoxDecoration(
                          gradient: const LinearGradient(
                              colors: [colors.firstColor, colors.secondColor]),
                          borderRadius: BorderRadius.circular(15)),
                      child: Center(
                          child: Text(
                            (model!.follow!) ? "Unfollow" : "Follow",
                            style: regularWhite12,
                          )),
                    ),
                  ),
                ],
              ),
              Container(
                height: 1,
                color: colors.grayLight,
                margin:
                const EdgeInsets.only(top: 10, bottom: 10),
              ),
              Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        child: GestureDetector(
                          onTap: () {
                            NavigationMethod.moveToFollower(FollowerType.follower,model!.id!,model!.follower!,profile_type: 'company').then((value) => callCompanyDetailsApi());
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${model!.follower}",
                                style: boldBlack14,
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              Text(
                                "Total\nFollowers",
                                textAlign: TextAlign.center,
                                style: regularGray12,
                              ),
                            ],
                          ),
                        )),
                    Container(
                      width: 1,
                      color: colors.grayLight,
                      height: 40,
                    ),
                    Container(
                      width: 1,
                      color: colors.grayLight,
                      height: 40,
                    ),
                    Expanded(
                        child: GestureDetector(
                          onTap: (){
                            page = 1;
                            selectType = "open";
                            grievanceListApiCall();
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${model!.openTickets}",
                                style: boldBlack14,
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              Text(
                                "Open\nTickets",
                                textAlign: TextAlign.center,
                                style: regularGray12,
                              ),
                            ],
                          ),
                        )),
                    Container(
                      width: 1,
                      color: colors.grayLight,
                      height: 40,
                    ),
                    Expanded(
                        child: GestureDetector(
                          onTap: (){
                            page = 1;
                            selectType = "resolved";
                            grievanceListApiCall();
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${model!.closedTickets}",
                                style: boldBlack14,
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              Text(
                                "Resolved\nTickets",
                                textAlign: TextAlign.center,
                                style: regularGray12,
                              ),
                            ],
                          ),
                        )),
                    Container(
                      width: 1,
                      color: colors.grayLight,
                      height: 40,
                    ),
                    Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${model?.zeescore}",
                              style: boldBlack14,
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            Text(
                              "Zevance\nScore",
                              textAlign: TextAlign.center,
                              style: regularGray12,
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),

      ],
    );
  }

  _aboutUs() {
    return Container(
      margin: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "About Us",
            style: regularBlack14,
          ),
          Container(
            height: 1,
            color: colors.grayLight,
            margin: const EdgeInsets.only(top: 10, bottom: 10),
          ),
          Text(
            "${model!.description}",
            style: regularGray12,
          ),
        ],
      ),
    );
  }

  _grievance() {
    return Container(
      margin: const EdgeInsets.only(
        top: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 3,
            color: colors.grayLight,
            margin: const EdgeInsets.only(top: 10, bottom: 10),
          ),
          Row(
            children: [
              const SizedBox(width: 20,),
              Text(
                "Grievances",
                style: regularBlack14,
              ),
              const Spacer(),
              PopupMenuButton(
                color: colors.backgroundColor,
                itemBuilder: (_) =>
                <PopupMenuItem<String>>[
                  PopupMenuItem<String>(
                      value: '',
                      child: Text(
                        'All',
                        style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w500,
                            color: (selectType == '') ? colors.primary : colors
                                .black54),
                      )),
                  PopupMenuItem<String>(
                      value: 'open',
                      child: Text(
                        'Open',
                        style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w500,
                            color: (selectType == 'open')
                                ? colors.primary
                                : colors.black54),
                      )),
                  PopupMenuItem<String>(
                      value: 'resolved',
                      child: Text(
                        'Closed',
                        style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w500,
                            color: (selectType == 'resolved')
                                ? colors.primary
                                : colors.black54),
                      )),
                  PopupMenuItem<String>(
                      value: 'sort_by_time',
                      child: Text(
                        'Sort By Time',
                        style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w500,
                            color: (selectType == 'sort_by_time') ? colors
                                .primary : colors.black54),
                      )),
                  // PopupMenuItem<String>(
                  //     value: 'upvote',
                  //     child: Text(
                  //       'Upvote',
                  //       style: TextStyle(
                  //           fontSize: 12.0,
                  //           fontWeight: FontWeight.w500,
                  //           color: (selectType == 'upvote')
                  //               ? colors.primary
                  //               : colors.black54),
                  //     )),
                ],
                onSelected: (String value) {
                  page = 1;
                  selectType = value;
                  grievanceListApiCall();
                },
                child: SizedBox(width: 20,height: 20, child: Image.asset(Images.ic_fillter,color: colors.grayTemp,)),
              ),
              const SizedBox(width: 20,),
            ],
          ),

          (_isLoading && page == 1) ? shimmer(context) : ListView.builder(
              padding: const EdgeInsets.only(top: 20,),
              itemCount: list.length,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemBuilder: (BuildContext ctxt, int index) {
                return PersonalGrievanceWidget(
                  model: list[index],
                  onClick: () {
                    NavigationMethod.moveToGrievanceDetails(list[index]);
                  },
                );
              })
        ],
      ),
    );
  }

  Future<void> grievanceListApiCall() async {
    if (kDebugMode) {
      print(_isLoading);
    }
    if (!_isLoading) {
      setState(() {
        _isLoading = true;
      });
      try {
        await Provider.of<CompanyProvider>(context, listen: false)
            .getCompanyGrievance(context,page, model!.id!, selectType)
            .then((value) => {grievanceListResponse(value)});
      } on HttpException catch (error) {
        setState(() {
          _isLoading = false;
        });
        print(error);
      } catch (error) {
        setState(() {
          _isLoading = false;
        });
        print(error);
      }
    }
  }

  void grievanceListResponse(List<Grievance> data) async {
    if (page == 1) list.clear();
    page = page + 1;
    setState(() {
      _isLoading = false;
      list.addAll(data);
    });
//     if(!list.isEmpty){
// searchProductApiCall();
//     }
  }

  Widget shimmer(BuildContext context) {
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
                          height: 100.0,
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


  _clickFollow() {
    setState(() {
      model!.follow = !model!.follow!;
    });
    updateFollowApiCall(model!.id!);
  }

  Future<void> updateFollowApiCall(String userId) async {
    try {
      await Provider.of<PeopleProvider>(context, listen: false)
          .updateFollowApi(context, userId, FollowType.company)
          .then((value) => {});
    } on HttpException catch (error) {} catch (error) {}
  }

  void callCompanyDetailsApi() async {
    try {
      await Provider.of<CompanyProvider>(context, listen: false)
          .getCompany(context, model!.id!)
          .then((value) {
        if (value != null) {
          setState(() {
            model = value;
          });
        }
      });
    } catch (error) {}
  }
}
