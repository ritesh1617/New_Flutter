import 'package:flutter/material.dart';
import 'package:grievance/model/Attachment.dart';
import 'package:grievance/theme/string.dart';
import '../../theme/color.dart';
import '../../utils/constants.dart';

class ChatImageWidget extends StatelessWidget {
  AttachmentData? model;

  ChatImageWidget(this.model, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double size=130.0;
    return GestureDetector(
      onTap: () {
        navigatorKey.currentState!.pushNamed(RouteName.imageViewerScreen,
            arguments: model!.url!);
      },
      child: Container(
        width: size+100,
        height: size,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: colors.grayLight,
                blurRadius: 3.0,
              ),
            ]),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: FadeInImage(
              fadeInDuration: const Duration(milliseconds: 150),
              image: NetworkImage(model!.url!),
              height: size,
              width: size,
              fit: BoxFit.cover,
              imageErrorBuilder: (context, error, stackTrace) => Image.asset(
                Images.rectangle_placeholder,
                fit: BoxFit.cover,
                height: size,
                width: size,
              ),
              placeholderErrorBuilder: (context, error, stackTrace) =>
                  Image.asset(
                    Images.rectangle_placeholder,
                    fit: BoxFit.cover,
                    height: size,
                    width: size,
                  ),
              placeholder: const AssetImage(Images.rectangle_placeholder)),
        ),
      ),
    );
  }
}
