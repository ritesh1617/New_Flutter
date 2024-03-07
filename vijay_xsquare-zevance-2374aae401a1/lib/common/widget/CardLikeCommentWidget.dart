import 'package:flutter/material.dart';
import 'package:grievance/common/widget/PostDevider.dart';
import 'package:grievance/model/Grievance.dart';
import 'package:grievance/theme/color.dart';
import 'package:grievance/theme/style.dart';
import 'package:grievance/utils/constants.dart';

import '../../theme/string.dart';

class CardLikeCommentWidget extends StatelessWidget {
  Grievance? model;
  final VoidCallback? onFeelYou;
  final VoidCallback? onMakeLouder;
  final VoidCallback? onComment;
  final VoidCallback? onShare;

  CardLikeCommentWidget(
      {Key? key, this.model, this.onFeelYou,this.onComment, this.onMakeLouder,this.onShare})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
                onTap: (){
                  navigatorKey.currentState!.pushNamed(RouteName.ifeelyouScreen,arguments: model);
                },
                child: Container(
                    padding: EdgeInsets.only(top: 10,bottom:10),
                    child: Utils.getNumberFeelYou(model?.totalFeel,model?.isFeel))),
            const Spacer(),
            Utils.getCommentAndLouder(model?.totalComment,model?.totalLoud,model!,onComment)
          ],
        ),
        Container(width: deviceWidth!,height: 1,color: colors.backgroundColor,),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child:  GestureDetector(
              onTap: onFeelYou,
              child: Container(
                color: colors.transparent,
                padding: const EdgeInsets.only(top: 10,bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      (model!.isFeel)? Images.ic_feel_selected :  Images.ic_feel,
                      width: 15,
                      height: 15,
                    ),
                    const SizedBox(height: 2,),
                    Text(
                      "I feel you",
                      style: regularBlack10.copyWith(color: (model!.isFeel) ? colors.secondary : colors.blackTemp,),
                    ),
                  ],
                ),
              ),
            ),),
            Expanded(child:GestureDetector(
              onTap:onComment,
              child: Container(
                color: colors.transparent,
                padding: const EdgeInsets.only(top: 10,bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      Images.ic_comment,
                      width: 15,
                      height: 15,
                      color: colors.blackTemp,
                    ),
                    const SizedBox(height: 2,),
                    Text(
                      "Comment",
                      style: regularBlack10.copyWith(color:colors.blackTemp),
                    ),
                  ],
                ),
              ),
            ),),
            Expanded(child:  GestureDetector(
              onTap: onMakeLouder,
              child: Container(
                color: colors.transparent,
                padding: const EdgeInsets.only(top: 10,bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      Images.ic_louder,
                      width: 15,
                      height: 15,
                      color: (model!.isLouder) ? colors.secondary : colors.blackTemp,
                    ),
                    const SizedBox(height: 2,),
                    Text(
                      "Make it Louder",
                      style: regularBlack10.copyWith(color: (model!.isLouder) ? colors.secondary : colors.blackTemp,),
                    ),
                  ],
                ),
              ),
            ),),
            Expanded(child:  GestureDetector(
              onTap: onShare,
              child: Container(
                color: colors.transparent,
                padding: const EdgeInsets.only(top: 10,bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      Images.ic_share,
                      width: 15,
                      height: 15,
                      color:  colors.blackTemp,
                    ),
                    const SizedBox(height: 2,),
                    Text(
                      "Share",
                      style: regularBlack10.copyWith(color:  colors.blackTemp,),
                    ),
                  ],
                ),
              ),
            ),),
          /*  GestureDetector(
              onTap: () {
                navigatorKey.currentState!.pushNamed(RouteName.commentScreen,arguments: model?.id!);
              },
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 5, left: 5),
                    width: 17,
                    height: 17,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        color: colors.whiteTemp),
                    child: Image.asset(
                      Images.ic_comment,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    "Comment",
                    style: normalGray12,
                  ),
                ],
              ),
            ),
            const Spacer(),
            Container(
              padding:
                  const EdgeInsets.only(left: 10, right: 2, top: 3, bottom: 3),
              decoration: BoxDecoration(
                color: colors.secondaryLight,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Row(
                children: [
                  GestureDetector(
                      onTap: onMakeLouder,
                      child: Text(
                        (model!.isLouder) ? "Louder": "Make It Louder",
                        style: regularGray10.copyWith(color: colors.secondary),
                      )),
                  GestureDetector(
                    onTap: onShare,
                    child: Container(
                      margin: const EdgeInsets.only(left: 10),
                      padding: const EdgeInsets.only(left: 10, right: 10, top: 4, bottom: 4),
                      decoration: BoxDecoration(
                        color: colors.secondary,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Row(
                        children: [
                          Text(
                            "Share",
                            style: regularWhite10,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )*/
          ],
        ),
      ],
    );
  }
}
