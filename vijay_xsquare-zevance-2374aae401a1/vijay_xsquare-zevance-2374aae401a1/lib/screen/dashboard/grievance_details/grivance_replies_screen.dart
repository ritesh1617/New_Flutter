import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:grievance/common/widget/CardLikeCommentWidget.dart';
import 'package:grievance/common/widget/RecieveRepliesWidget.dart';
import 'package:grievance/common/widget/SendRepliesWidget.dart';
import 'package:grievance/model/FileData.dart';
import 'package:grievance/model/Grievance.dart';
import 'package:grievance/model/UserModel.dart';
import 'package:grievance/provider/GrievanceProvider.dart';
import 'package:grievance/theme/color.dart';
import 'package:grievance/theme/string.dart';
import 'package:grievance/theme/style.dart';
import 'package:grievance/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';

class GrievanceRepliesScreen extends StatefulWidget {
  final dynamic _argument;

  const GrievanceRepliesScreen(this._argument, {Key? key}) : super(key: key);

  @override
  _GrievanceRepliesScreenState createState() => _GrievanceRepliesScreenState();
}

class _GrievanceRepliesScreenState extends State<GrievanceRepliesScreen>
    with TickerProviderStateMixin {
  Grievance? model;
  Users? users;
  final _repliesController = TextEditingController();

  int page = 1;
  bool _isLoading = false;
  ScrollController controller = ScrollController();

  List<Replies> repliesList = [];

  void _scrollListener() {
    if (!_isLoading) {
      if (controller.position.pixels == controller.position.maxScrollExtent) {
        repliesListApiCall();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    model = widget._argument as Grievance;
    getUserDetails();
    controller = ScrollController()..addListener(_scrollListener);
    repliesListApiCall();
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
              child: const Image(image: AssetImage(Images.ic_back)),
              padding: EdgeInsets.all(15),
            )),
        title: Text(
          "Grievance Details",
          style: boldBlack16,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _grievanceProfileDetails(),
          Expanded(
            //
            child: Align(
              alignment: Alignment.topCenter,
              child: StickyGroupedListView<Replies, DateTime>(
                elements: repliesList,
                order: StickyGroupedListOrder.DESC,
                reverse: true,
                shrinkWrap: true,
                groupBy: (Replies element) => DateTime(
                  element.date!.year,
                  element.date!.month,
                  element.date!.day,
                ),
                floatingHeader: true,
                groupSeparatorBuilder: _getGroupSeparator,
                itemBuilder: _rowItem,
              ),
            ),
          ),
          ((model!.userId == users?.id))
              ? Container(
                  margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                  padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 20.0),
                  decoration: BoxDecoration(
                      color: colors.whiteTemp,
                      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                      border: Border.all(color: colors.grayLight, width: 1)),
                  child:(model?.status != 'closed')? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "This Grievance is Open : ",
                        style: regularGray12,
                      ),
                      GestureDetector(
                        onTap: () {
                          _grievanceStatusDialog(context, 'closed');
                        },
                        child: Text(
                          "Close Now",
                          style: boldBlack12.copyWith(
                            color: colors.secondary,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      )
                    ],
                  ): Text(
                    "This Grievance is Closed.",
                    style: regularGray12,
                  ),
                )
              : Container(),
          (model?.status == 'closed' && (model!.userId == users?.id))?GestureDetector(
            onTap: () {
              navigatorKey.currentState!
                  .pushNamed(RouteName
                  .addGrievanceScreen,
                  arguments: model);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
              margin: EdgeInsets.only(bottom: 20,left: 20,right: 20),
              decoration: BoxDecoration(
                color: colors.whiteTemp,
                  border: Border.all(color: colors.secondary,width: 1),
                  borderRadius: BorderRadius.circular(25)),
              child: Center(
                  child: Text(
                    "Submit a new grievance",
                    style: regularWhite16.copyWith(color: colors.secondary),
                  )),
            ),
          ):Container(),
          (model?.status != 'closed' && (model!.userId == users?.id))
              ? _sendReplies()
              : Container(),
          ((model!.userId != users?.id))?
          Container(
            color: colors.whiteTemp,
            child:  CardLikeCommentWidget(model: model,
              onMakeLouder: () => {_clickMakeLouder()},
              onFeelYou: () => {_clickFeelYou()},
              onComment: (){
                navigatorKey.currentState!.pushNamed(RouteName.commentScreen,arguments: model?.id!).then((value) => getGrievanceById());
              },
              onShare: (){
                navigatorKey.currentState!.pushNamed(
                    RouteName.shareScreen,
                    arguments: model);
              },),
          )
         :Container()
        ],
      ),
    );
  }

  _grievanceProfileDetails() {
    return GestureDetector(
      child: Container(
        color: colors.whiteTemp,
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    "${model!.title}",
                    style: boldGray14.copyWith(color: colors.subtitle),
                  ),
                ),
                Text(
                  Utils.timeAgo(model!.createdAt!),
                  style: regularGray10,
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              "Ticket no : ${model!.ticketNo}",
              style: boldGray12,
            ),
            const SizedBox(
              height: 5,
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    if (model!.company != null) {
                      navigatorKey.currentState!.pushNamed(
                          RouteName.companyProfileScreen,
                          arguments: model!.company);
                    }
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5.0),
                        child: FadeInImage(
                            fadeInDuration: const Duration(milliseconds: 150),
                            image: (model!.company != null &&
                                    model!.company!.logo!.isNotEmpty)
                                ? NetworkImage(model!.company!.logo!)
                                : const NetworkImage(
                                    'https://yourlawnwise.com/wp-content/uploads/2017/08/photo-placeholder.png'),
                            height: 20,
                            width: 20,
                            fit: BoxFit.cover,
                            imageErrorBuilder: (context, error, stackTrace) =>
                                Image.asset(
                                  Images.rectangle_placeholder,
                                  fit: BoxFit.cover,
                                  height: 30,
                                ),
                            placeholderErrorBuilder:
                                (context, error, stackTrace) => Image.asset(
                                      Images.rectangle_placeholder,
                                      fit: BoxFit.cover,
                                      height: 30,
                                    ),
                            placeholder:
                                const AssetImage(Images.rectangle_placeholder)),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "${model!.company!.companyName}",
                        style: regularBlack14,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      (model!.company != null &&
                              model!.company!.is_verified != null &&
                              model!.company!.is_verified == "verified")
                          ? Image.asset(
                              Images.ic_verified,
                              width: 15,
                              height: 15,
                            )
                          : Image.asset(
                              Images.ic_unverified,
                              width: 15,
                              height: 15,
                            )
                    ],
                  ),
                ),
                Spacer(),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: (model!.status == "close" || model!.status == "closed") ? colors.close :(model!.status == "resolved") ? colors.resolve: colors.open),
                  padding:
                  const EdgeInsets.only(left: 10, right: 10, top: 3, bottom: 3),
                  child: Text(model!.status!.capitalize(),
                    style: regularWhite10,
                  ),
                ),
              ],
            ),
            // (model?.status == 'closed')
            //     ? Row(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: [
            //           Text(
            //             (Utils.getTime(model!.grievanceCloseTime!) > 72)
            //                 ? "This Grievance is Closed : "
            //                 : "This Grievance is Closed Now : ",
            //             style: regularGray12,
            //           ),
            //           GestureDetector(
            //             onTap: () {
            //               if ((Utils.getTime(model!.grievanceCloseTime!) >
            //                   72)) {
            //                 _submitGrievanceDialog(context);
            //               } else {
            //                 _grievanceStatusDialog(context, 'reopen');
            //               }
            //             },
            //             child: Text(
            //               (Utils.getTime(model!.grievanceCloseTime!) > 72)
            //                   ? "Click to submit thread"
            //                   : "Click to Reopen",
            //               style: boldBlack12.copyWith(color: colors.secondary),
            //             ),
            //           )
            //         ],
            //       )
            //     : Container()
          ],
        ),
      ),
    );
  }

  _sendReplies() {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 25),
            width: 30,
            height: 30,
            child: GestureDetector(
              onTap: () {
                Utils.mediaPicker(context, true, true, false, false, false)
                    .then((value) {
                  // print("++++++");
                  if (value != null) {
                    setState(() {
                      FileData selectedProofFile = value as FileData;
                      addAttachment(model!.id!, selectedProofFile);
                    });
                    // print(selectedFile!.type);
                  }
                });
              },
              child: const Icon(
                Icons.add,
                size: 30,
                color: colors.secondary,
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 5, right: 5),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: colors.grayLight, width: 1)),
              child: TextField(
                style: regularBlack14,
                maxLines: 1,
                controller: _repliesController,
                decoration: InputDecoration(
                  hintStyle: regularGray14,
                  hintText: "Add Your Replies",
                ),
              ),
            ),
          ),
          Container(
              margin: const EdgeInsets.only(right: 15),
              width: 40,
              height: 40,
              child: GestureDetector(
                onTap: () {
                  _clickSendReplies();
                },
                child: const Icon(
                  Icons.send_outlined,
                  size: 20,
                  color: colors.whiteTemp,
                ),
              ),
              decoration: const BoxDecoration(boxShadow: [
                BoxShadow(
                  color: colors.greenShado,
                  blurRadius: 2.0,
                ),
              ], shape: BoxShape.circle, color: colors.secondary))
        ],
      ),
    );
  }

  Future _grievanceStatusDialog(BuildContext context, String status) {

    return  Utils.customConfirmDialog(
        context, "Are you sure you want to close this grievance?")
        .then((value) {
      if (value == true) {
        updateGrievanceStatusApiCall(model!.id!, status);
      }
    });
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Confirmation',
            style: regularBlack16,
          ),
          content: Text(
            'Are you sure you want to ${(status == "closed") ? 'resolved' : 'reopen'} grievance?',
            style: regularBlack14,
          ),
          actions: [
            TextButton(
              child: Text(
                'Yes',
                style: regularBlack14.copyWith(color: colors.secondary),
              ),
              onPressed: () {
                updateGrievanceStatusApiCall(model!.id!, status);
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                'No',
                style: regularBlack14,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _clickSendReplies() {
    String replies = _repliesController.text.toString().trim();
    if (replies.isEmpty) {
      ToastUtils.setSnackBar(context, "Please write your replies!");
      return;
    }
    makeRepliesApi(model!.id!, replies);
  }

  Future<void> makeRepliesApi(String grievanceId, String replies) async {
    try {
      await Provider.of<GrievanceProvider>(context, listen: false)
          .makeRepliesApi(context, grievanceId, replies)
          .then((value) => {makeRepliesResponse(value)});
    } on HttpException catch (error) {}
  }

  void makeRepliesResponse(bool value) {
    if (value) {
      setState(() {
        _repliesController.text = "";
      });
      page = 1;
      repliesListApiCall();
    }
  }

  Future<void> repliesListApiCall() async {
    print(_isLoading);
    if (!_isLoading) {
      setState(() {
        _isLoading = true;
      });
      try {
        await Provider.of<GrievanceProvider>(context, listen: false)
            .getReplies(context, page, model!.id!)
            .then((value) => {repliesListResponse(value)});
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

  void repliesListResponse(List<Replies> data) async {
    if (page == 1) repliesList.clear();
    page = page + 1;
    setState(() {
      _isLoading = false;
      repliesList.addAll(data);
    });
//     if(!list.isEmpty){
// searchProductApiCall();
//     }
  }

  void getUserDetails() async {
    final prefs = await SharedPreferences.getInstance();
    var userDate = prefs.getString(Constants.user);
    setState(() {
      users = Users.fromJson(json.decode(userDate!));
    });
  }

  Future<void> updateGrievanceStatusApiCall(String grievanceId, String status) async {
    try {
      await Provider.of<GrievanceProvider>(context, listen: false)
          .updateGrievanceStatusApi(context, grievanceId, status)
          .then((value) => {
                if (value && status == "closed")
                  {
                    navigatorKey.currentState!.pushReplacementNamed(
                        RouteName.feedBackScreen,
                        arguments: grievanceId)
                  }
                else if (value && status == "reopen")
                  {getGrievanceById()}
              });
    } catch (error) {
      print(error);
    }
  }

  Future<void> submitGrievanceApiCall(String grievanceId) async {
    try {
      await Provider.of<GrievanceProvider>(context, listen: false)
          .submitGrievanceApi(context, grievanceId)
          .then((value) => {
                if (value)
                  {
                    navigatorKey.currentState!.pushReplacementNamed(
                        RouteName.feedBackScreen,
                        arguments: grievanceId)
                  }
              });
    } catch (error) {
      print(error);
    }
  }

  Future<void> getGrievanceById() async {
    try {
      await Provider.of<GrievanceProvider>(context, listen: false)
          .getGrievanceById(context, model!.id!)
          .then((value) => {
                if (value != null)
                  {
                    setState(() {
                      model = value;
                    })
                  }
              });
    } catch (error) {}
  }

  Widget _getGroupSeparator(Replies element) {
    return SizedBox(
      height: 50,
      child: Align(
        alignment: Alignment.center,
        child: Container(
          width: 100,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            border: Border.all(
              color: Colors.black12,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
          ),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
            child: Text(
              Utils.chatTimeAgo(element.date!),
              textAlign: TextAlign.center,
              style: regularBlack10,
            ),
          ),
        ),
      ),
    );
  }

  Widget _rowItem(BuildContext context, Replies replies) {
    return (replies.userId == model?.userId)
        ? ReceiveRepliesWidget(replies, model!)
        : SendRepliesWidget(replies);
  }

  void addAttachment(String grivanceID, FileData attachment) async {
    ProgressDialog pr = ProgressDialog(context,
        type: ProgressDialogType.normal,
        isDismissible: false,
        showLogs: true,
        customBody: Container(
          height: 70,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Please Wait... Attachment uploading..",
                  style: boldBlack14,
                )
              ],
            ),
          ),
        ));
    try {
      // Log user in

      pr.show();
      await Provider.of<GrievanceProvider>(context, listen: false)
          .makeRepliesWithAttachmentApi(context, grivanceID, attachment)
          .then((value) {
        pr.hide();
        responseAttachment(value);
      });
    } on HttpException catch (error) {
      pr.hide();
      print(error);
    } catch (error) {
      pr.hide();
      print(error);
    }
  }

  void responseAttachment(bool? value) async {
    if (value != null) {
      setState(() {
        _repliesController.text = "";
      });
      page = 1;
      repliesListApiCall();
    } else {
      ToastUtils.setSnackBar(context, "Something Wrong!");
    }
  }

  _clickMakeLouder() {
    setState(() {
      if (model!.isLouder) {
        model!.totalLoud =
            (int.parse(model!.totalLoud!) - 1).toString();
      } else {
        model!.totalLoud =
            (int.parse(model!.totalLoud!) + 1).toString();
      }
      model!.isLouder = !model!.isLouder;
    });
    updateLouderApiCall(model!.id!);
  }

  Future<void> updateLouderApiCall(String grievanceId) async {
    try {
      await Provider.of<GrievanceProvider>(context, listen: false)
          .updateLouderApi(context, grievanceId, LouderType.grievance)
          .then((value) => {});
    } on HttpException catch (error) {
    } catch (error) {}
  }

  _clickFeelYou() {
    setState(() {
      if (model!.isFeel) {
        model!.totalFeel = (int.parse(model!.totalFeel!) - 1).toString();
      } else {
        model!.totalFeel = (int.parse(model!.totalFeel!) + 1).toString();
      }
      model!.isFeel = !model!.isFeel;
    });
    updateFeelApiCall(model!.id!);
  }

  Future<void> updateFeelApiCall(String grievanceId) async {
    try {
      await Provider.of<GrievanceProvider>(context, listen: false)
          .updateFeelYouApi(context, grievanceId)
          .then((value) => {});
    } catch (error) {
      print(error);
    }
  }

}
