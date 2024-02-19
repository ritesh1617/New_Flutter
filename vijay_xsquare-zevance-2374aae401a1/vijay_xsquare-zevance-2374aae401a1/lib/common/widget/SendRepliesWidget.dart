import 'package:flutter/material.dart';
import 'package:grievance/model/Grievance.dart';
import 'package:grievance/theme/string.dart';
import 'package:grievance/theme/style.dart';
import 'package:grievance/utils/constants.dart';
import '../../theme/color.dart';
import 'ChatImageWidget.dart';

class SendRepliesWidget extends StatelessWidget {
  Replies model;

  SendRepliesWidget(this.model, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 5),
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
                      image: (model.user != null &&
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
              Text(
                "${model.user?.name}",
                style: boldBlack12,
              ),
            ],
          ),
          SizedBox(height: 3,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(
                child: Container(
                  decoration: BoxDecoration(
                    color: colors.whiteTemp,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                      boxShadow: [
                        BoxShadow(
                          color: colors.grayLight,
                          blurRadius: 1.0,
                        ),
                      ]
                  ),
                  child: Padding(
                    padding: EdgeInsets.all((model.singleattachment != null && model.singleattachment?.mediaType==CustomFileType.photo)?0:12.0),
                    child:  (model.singleattachment != null && model.singleattachment?.mediaType==CustomFileType.photo)
                        ? ChatImageWidget(model.singleattachment)
                        : Text(
                      "${model.reply}",
                      softWrap: true,
                      style: normalWhite12.copyWith(color: colors.grayTemp),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10,),
              Text(
                Utils.onlyTimeConvert(model.createdAt!),
                style: normalGray10,
              ),
              SizedBox(width: 30,),
            ],
          ),
        ],
      ),
    );
  }
}
