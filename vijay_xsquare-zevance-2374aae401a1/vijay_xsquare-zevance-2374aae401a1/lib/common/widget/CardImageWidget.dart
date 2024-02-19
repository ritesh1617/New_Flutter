import 'package:flutter/material.dart';
import 'package:grievance/model/Grievance.dart';
import 'package:grievance/theme/color.dart';
import 'package:grievance/theme/string.dart';
import 'package:grievance/theme/style.dart';
import 'package:grievance/utils/constants.dart';
import 'package:readmore/readmore.dart';

class CardImageWidget extends StatefulWidget {
  Grievance? model;

  CardImageWidget({Key? key, required Grievance this.model}) : super(key: key);

  @override
  State<CardImageWidget> createState() => _CardImageWidgetState();
}

class _CardImageWidgetState extends State<CardImageWidget> {
  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      Padding(
          padding: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
          child: ReadMoreText(widget.model!.description!,style: regularBlack12,
            trimLines: 2,
            colorClickableText: colors.grayTemp,
            trimMode: TrimMode.Line,
            trimCollapsedText: 'Show more',
            trimExpandedText: ' Show less',
            moreStyle: regularGray12,
          )),
      FadeInImage(
          fadeInDuration: const Duration(milliseconds: 150),
          image:  NetworkImage(widget.model!.attachments![0].url!),
          width: deviceWidth,
          fit: BoxFit.cover,
          imageErrorBuilder: (context, error, stackTrace) => Image.asset(
            Images.rectangle_placeholder,
            fit: BoxFit.cover,
          ),
          placeholderErrorBuilder: (context, error, stackTrace) =>
              Image.asset(
                Images.rectangle_placeholder,
                fit: BoxFit.cover,
              ),
          placeholder: AssetImage(Images.rectangle_placeholder)),
    ],);
  }
}
