import 'package:flutter/material.dart';
import 'package:grievance/common/widget/CardChatWidget.dart';
import 'package:grievance/common/widget/CardImageWidget.dart';
import 'package:grievance/common/widget/CardLikeCommentWidget.dart';
import 'package:grievance/common/widget/CardProfileDetailsWidget.dart';
import 'package:grievance/common/widget/CardVideoWidget.dart';
import 'package:grievance/model/Company.dart';
import 'package:grievance/model/FeelModel.dart';
import 'package:grievance/model/Follower.dart';
import 'package:grievance/model/Grievance.dart';
import 'package:grievance/model/LouderModel.dart';
import 'package:grievance/model/UserModel.dart';
import 'package:grievance/theme/color.dart';
import 'package:grievance/theme/string.dart';
import 'package:grievance/theme/style.dart';
import 'package:grievance/utils/constants.dart';

class LouderItemWidget extends StatelessWidget {
  LouderModel? model;
  String userId;
  final VoidCallback? onFollowClick;

  LouderItemWidget(this.model, this.userId, {Key? key, this.onFollowClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if(isUser(model!, userId)){
          navigatorKey.currentState!.pushNamed(RouteName.profileScreen,arguments: model!.user);
        }
        else if (model!.user != null) {
          navigatorKey.currentState!.pushNamed(RouteName.publicProfileScreen, arguments: model!.user);
        }
      },
      child: Container(
        margin: const EdgeInsets.only(left: 15, right: 15, top: 8),
        child: Row(
          children: [
            Container(
              width: 50.0,
              height: 50.0,
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                color: colors.grayLight,
                image: DecorationImage(
                  image: NetworkImage((model!.user?.image != null)
                      ? model!.user!.image!
                      : "https://fff.png"),
                  fit: BoxFit.cover,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(50.0)),
                border: Border.all(
                  color: colors.grayLight,
                  width: 2.0,
                ),
              ),
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  (model!.user!.id!.toString() == userId)
                      ? "You"
                      : "${model!.user?.name}",
                  style: boldBlack14,
                ),
                const SizedBox(height: 3,),
                Text("${model!.user?.userable?.headline}",
                    style: regularGray12, overflow: TextOverflow.ellipsis),
              ],
            )),
            (model!.user!.id!.toString() == userId)
                ? Container( width: 90,)
                : (model!.user!.follow!)
                    ? Container(width: 90,)
                    : GestureDetector(
                        onTap: onFollowClick,
                        child: Container(
                          width: 90,
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          decoration: BoxDecoration(
                              gradient: const LinearGradient(colors: [
                                colors.firstColor,
                                colors.secondColor
                              ]),
                              borderRadius: BorderRadius.circular(15)),
                          child: Center(
                              child: Text(
                            (model!.user!.follow!) ? "Unfollow" : "Follow",
                            style: regularWhite12,
                          )),
                        ),
                      ),
          ],
        ),
      ),
    );
  }

  bool isUser(LouderModel model,String id){
    // print("sss"+ model.users!.id.toString());
    // print("sss"+ userId);
    if(model.userId==userId){
      return true;
    }
    return false;
  }
}
