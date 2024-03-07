import 'dart:io';

import 'package:flutter/material.dart';
import 'package:grievance/common/widget/PersonalGrievanceWidget.dart';
import 'package:grievance/model/Grievance.dart';
import 'package:grievance/model/UserModel.dart';
import 'package:grievance/provider/GrievanceProvider.dart';
import 'package:provider/provider.dart';
import 'package:grievance/provider/PeopleProvider.dart';
import 'package:grievance/theme/color.dart';
import 'package:grievance/theme/string.dart';
import 'package:grievance/theme/style.dart';
import 'package:grievance/utils/constants.dart';
import 'package:shimmer/shimmer.dart';

class PublicProfileScreen extends StatefulWidget {
  final dynamic _argument;

  const PublicProfileScreen(this._argument, {Key? key}) : super(key: key);

  @override
  _PublicProfileScreenState createState() => _PublicProfileScreenState();
}

class _PublicProfileScreenState extends State<PublicProfileScreen>
    with TickerProviderStateMixin {
  Users? users;

  List<Grievance> list = [];

  int page = 1;
  bool _isLoading = false;

  ScrollController controller = ScrollController();

  void _scrollListener() {
    if (!_isLoading) {
      if (controller.position.pixels == controller.position.maxScrollExtent) {
        grievanceListApiCall();
      }
    }
  }

  var selectType = "";

  @override
  void initState() {
    super.initState();

    if (widget._argument is Users) {
      users = widget._argument as Users;
      controller = ScrollController()..addListener(_scrollListener);
      callUserDetailsApi();
      grievanceListApiCall();
    }
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
          "Public Profile",
          style: boldBlack18,
        ),
        centerTitle: true,
      ),
      body: (users == null)
          ? Container()
          : SingleChildScrollView(
              child: Column(
                children: [
                  _profileInfo(),
                  //  _grievance()
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
                image: (users != null && users!.coverImage!.isNotEmpty)
                    ? NetworkImage(users!.coverImage!)
                    : const NetworkImage(
                        'https://yourlawnwise.com/wp-content.png'),
                height: height,
                width: deviceWidth,
                fit: BoxFit.cover,
                imageErrorBuilder: (context, error, stackTrace) => Image.asset(
                      Images.profile_cover,
                      fit: BoxFit.cover,
                      width: deviceWidth,
                      height: height,
                    ),
                placeholderErrorBuilder: (context, error, stackTrace) =>
                    Image.asset(
                      Images.profile_cover,
                      fit: BoxFit.cover,
                      width: deviceWidth,
                      height: height,
                    ),
                placeholder: const AssetImage(Images.profile_cover)),
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 100),
                decoration: BoxDecoration(
                  border: Border.all(width: 5, color: colors.whiteTemp),
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  boxShadow: [BoxShadow(color: colors.grayTemp, blurRadius: 1)],
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.2), BlendMode.dstATop),
                    image: const NetworkImage(
                      'http://www.server.com/image.jpg',
                    ),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50.0),
                  child: FadeInImage(
                      fadeInDuration: const Duration(milliseconds: 150),
                      image: (users != null && users!.image!.isNotEmpty)
                          ? NetworkImage(users!.image!)
                          : const NetworkImage(
                              'https://yourlawnwise.com/wp-content.png'),
                      width: 90.0,
                      height: 90.0,
                      fit: BoxFit.cover,
                      imageErrorBuilder: (context, error, stackTrace) =>
                          Image.asset(
                            Images.person_placeholder,
                            color: const Color.fromRGBO(255, 255, 255, 0.5),
                            colorBlendMode: BlendMode.modulate,
                            fit: BoxFit.cover,
                            width: 90.0,
                            height: 90.0,
                          ),
                      placeholderErrorBuilder: (context, error, stackTrace) =>
                          Image.asset(
                            Images.person_placeholder,
                            fit: BoxFit.cover,
                            color: const Color.fromRGBO(255, 255, 255, 0.5),
                            colorBlendMode: BlendMode.modulate,
                            width: 90.0,
                            height: 90.0,
                          ),
                      placeholder: const AssetImage(
                        Images.person_placeholder,
                      )),
                ),
              ),
            ),
            /*  Center(
              child: Container(
                width: 100.0,
                height: 100.0,
                margin: const EdgeInsets.only(top: 100),
                decoration: BoxDecoration(
                  color: colors.grayLight,
                  image: DecorationImage(
                    image: (users != null && users!.image!.isNotEmpty)
                        ? NetworkImage(users!.image!)
                        : const NetworkImage(
                            'https://yourlawnwise.com/wp-content.png'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(50.0)),
                  border: Border.all(
                    color: colors.whiteTemp,
                    width: 4.0,
                  ),
                ),
              ),
            )*/
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          "${users!.name}",
          style: boldBlack16,
        ),
        const SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: Text(
            "${users!.userable?.headline}",
            // "Brainstorming my perfect headline. Coming soon!",
            textAlign: TextAlign.center,
            style: regularBlack12,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
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
              (users!.follow!) ? "Unfollow" : "Follow",
              style: regularWhite14,
            )),
          ),
        ),
        Container(
          height: 1,
          color: colors.grayLight,
          margin:
              const EdgeInsets.only(left: 25, right: 25, top: 20, bottom: 10),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: GestureDetector(
              onTap: () {
                NavigationMethod.moveToFollower(
                        FollowerType.follower, users!.id!, users!.followers!)
                    .then((value) => callUserDetailsApi());
              },
              child: Container(
                color: colors.transparent,
                child: Column(
                  children: [
                    Text(
                      "${users!.followers}",
                      style: normalBlack14,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      "Total Followers",
                      style: regularGray12,
                    ),
                  ],
                ),
              ),
            )),
            Container(
              height: 30,
              width: 1,
              color: colors.grayTemp,
            ),
            Expanded(
                child: GestureDetector(
              onTap: () {
                NavigationMethod.moveToFollower(
                        FollowerType.following, users!.id!, users!.following!)
                    .then((value) => callUserDetailsApi());
              },
              child: Container(
                color: colors.transparent,
                child: Column(
                  children: [
                    Text(
                      "${users!.following}",
                      style: normalBlack14,
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      "Total Following",
                      style: regularGray12,
                    ),
                  ],
                ),
              ),
            )),
          ],
        ),
      ],
    );
  }

  _bio() {
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
            "Bio",
            style: regularBlack14,
          ),
          Container(
            height: 1,
            color: colors.grayLight,
            margin: const EdgeInsets.only(top: 10, bottom: 10),
          ),
          Text(
            "${users!.userable?.bio}",
            style: regularGray12,
          ),
        ],
      ),
    );
  }

  _grievance() {
    return Container(
      margin: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Grievances",
                style: regularBlack14,
              ),
              const Spacer(),
              PopupMenuButton(
                color: colors.backgroundColor,
                itemBuilder: (_) => <PopupMenuItem<String>>[
                  PopupMenuItem<String>(
                      value: '',
                      child: Text(
                        'All',
                        style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w500,
                            color: (selectType == '')
                                ? colors.primary
                                : colors.black54),
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
                            color: (selectType == 'sort_by_time')
                                ? colors.primary
                                : colors.black54),
                      )),
                  PopupMenuItem<String>(
                      value: 'upvote',
                      child: Text(
                        'Upvote',
                        style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w500,
                            color: (selectType == 'upvote')
                                ? colors.primary
                                : colors.black54),
                      )),
                ],
                onSelected: (String value) {
                  page = 1;
                  selectType = value;
                  grievanceListApiCall();
                },
                child: Container(
                  child: Image.asset(Images.ic_fillter),
                  width: 20,
                ),
              )
            ],
          ),
          Container(
            height: 1,
            color: colors.grayLight,
            margin: const EdgeInsets.only(top: 10, bottom: 10),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: list.length,
            itemBuilder: (BuildContext context, int index) {
              return PersonalGrievanceWidget(
                model: list[index],
                onClick: () {
                  NavigationMethod.moveToGrievanceDetails(list[index]);
                },
              );
            },
          )
        ],
      ),
    );
  }

  _clickFollow() {
    setState(() {
      users!.follow = !users!.follow!;
    });
    updateFollowApiCall(users!.id!);
  }

  Future<void> updateFollowApiCall(String userId) async {
    try {
      await Provider.of<PeopleProvider>(context, listen: false)
          .updateFollowApi(context, userId, FollowType.user)
          .then((value) => {});
    } on HttpException catch (error) {
    } catch (error) {}
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
        await Provider.of<GrievanceProvider>(context, listen: false)
            .getGrievanceListByUserID(context, page, selectType, users!.id!)
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

// if(!list.isEmpty){
// searchProductApiCall();
// }
  }

  Widget shimmer(BuildContext context) {
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
                              height: 100.0,
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

  void callUserDetailsApi() async {
    try {
      await Provider.of<PeopleProvider>(context, listen: false)
          .getProfileById(users!.id!)
          .then((value) {
        if (value != null) {
          print(value.id);
          setState(() {
            users = value;
          });
        }
      });
    } catch (error) {}
  }
}
