
import 'package:flutter/material.dart';
import 'package:grievance/common/widget/CardChatWidget.dart';
import 'package:grievance/common/widget/CardImageWidget.dart';
import 'package:grievance/common/widget/CardLikeCommentWidget.dart';
import 'package:grievance/common/widget/CardProfileDetailsWidget.dart';
import 'package:grievance/common/widget/CardVideoWidget.dart';
import 'package:grievance/model/Company.dart';
import 'package:grievance/model/Grievance.dart';
import 'package:grievance/model/UserModel.dart';
import 'package:grievance/theme/color.dart';
import 'package:grievance/theme/string.dart';
import 'package:grievance/theme/style.dart';
import 'package:grievance/utils/constants.dart';

class PeopleItemWidget extends StatelessWidget {
  Users? model;
  final VoidCallback? onFollowClick;
  PeopleItemWidget(this.model,{Key? key,this.onFollowClick}) : super(key: key) ;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigatorKey.currentState!.pushNamed(RouteName.publicProfileScreen,arguments: model);
      },
      child: Container(
        margin: const EdgeInsets.only(left: 15, right: 15, top: 8),
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                color: colors.grayLight,
                borderRadius: const BorderRadius.all(Radius.circular(50.0)),
                border: Border.all(
                  color: colors.grayLight,
                  width: 2.0,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(22.0),
                child: FadeInImage(
                    fadeInDuration: const Duration(milliseconds: 150),
                    image: (model!.image!.isNotEmpty) ?NetworkImage(model!.image!): const NetworkImage('https://yourlawnwise.com/wp-content.png'),
                    width: 45.0,
                    height: 45.0,
                    fit: BoxFit.cover,
                    imageErrorBuilder: (context, error, stackTrace) => Image.asset(
                      Images.person_placeholder,
                      fit: BoxFit.cover,
                      width: 45.0,
                      height: 45.0,
                    ),
                    placeholderErrorBuilder: (context, error, stackTrace) =>
                        Image.asset(
                          Images.person_placeholder,
                          fit: BoxFit.cover,
                          width: 45.0,
                          height: 45.0,
                        ),
                    placeholder: const AssetImage(Images.person_placeholder)),
              ),
            ),
            Expanded(child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "${model!.name}",
                      style: boldBlack14,
                    ),
                    const SizedBox(height: 3,),
                    Text(
                      "${model!.userable!.headline}",
                      style: regularGray12,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                )),
            GestureDetector(
              onTap: onFollowClick,
              child: Container(
                width: 90,
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        colors: [colors.firstColor, colors.secondColor]),
                    borderRadius: BorderRadius.circular(15)),
                child: Center(
                    child: Text(
                      (model!.follow!)?"Unfollow":"Follow",
                      style: regularWhite12,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
