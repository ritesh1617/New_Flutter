
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

class PersonalGrievanceWidget extends StatefulWidget {
  Grievance? model;
  final VoidCallback? onClick;
  PersonalGrievanceWidget({Key? key,this.model,this.onClick}) : super(key: key) ;

  @override
  State<PersonalGrievanceWidget> createState() => _PersonalGrievanceWidgetState();
}

class _PersonalGrievanceWidgetState extends State<PersonalGrievanceWidget> {
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
                      borderRadius: BorderRadius.circular(15.0),
                      child: FadeInImage(
                          fadeInDuration: const Duration(milliseconds: 150),
                          image:(widget.model!.anonymous)
                              ? const NetworkImage(
                              'https://cdn1.iconfinder.com/data/icons/social-black-buttons/512/anonymous-512.png'): (widget.model!.users != null && widget.model!.users!.image!.isNotEmpty)
                              ? NetworkImage(widget.model!.users!.image!)
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
                    Flexible(
                      child: Text(
                        (widget.model!.anonymous)
                            ? "Anonymous": "${widget.model!.users?.name}",
                        style: boldBlack12,
                      ),
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
                    )
                  ],
                ),
                const SizedBox(
                  height: 5,
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
