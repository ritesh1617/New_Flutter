import 'package:flutter/material.dart';
import 'package:grievance/model/Comment.dart';
import 'package:grievance/theme/color.dart';
import 'package:grievance/theme/string.dart';
import 'package:grievance/theme/style.dart';
import 'package:grievance/utils/constants.dart';

class CommentItemWidget extends StatelessWidget {
  Comment? item;
  VoidCallback? onMakeLouder;

  CommentItemWidget(this.item, this.onMakeLouder, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: FadeInImage(
                fadeInDuration: const Duration(milliseconds: 150),
                image: NetworkImage(item!.user!.image!),
                height: 30,
                width: 30,
                fit: BoxFit.cover,
                imageErrorBuilder: (context, error, stackTrace) => Image.asset(
                      Images.person_placeholder,
                      fit: BoxFit.cover,
                      height: 30,
                    ),
                placeholderErrorBuilder: (context, error, stackTrace) =>
                    Image.asset(
                      Images.person_placeholder,
                      fit: BoxFit.cover,
                      height: 30,
                    ),
                placeholder: const AssetImage(Images.person_placeholder)),
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 5, right: 10),
                decoration: BoxDecoration(
                    color: colors.whiteTemp,
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(color: colors.grayTemp, blurRadius: 1)
                    ]),
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item!.user!.name.toString().capitalize(),
                                style: boldBlack12,
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              Text(item!.user!.userable!.headline.toString(),
                                  style: regularGray12,
                                  overflow: TextOverflow.ellipsis)
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Text(
                          Utils.timeAgoForPost(item!.createdAt!),
                          style: regularGray10,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      item!.comment!,
                      style: regularBlack12,
                    ),
                  ],
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: onMakeLouder,
                    child: Text(
                      "Like",
                      style: boldGray12.copyWith(
                          color: (item!.isLouder!)
                              ? colors.secondColor
                              : colors.grayTemp),
                    ),
                  ),
                  (item!.totalLouder != 0)
                      ? Container(
                          width: 3,
                          height: 3,
                          margin: const EdgeInsets.only(left: 5, right: 5),
                          decoration: BoxDecoration(
                              color: colors.grayTemp,
                              borderRadius: const BorderRadius.all(Radius.circular(3))),
                        )
                      : Container(),
                  (item!.totalLouder != 0)
                      ? Image.asset(
                          Images.icon_comment_like,
                          width: 12,
                          height: 12,
                        )
                      : Container(),
                  (item!.totalLouder != 0)
                      ? const SizedBox(
                          width: 5,
                        )
                      : Container(),
                  (item!.totalLouder != 0)
                      ? Text(
                          item!.totalLouder.toString(),
                          style: boldGray12,
                        )
                      : Container(),
                ],
              ),
              const SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ],
    );
  }
}
