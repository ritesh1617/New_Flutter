
import 'package:flutter/material.dart';
import 'package:grievance/common/widget/CardChatWidget.dart';
import 'package:grievance/common/widget/CardImageWidget.dart';
import 'package:grievance/common/widget/CardLikeCommentWidget.dart';
import 'package:grievance/common/widget/CardProfileDetailsWidget.dart';
import 'package:grievance/common/widget/CardVideoWidget.dart';
import 'package:grievance/model/Company.dart';
import 'package:grievance/model/Grievance.dart';
import 'package:grievance/theme/color.dart';
import 'package:grievance/theme/string.dart';
import 'package:grievance/theme/style.dart';
import 'package:grievance/utils/constants.dart';

class CompanyItemWidget extends StatelessWidget {
  Company? model;
  CompanyItemWidget(this.model,{Key? key,}) : super(key: key) ;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigatorKey.currentState!.pushNamed(RouteName.companyProfileScreen,arguments: model);
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: colors.grayLight,
                blurRadius: 3.0,
              ),
            ]),
        margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
        padding: const EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: FadeInImage(
                  fadeInDuration: const Duration(milliseconds: 150),
                  image: (model!.logo!.isNotEmpty)?NetworkImage(model!.logo!):const NetworkImage("https://banksiafdn.com/wp-content/uploads/2019/10/placeholde-image.jpg"),
                  height: 80,
                  width: 80,
                  fit: BoxFit.cover,
                  imageErrorBuilder: (context, error, stackTrace) =>
                      Image.asset(
                        Images.rectangle_placeholder,
                        fit: BoxFit.cover,
                        height: 80,
                        width: 80,
                      ),
                  placeholderErrorBuilder: (context, error, stackTrace) =>
                      Image.asset(
                        Images.rectangle_placeholder,
                        fit: BoxFit.cover,
                        height: 80,
                        width: 80,
                      ),
                  placeholder: const AssetImage(Images.rectangle_placeholder)),
            ),
            const SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: deviceWidth!-150,
                  child: Text(
                    "${model!.companyName}",
                    overflow: TextOverflow.ellipsis,
                    style: regularBlack14,
                  ),
                ),
                const SizedBox(
                  height: 7,
                ),
                Row(
                  children: [
                    Container(
                      width: 7,
                      height: 7,
                      decoration: BoxDecoration(
                          color: colors.grayLight,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    const SizedBox(
                      width: 7,
                    ),
                    Text(
                      "${model!.openTickets} Open Tickets",
                      style: regularGray10,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Container(
                      width: 7,
                      height: 7,
                      decoration: BoxDecoration(
                          color: colors.grayLight,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    const SizedBox(
                      width: 7,
                    ),
                    Text(
                      "${model!.closedTickets} Resolved Tickets",
                      style: regularGray10,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Container(
                      width: 7,
                      height: 7,
                      decoration: BoxDecoration(
                          color: colors.grayLight,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    const SizedBox(
                      width: 7,
                    ),
                    Text(
                      "${model?.zeescore} Zee Score",
                      style: regularGray10,
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
