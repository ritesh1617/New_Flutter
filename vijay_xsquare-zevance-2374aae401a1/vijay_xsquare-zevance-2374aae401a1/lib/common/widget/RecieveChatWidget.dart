import 'package:flutter/material.dart';
import 'package:grievance/common/widget/ChatImageWidget.dart';
import 'package:grievance/model/Grievance.dart';
import 'package:grievance/theme/string.dart';
import 'package:grievance/theme/style.dart';
import 'package:grievance/utils/constants.dart';

import '../../theme/color.dart';

class ReceiveChatWidget extends StatelessWidget {
  Replies model;
  bool profileVisible;
  bool anonymous;

  ReceiveChatWidget(this.model,
      {Key? key, this.profileVisible = true, this.anonymous = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const SizedBox(
          height: 10,
        ),
        (profileVisible)
            ? Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    anonymous ? "Anonymous" : "${model.user?.name}",
                    style: regularBlack12,
                  ),
                  const SizedBox(
                    width: 7,
                  ),
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
                          image: anonymous
                              ? const NetworkImage(
                                  'https://cdn1.iconfinder.com/data/icons/social-black-buttons/512/anonymous-512.png')
                              : (model.user != null &&
                                      model.user!.image!.isNotEmpty)
                                  ? NetworkImage(model.user!.image!)
                                  : const NetworkImage(
                                      'https://cdn.osxdaily.com/wp-content/uploads/2015/04/photos.jpg'),
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
                  )
                ],
              )
            : Container(),
        Container(
          margin: const EdgeInsets.only(top: 5),
          constraints:
              BoxConstraints(maxWidth: MediaQuery.of(context).size.width * .7),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                (model.singleattachment != null && model.singleattachment?.mediaType==CustomFileType.photo)
                    ? ChatImageWidget(model.singleattachment)
                    : Container(width: 1,),
                Text(
                  "${model.reply}",
                  style: normalBlack12,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
