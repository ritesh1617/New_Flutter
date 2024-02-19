import 'dart:io';

import 'package:flutter/material.dart';
import 'package:grievance/model/Notification.dart';
import 'package:grievance/model/content.dart';
import 'package:grievance/provider/ProfileProvider.dart';
import 'package:grievance/theme/color.dart';
import 'package:grievance/theme/string.dart';
import 'package:grievance/theme/style.dart';
import 'package:grievance/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen>
    with TickerProviderStateMixin {
  bool _isLoadingNotification = false;
  List<NotificationData> notificationList = [];
  int notificationPage = 1;
  String searchText = "";
  ScrollController notificationController = ScrollController();

  void _scrollNotificationListener() {
    if (!_isLoadingNotification) {
      if (notificationController.position.pixels ==
          notificationController.position.maxScrollExtent) {
        notificationPage = notificationPage + 1;
        notificationListApiCall(notificationPage);
      }
    }
  }

  @override
  void initState() {
    super.initState();

    notificationController = ScrollController()
      ..addListener(_scrollNotificationListener);
    notificationListApiCall(1);
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
              child: Container(child: const Image(image: AssetImage(Images.ic_back)),padding: EdgeInsets.all(15),)),
          title: Text(
            "Notifications",
            style: regularBlack18,
          ),
          elevation: 1.0,
          shadowColor: colors.grayLight,
          centerTitle: true,
        ),
        body: _getNotificationList());
  }

  _getNotificationList() {
    return (_isLoadingNotification && notificationPage == 1)
        ? shimmerNotification(context)
        : _notificationWidget();
  }

  _notificationWidget() {
    return ListView.builder(
        padding: const EdgeInsets.only(top: 7.5),
        itemCount: notificationList.length,
        shrinkWrap: true,
        controller: notificationController,
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext ctxt, int index) {
          return _notificationItem(notificationList[index]);
        });
  }

  _notificationItem(NotificationData item) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: FadeInImage(
                    fadeInDuration: const Duration(milliseconds: 150),
                    image: const NetworkImage("www.ddd.com/asb.png"),
                    height: 20,
                    width: 20,
                    fit: BoxFit.cover,
                    imageErrorBuilder: (context, error, stackTrace) =>
                        Image.asset(
                          Images.person_placeholder,
                          fit: BoxFit.cover,
                          height: 20,
                        ),
                    placeholderErrorBuilder: (context, error, stackTrace) =>
                        Image.asset(
                          Images.person_placeholder,
                          fit: BoxFit.cover,
                          height: 20,
                        ),
                    placeholder:
                        const AssetImage(Images.person_placeholder)),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                "${item.title}",
                style: regularBlack14,
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            "${item.description}",
            style: regularGray10,
          ),
          Container(
            alignment: Alignment.bottomRight,
            child: Text(
              Utils.dateConvert(item.createdAt!),
              style: regularGray10,
            ),
          ),
          Container(
            height: 1,
            color: colors.grayLight,
            margin: const EdgeInsets.only(top: 5, bottom: 0),
          ),
        ],
      ),
    );
  }

  Future<void> notificationListApiCall(int page) async {
    notificationPage = page;
    print(_isLoadingNotification);
    // if (!_isLoadingNotification) {
    setState(() {
      _isLoadingNotification = true;
    });
    try {
      await Provider.of<ProfileProvider>(context, listen: false)
          .getNotificationList(page)
          .then((value) => {notificationListResponse(value, page)});
    } on HttpException catch (error) {
      setState(() {
        _isLoadingNotification = false;
      });
      print(error);
    } catch (error) {
      setState(() {
        _isLoadingNotification = false;
      });
      print(error);
    }
    // }
  }

  void notificationListResponse(List<NotificationData> data, int page) async {
    if (page == 1) {
      notificationList.clear();
    }
    setState(() {
      _isLoadingNotification = false;
      print(data.length);
      notificationList.addAll(data);
    });
  }

  Widget shimmerNotification(BuildContext context) {
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
}
