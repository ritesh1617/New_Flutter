import 'dart:io';

import 'package:flutter/material.dart';
import 'package:grievance/common/widget/CompanyGrievanceWidget.dart';
import 'package:grievance/common/widget/PersonalGrievanceWidget.dart';
import 'package:grievance/model/Grievance.dart';
import 'package:grievance/model/UserModel.dart';
import 'package:grievance/model/content.dart';
import 'package:grievance/provider/GrievanceProvider.dart';
import 'package:grievance/theme/color.dart';
import 'package:grievance/theme/string.dart';
import 'package:grievance/theme/style.dart';
import 'package:grievance/utils/constants.dart';
import 'package:shimmer/shimmer.dart';
import 'package:provider/provider.dart';

class TicketManagementScreen extends StatefulWidget {

  final dynamic _argument;
  const TicketManagementScreen(this._argument, {Key? key}) : super(key: key);

  @override
  _TicketManagementScreenState createState() => _TicketManagementScreenState();
}

class _TicketManagementScreenState extends State<TicketManagementScreen>
    with TickerProviderStateMixin {
  List<Grievance> list = [];

  Users? users;
  int page = 1;
  bool _isLoading = false;

  ScrollController controller = ScrollController();
  var selectType="";
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
    users=widget._argument as Users;
    controller = ScrollController()..addListener(_scrollListener);
    grievanceListApiCall();
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
          "My Grievance",
          style: boldBlack16,
        ),
        elevation: 1.0,
        shadowColor: colors.grayLight,
        centerTitle: true,
        actions: [
          PopupMenuButton(
            color: colors.backgroundColor,
            itemBuilder: (_) => <PopupMenuItem<String>>[
              PopupMenuItem<String>(
                  value: '',
                  child: Text(
                    'All',
                    style: TextStyle(
                        fontSize: 12.0, fontWeight: FontWeight.w500,color:(selectType=='')? colors.primary:colors.black54),
                  )),
              PopupMenuItem<String>(
                  value: 'open',
                  child: Text(
                    'Open',
                    style: TextStyle(
                        fontSize: 12.0, fontWeight: FontWeight.w500,color:(selectType=='open')? colors.primary:colors.black54),
                  )),
              PopupMenuItem<String>(
                  value: 'resolved',
                  child: Text(
                    'Closed',
                    style: TextStyle(
                        fontSize: 12.0, fontWeight: FontWeight.w500,color:(selectType=='resolved')? colors.primary:colors.black54),
                  )),
              PopupMenuItem<String>(
                  value: 'sort_by_time',
                  child: Text(
                    'Sort By Time',
                    style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w500,color:(selectType=='sort_by_time')? colors.primary:colors.black54),
                  )),
              // PopupMenuItem<String>(
              //     value: 'upvote',
              //     child: Text(
              //       'Upvote',
              //       style: TextStyle(
              //           fontSize: 12.0, fontWeight: FontWeight.w500,color:(selectType=='upvote')? colors.primary:colors.black54),
              //     )),
            ],
            onSelected: (String value) {
              page=1;
              selectType=value;
              grievanceListApiCall();
            },
            child: Container(padding: const EdgeInsets.all(15),child: const Image(image: AssetImage(Images.ic_fillter),width: 20,height: 20,),),
          )
        ],
      ),
      body: (_isLoading && page == 1)
          ? shimmer(context)
          : ListView.builder(
          padding: const EdgeInsets.only(top: 7.5),
          controller: controller,
          itemCount: list.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (BuildContext ctxt, int index) {
            return CompanyGrievanceWidget(
              model: list[index],
              onClick: () {
                NavigationMethod.moveToGrievanceDetails(list[index]);
              },
            );
          }),
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
        await Provider.of<GrievanceProvider>(context, listen: false)
            .getGrievanceListByUserID(context,page, selectType,users!.id!)
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

  _notificationItem(Content item) {
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
                    fadeInDuration: Duration(milliseconds: 150),
                    image: NetworkImage(item.url!),
                    height: 20,
                    width: 20,
                    fit: BoxFit.cover,
                    imageErrorBuilder: (context, error, stackTrace) =>
                        Image.asset(
                          Images.rectangle_placeholder,
                          fit: BoxFit.cover,
                          height: 30,
                        ),
                    placeholderErrorBuilder: (context, error, stackTrace) =>
                        Image.asset(
                          Images.rectangle_placeholder,
                          fit: BoxFit.cover,
                          height: 30,
                        ),
                    placeholder: AssetImage(Images.rectangle_placeholder)),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                item.title!,
                style: regularBlack14,
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color:
                        (item.status == "open") ? colors.open : colors.close),
                padding:
                    const EdgeInsets.only(left: 10, right: 10, top: 3, bottom: 3),
                child: Text(
                  item.status!.capitalize(),
                  style: regularWhite8,
                ),
              ),
              Spacer(),
              Text(
                "Ticket no : 5484114400",
                style: regularGray10,
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            "Hibernate Program just to check icon ",
            style: normalGray12.copyWith(color: colors.subtitle),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            "Lorem Ipsum is simply dummy text of the printing" +
                "and typesetting industry. Lorem Ipsum has been" +
                "the industry's standard dummy text ever since the",
            style: regularGray10,
          ),
          Container(
            alignment: Alignment.bottomRight,
            child: Text(
              "30-06-2021",
              style: regularGray10,
            ),
          ),
          Container(
            height: 1,
            color: colors.grayLight,
            margin: const EdgeInsets.only(top: 10, bottom: 0),
          ),
        ],
      ),
    );
  }

  void doNothing(BuildContext context) {

  }
}
