import 'package:flutter/material.dart';
import 'package:grievance/model/Grievance.dart';
import 'package:grievance/theme/string.dart';
import 'package:grievance/theme/style.dart';
import 'package:grievance/utils/constants.dart';

import '../../theme/color.dart';
import 'ChatImageWidget.dart';

class ReceiveRepliesWidget extends StatelessWidget {
  Replies model;
  Grievance grievance;

  ReceiveRepliesWidget(this.model, this.grievance,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                (grievance.anonymous) ? "Anonymous" : "${model.user?.name}",
                style: boldBlack12,
              ),
              Container(
                margin: const EdgeInsets.only(left: 5),
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
                      image: (grievance.anonymous)
                          ? const NetworkImage(
                          'https://cdn1.iconfinder.com/data/icons/social-black-buttons/512/anonymous-512.png')
                          : (model.user != null &&
                          model.user!.image!.isNotEmpty)
                          ? NetworkImage(model.user!.image!)
                          : const NetworkImage(
                          'https://cdn.osxdaily.com/wp-content/uploads/2015/04/photos.jpg'),
                      width: 20.0,
                      height: 20.0,
                      fit: BoxFit.cover,
                      imageErrorBuilder: (context, error, stackTrace) =>
                          Image.asset(
                            Images.person_placeholder,
                            fit: BoxFit.cover,
                            width: 20.0,
                            height: 20.0,
                          ),
                      placeholderErrorBuilder:
                          (context, error, stackTrace) => Image.asset(
                        Images.person_placeholder,
                        fit: BoxFit.cover,
                        width: 20.0,
                        height: 20.0,
                      ),
                      placeholder:
                      const AssetImage(Images.person_placeholder,)),
                ),
              ),
            ],
          ),
          SizedBox(height: 3,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(width: 30,),
              Text(
                Utils.onlyTimeConvert(model.createdAt!),
                style: normalGray10,
              ),
              SizedBox(width: 10,),
              Flexible(
                child: Container(
                  decoration: const BoxDecoration(
                    color: colors.secondary,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all((model.singleattachment != null && model.singleattachment?.mediaType==CustomFileType.photo)?0:12.0),
                    child:  (model.singleattachment != null && model.singleattachment?.mediaType==CustomFileType.photo)
                        ? ChatImageWidget(model.singleattachment)
                        : Text(
                      "${model.reply}",
                      softWrap: true,
                      style: normalWhite12,
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
