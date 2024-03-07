import 'dart:math';

import 'package:flutter/material.dart';
import 'package:grievance/model/Grievance.dart';
import 'package:grievance/theme/color.dart';
import 'package:grievance/theme/string.dart';
import 'package:grievance/theme/style.dart';
import 'package:grievance/utils/constants.dart';
import 'package:readmore/readmore.dart';

class GDProfileWidget extends StatelessWidget {
  Grievance? model;
  final VoidCallback? onUploadClick;
  String? userID;

  GDProfileWidget(
      {Key? key,
      this.userID,
      required Grievance this.model,
      this.onUploadClick});

  @override
  Widget build(BuildContext context) {
    print("++++ ${model!.userId} ${userID}");
    return GestureDetector(
      onTap: () {
        if (!model!.anonymous) {
          if (model!.users != null && model!.userId == userID) {
            navigatorKey.currentState!
                .pushNamed(RouteName.profileScreen, arguments: model!.users);
          } else {
            navigatorKey.currentState!.pushNamed(RouteName.publicProfileScreen,
                arguments: model!.users);
          }
        } else {
          navigatorKey.currentState!
              .pushNamed(RouteName.anonymousProfileScreen);
        }
      },
      child: Container(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
        color: Colors.white70,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      color: colors.grayLight,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(50.0)),
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
                          placeholderErrorBuilder:
                              (context, error, stackTrace) => Image.asset(
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
                        ],
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Row(
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
                            margin: const EdgeInsets.only(left: 3, right: 3),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: colors.grayTemp),
                          ),
                          Icon(
                            Icons.public,
                            size: 13,
                            color: colors.grayTemp,
                          )
                        ],
                      ),
                    ],
                  )),
                  (model!.userId==userID)?  GestureDetector(
                    onTap: onUploadClick,
                    child: Container(
                      padding: EdgeInsets.only(top: 10,bottom: 10),
                      child: Container(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 5, bottom: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              color: (model!.proofOfPurchase != null)
                                  ? colors.firstColor
                                  : colors.secondary),
                          child: Row(
                            children: [
                              Image.asset(
                                Images.icon_attach,
                                width: 10,
                                height: 10,
                                color: colors.whiteTemp,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                (model!.proofOfPurchase != null)
                                    ? "Replace Invoice"
                                    : "Upload Invoice",
                                style: regularWhite8,
                              )
                            ],
                          )),
                    ),
                  ):Container()
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
                          width: 15.0,
                          height: 15.0,
                          fit: BoxFit.cover,
                          imageErrorBuilder: (context, error, stackTrace) =>
                              Image.asset(
                                Images.person_placeholder,
                                fit: BoxFit.cover,
                                width: 15.0,
                                height: 15.0,
                              ),
                          placeholderErrorBuilder:
                              (context, error, stackTrace) => Image.asset(
                                    Images.person_placeholder,
                                    fit: BoxFit.cover,
                                    width: 15.0,
                                    height: 15.0,
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
                            height: 15,
                          )
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              ReadMoreText(
                model!.description!,
                style: regularBlack12,
                trimLines: 1,
                colorClickableText: colors.grayTemp,
                trimMode: TrimMode.Line,
                trimCollapsedText: 'Show more',
                trimExpandedText: ' Show less',
                moreStyle: regularGray12,
              )
            ],
          ),
        ),
      ),
    );
  }
}
