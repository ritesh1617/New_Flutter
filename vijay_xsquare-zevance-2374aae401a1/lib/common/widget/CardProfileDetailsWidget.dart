import 'dart:math';

import 'package:flutter/material.dart';
import 'package:grievance/model/Grievance.dart';
import 'package:grievance/theme/color.dart';
import 'package:grievance/theme/string.dart';
import 'package:grievance/theme/style.dart';
import 'package:grievance/utils/constants.dart';

class CardProfileDetailsWidget extends StatelessWidget {
  Grievance? model;
  bool showLogo = false;
  final VoidCallback? onMenuClick;
  String? userID;

  CardProfileDetailsWidget(
      {Key? key,
        this.userID,
      required Grievance this.model,
      this.showLogo = false,
      this.onMenuClick});

  @override
  Widget build(BuildContext context) {
    print("++++ ${model!.userId} ${userID}");
    return GestureDetector(
      onTap: () {
        if (!model!.anonymous) {
          if(model!.userId==userID){
            navigatorKey.currentState!.pushNamed(RouteName.profileScreen,
                arguments: model!.users);
          }else {
            navigatorKey.currentState!.pushNamed(RouteName.publicProfileScreen,
                arguments: model!.users);
          }
        }else{
          navigatorKey.currentState!.pushNamed(RouteName.anonymousProfileScreen);
        }
      },
      child: Container(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
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
                        image: (model!.anonymous)
                            ? const NetworkImage(
                                'https://cdn1.iconfinder.com/data/icons/social-black-buttons/512/anonymous-512.png')
                            : (model!.users != null &&
                                    model!.users!.image!.isNotEmpty)
                                ? NetworkImage(model!.users!.image!)
                                : const NetworkImage(
                                    'https://cdn.osxdaily.com/wp-content/uploads/2015/04/photos.jpg'),
                        width: 40.0,
                        height: 40.0,
                        fit: BoxFit.cover,
                        imageErrorBuilder: (context, error, stackTrace) =>
                            Image.asset(
                              Images.person_placeholder,
                              fit: BoxFit.cover,
                              width: 40.0,
                              height: 40.0,
                            ),
                        placeholderErrorBuilder: (context, error, stackTrace) =>
                            Image.asset(
                              Images.person_placeholder,
                              fit: BoxFit.cover,
                              width: 40.0,
                              height: 40.0,
                            ),
                        placeholder:
                            const AssetImage(Images.person_placeholder)),
                  ),
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          (model!.anonymous)
                              ? "Anonymous"
                              : "${model!.users?.name}",
                          style: boldBlack12,
                        ),
                        (showLogo)
                            ? const SizedBox(
                                width: 5,
                              )
                            : Container(),
                        (showLogo)
                            ? Icon(
                                Icons.public,
                                size: 13,
                                color: colors.grayTemp,
                              )
                            : Container()
                      ],
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Text(
                        (model!.anonymous)
                            ? "Registered with Zevance but Anonymous to the world."
                            : "${model!.users?.userable?.headline}",
                        // : "Brainstorming my perfect headline. Coming soon!",
                        style: normalGray12.copyWith(fontSize: 12),
                        overflow: TextOverflow.ellipsis),
                    const SizedBox(
                      height: 3,
                    ),
                    (showLogo)
                        ? Container()
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                Utils.timeAgoForPost(model!.createdAt!,
                                    numericDates: true),
                                style: normalGray12.copyWith(fontSize: 12),
                              ),
                              Container(
                                width: 3.0,
                                height: 3.0,
                                margin:
                                    const EdgeInsets.only(left: 3, right: 3),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: colors.grayTemp),
                              ),
                              Icon(
                                Icons.public,
                                size: 13,
                                color: colors.grayTemp,
                              )
                            ],
                          ),
                    (showLogo)
                        ? Container(
                            margin: const EdgeInsets.only(top: 3),
                            child: Row(
                              children: [
                                Text(
                                  "Ticket Number : ",
                                  style: normalGray12.copyWith(
                                      fontSize: 12, color: colors.secondary),
                                ),
                                Text(
                                  "${model!.ticketNo}",
                                  style: normalGray12.copyWith(fontSize: 12),
                                ),
                              ],
                            ),
                          )
                        : Container(),
                  ],
                )),
                (showLogo)?Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(Images.ic_zevance,width: 80,height: 40,),
                    Text(Utils.timeAgo(model!.createdAt!),style: regularBlack10,),
                  ],
                ):GestureDetector(
                  onTap: onMenuClick,
                  child: Container(
                      padding:
                          const EdgeInsets.only(top: 15, bottom: 15, left: 20),
                      child: Icon(
                        Icons.more_vert_outlined,
                        size: 20,
                        color: colors.grayTemp,
                      )),
                )
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            GestureDetector(
              onTap: () {
                if (model!.company != null) {
                  navigatorKey.currentState!.pushNamed(
                      RouteName.companyProfileScreen,
                      arguments: model!.company);
                }
              },
              child: Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(1.0),
                    child: FadeInImage(
                        fadeInDuration: const Duration(milliseconds: 150),
                        image: (model!.company != null &&
                                model!.company!.logo!.isNotEmpty)
                            ? NetworkImage(model!.company!.logo!)
                            : const NetworkImage(
                                'https://cdn.osxdaily.com/wp-content.jpg'),
                        width: (showLogo) ? 25.0 : 15.0,
                        height: (showLogo) ? 25.0 : 15.0,
                        fit: BoxFit.cover,
                        imageErrorBuilder: (context, error, stackTrace) =>
                            Image.asset(
                              Images.person_placeholder,
                              fit: BoxFit.cover,
                              width: (showLogo) ? 25.0 : 15.0,
                              height: (showLogo) ? 25.0 : 15.0,
                            ),
                        placeholderErrorBuilder: (context, error, stackTrace) =>
                            Image.asset(
                              Images.person_placeholder,
                              fit: BoxFit.cover,
                              width: (showLogo) ? 25.0 : 15.0,
                              height: (showLogo) ? 25.0 : 15.0,
                            ),
                        placeholder:
                            const AssetImage(Images.person_placeholder)),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    "${(model!.company != null) ? model!.company?.companyName : model!.companyName}",
                    style: boldBlack12,
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
                          height: 15,)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
