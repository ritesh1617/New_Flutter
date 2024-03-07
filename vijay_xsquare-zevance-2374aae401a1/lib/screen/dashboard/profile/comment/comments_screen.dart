import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:grievance/common/widget/CommentItemWidget.dart';
import 'package:grievance/model/Comment.dart';
import 'package:grievance/model/UserModel.dart';
import 'package:grievance/provider/GrievanceProvider.dart';
import 'package:grievance/theme/color.dart';
import 'package:grievance/theme/string.dart';
import 'package:grievance/theme/style.dart';
import 'package:grievance/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shared_preferences/shared_preferences.dart';


class CommentScreen extends StatefulWidget {
  dynamic argument;

  CommentScreen(this.argument, {Key? key}) : super(key: key);

  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen>
    with TickerProviderStateMixin {
  final _commentController = TextEditingController();
  String grievanceId = "";

  Users? users;
  List<Comment> list = [];
  int page = 1;
  bool _isLoading = false;
  bool _isFirstTime = false;
  ScrollController controller = ScrollController();

  void _scrollListener() {
    if (!_isLoading) {
      if (controller.position.pixels == controller.position.maxScrollExtent) {
        commentListApiCall();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    grievanceId = widget.argument as String;
    controller = ScrollController()..addListener(_scrollListener);
    getUserDetails();
    commentListApiCall();
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
          "Comments",
          style: boldBlack18,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child:
                (_isLoading && page == 1) ? shimmer(context) :(list.length== 0)?Center(
                  child: (Text("No Comments",style: regularGray18,)),
                ): _commentWidget(),
          ),
          _sendComment(),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }

  Widget _commentWidget() {
    return ListView.builder(
        padding: const EdgeInsets.only(top: 7.5),
        itemCount: list.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext ctxt, int index) {
          return CommentItemWidget(list[index],()=>{
            _clickMakeLouder(index)
          });
        });
  }

  Widget _sendComment() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(width: 15),
        ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: FadeInImage(
              fadeInDuration: const Duration(milliseconds: 150),
              image: (users != null && users!.image!.isNotEmpty)
                  ? NetworkImage(users!.image!)
                  : const NetworkImage(
                  'https://yourlawnwise.com/wp-content/uploads/2017/08/photo-placeholder.png'),
              height: 35,
              width: 35,
              fit: BoxFit.cover,
              imageErrorBuilder: (context, error, stackTrace) => Image.asset(
                Images.person_placeholder,
                fit: BoxFit.cover,
                height: 35,
              ),
              placeholderErrorBuilder: (context, error, stackTrace) =>
                  Image.asset(
                    Images.person_placeholder,
                    fit: BoxFit.cover,
                    height: 35,
                  ),
              placeholder: const AssetImage(Images.person_placeholder)),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(left: 5, right: 15),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: colors.grayLight, width: 1)),
            child: TextField(
              textAlignVertical: TextAlignVertical.center,
              style: regularBlack14,
              controller: _commentController,
              decoration: InputDecoration(
                  suffixIcon: GestureDetector(
                    onTap: () => {_clickSendComment()},
                    child: Container(
                      width: 25,
                      height: 25,
                      decoration: const BoxDecoration(
                          color: colors.secondary,
                          shape: BoxShape.circle,),
                      child: const Icon(
                        Icons.send_outlined,
                        size: 25,
                        color: colors.whiteTemp,
                      ),
                    ),
                  ),
                  hintStyle: regularGray14,
                  hintText: "What's in your mind",
                  fillColor: Colors.white),
            ),
          ),
        )
      ],
    );
  }

  void _clickSendComment() {
    String comment = _commentController.text.toString().trim();
    if (comment.isEmpty) {
      ToastUtils.setSnackBar(context, "Please write what's in your mind!");
      return;
    }
    makeCommentApi(grievanceId, comment);
  }

  Future<void> makeCommentApi(String grievanceId, String comment) async {
    try {
      await Provider.of<GrievanceProvider>(context, listen: false)
          .makeCommentApi(context, grievanceId, comment)
          .then((value) => {makeCommentResponse(value)});
    } on HttpException catch (error) {} catch (error) {}
  }

  void makeCommentResponse(bool value) {
    if (value) {
      setState(() {
        _commentController.text = "";
      });
      page=1;
      commentListApiCall();
    }
  }

  Future<void> commentListApiCall() async {
    print(_isLoading);
    if (!_isLoading) {
      setState(() {
        _isLoading = true;
      });
      try {
        await Provider.of<GrievanceProvider>(context, listen: false)
            .getComment(context,page, grievanceId)
            .then((value) => {commentListResponse(value)});
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

  void commentListResponse(List<Comment> data) async {
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
            children: [0, 1, 2, 3, 4,]
                .map((_) => Padding(
                      padding: const EdgeInsetsDirectional.only(bottom: 8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                              height: 80.0,
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

  void _clickMakeLouder(int index) {
    setState(() {
      list[index].isLouder = !list[index].isLouder!;
      if(list[index].isLouder!){
        list[index].totalLouder = list[index].totalLouder!+1;
      }else{
        list[index].totalLouder = list[index].totalLouder!-1;
      }
    });
    updateLouderApiCall(list[index].id!);
  }

  Future<void> updateLouderApiCall(String grievanceId) async {
    try {
      await Provider.of<GrievanceProvider>(context, listen: false)
          .updateLouderApi(context,grievanceId,LouderType.comment)
          .then((value) => {
      });
    } on HttpException catch (error) {
    } catch (error) {
    }
  }

  void getUserDetails() async{
    final prefs = await SharedPreferences.getInstance();
    var userDate = prefs.getString(Constants.user);
    setState(() {
      users=Users.fromJson(json.decode(userDate!));
    });
  }
}
