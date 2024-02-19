
import 'package:flutter/material.dart';
import 'package:grievance/common/widget/CardChatWidget.dart';
import 'package:grievance/common/widget/CardLikeCommentWidget.dart';
import 'package:grievance/common/widget/CardProfileDetailsWidget.dart';
import 'package:grievance/common/widget/CardVideoWidget.dart';
import 'package:grievance/model/Grievance.dart';
import 'package:grievance/theme/color.dart';
import 'package:grievance/theme/string.dart';
import 'package:grievance/theme/style.dart';
import 'package:grievance/utils/constants.dart';

class CompanyGrievanceWidget extends StatefulWidget {
  Grievance? model;
  final VoidCallback? onClick;
  CompanyGrievanceWidget({Key? key,this.model,this.onClick}) : super(key: key) ;

  @override
  State<CompanyGrievanceWidget> createState() => _CompanyGrievanceWidgetState();
}

class _CompanyGrievanceWidgetState extends State<CompanyGrievanceWidget> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: widget.onClick,
          child: Container(
            color: colors.transparent,
            padding: const EdgeInsets.only(left: 20,right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(3.0),
                      child: FadeInImage(
                          fadeInDuration: const Duration(milliseconds: 150),
                          image: (widget.model!.company != null && widget.model!.company!.logo!.isNotEmpty)
                              ? NetworkImage(widget.model!.company!.logo!)
                              : const NetworkImage('https://yourlawnwise.com/wp-content/uploads/2017/08/photo-placeholder.png'),
                          height: 20,
                          width: 20,
                          fit: BoxFit.cover,
                          imageErrorBuilder: (context, error, stackTrace) =>
                              Image.asset(
                                Images.person_placeholder,
                                fit: BoxFit.cover,
                                height: 20,
                              ),
                          placeholderErrorBuilder: (context, error, stackTrace) =>
                              Image.asset(
                                Images.person_placeholder,
                                fit: BoxFit.cover,
                                height: 20,
                              ),
                          placeholder: const AssetImage(Images.person_placeholder)),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "${widget.model!.company?.companyName}",
                      // "widget.model!.company?.companyName}",
                      style: boldBlack12,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color:
                          (widget.model!.status == "close" || widget.model!.status == "closed") ? colors.close :(widget.model!.status == "resolved") ? colors.resolve: colors.open),
                      padding:
                      const EdgeInsets.only(left: 10, right: 10, top: 3, bottom: 3),
                      child: Text(widget.model!.status!.capitalize(),
                        style: regularWhite8,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      "Ticket no : ${widget.model?.ticketNo}",
                      style: regularGray10,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "${widget.model!.title}",
                  style: regularBlack12.copyWith(color: colors.titleColor),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  "${widget.model!.description}",
                  style: regularBlack10,
                ),
                Container(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    Utils.onlyDateConvert(widget.model!.createdAt!),
                    style: regularGray8,
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          height: 1,
          color: colors.grayLight,
          margin: const EdgeInsets.only(top: 10, bottom: 10),
        ),
      ],
    );
  }

}
