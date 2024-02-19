import 'package:flutter/material.dart';
import 'package:grievance/common/widget/CardAudioWidget.dart';
import 'package:grievance/common/widget/CardChatWidget.dart';
import 'package:grievance/common/widget/CardImageWidget.dart';
import 'package:grievance/common/widget/CardLikeCommentWidget.dart';
import 'package:grievance/common/widget/CardPdfWidget.dart';
import 'package:grievance/common/widget/CardProfileDetailsWidget.dart';
import 'package:grievance/common/widget/CardVideoWidget.dart';
import 'package:grievance/model/Grievance.dart';
import 'package:grievance/theme/color.dart';
import 'package:grievance/theme/string.dart';
import 'package:grievance/theme/style.dart';
import 'package:grievance/utils/constants.dart';

class PostChatWidget extends StatefulWidget {
  Grievance? model;
  final VoidCallback? onFeelYou;
  final VoidCallback? onMakeLouder;
  final VoidCallback? onMenuClick;
  bool hideBottom = false;
  String? userID;

  PostChatWidget(
      {Key? key,
      this.model,
      this.onFeelYou,
      this.onMakeLouder,
      this.onMenuClick,
        this.userID,
      this.hideBottom = false})
      : super(key: key);

  @override
  State<PostChatWidget> createState() => _PostChatWidgetState();
}

class _PostChatWidgetState extends State<PostChatWidget> {
  final GlobalKey _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
   // print(widget.model!.id);
    return (widget.model!.isHide)
        ? Container()
        : GestureDetector(
            onTap: () {
              if (!widget.hideBottom) {
                NavigationMethod.moveToGrievanceDetails(widget.model!);
              }
            },
            child: RepaintBoundary(
              key: _globalKey,
              child: SizedBox(
                child: Container(
                  color: colors.whiteTemp,
                  margin: widget.hideBottom
                      ? EdgeInsets.all(15.0)
                      : EdgeInsets.only(top: 10),
                  //     decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(15),
                  //         color: Colors.white,
                  //         boxShadow: [
                  //           BoxShadow(
                  //             color: colors.grayLight,
                  //             blurRadius: 3.0,
                  //           ),
                  //         ]),
                  child: Column(
                    children: [
                      CardProfileDetailsWidget(
                        model: widget.model!,
                        showLogo: widget.hideBottom,
                        userID: widget.userID,
                        onMenuClick: widget.onMenuClick,
                      ),
                      (widget.model!.attachments!.isEmpty)
                          ? CardChatWidget(widget.model!.replies!)
                          : (widget.model!.attachments![0].mediaType ==
                                  CustomFileType.photo)
                              ? CardImageWidget(model: widget.model!)
                              : (widget.model!.attachments![0].mediaType ==
                                      CustomFileType.audio)
                                  ? CardAudioWidget(model: widget.model!)
                                  : (widget.model!.attachments![0].mediaType ==
                                          CustomFileType.video)
                                      ? CardVideoWidget(model: widget.model!)
                                      : (widget.model!.attachments![0]
                                                  .mediaType ==
                                              CustomFileType.pdf)
                                          ? CardPdfWidget(model: widget.model!)
                                          : CardChatWidget(
                                              widget.model!.replies!),
                      SizedBox(height: 4,),
                      Align(alignment: Alignment.topRight,child: Text('Grievance Details   ',style: normalBlack14.copyWith(color: colors.secondary,decoration: TextDecoration.underline,),)),
                      (!widget.hideBottom)
                          ? CardLikeCommentWidget(
                              model: widget.model!,
                              onFeelYou: widget.onFeelYou,
                              onMakeLouder: widget.onMakeLouder,
                              onComment: (){
                                navigatorKey.currentState!.pushNamed(RouteName.commentScreen,arguments: widget.model?.id!);
                              },
                              onShare: () {
                                navigatorKey.currentState!.pushNamed(
                                    RouteName.shareScreen,
                                    arguments: widget.model);
                              },
                            )
                          : Container()
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
