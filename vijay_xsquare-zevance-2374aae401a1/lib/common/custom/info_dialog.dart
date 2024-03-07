import 'package:flutter/material.dart';
import 'package:grievance/theme/string.dart';
import 'package:grievance/theme/style.dart';

class InfoDialogBox extends StatefulWidget {
  final String? title, descriptions;
  final VoidCallback closePress;
  bool titleCenter=false;

  InfoDialogBox(
      {Key? key, this.title, this.descriptions, required this.closePress,this.titleCenter=false})
      : super(key: key);

  @override
  _InfoDialogBoxState createState() => _InfoDialogBoxState();
}

class _InfoDialogBoxState extends State<InfoDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(15.0),
          margin: const EdgeInsets.only(top: 25.0),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                children: [
                  const Expanded(child: SizedBox()),
                  InkWell(
                      onTap: () {
                        widget.closePress.call();
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.close,
                        size: 20,
                      )),
                ],
              ),
              Image.asset(Images.right_icon,width: 60,height: 60,),
              const SizedBox(
                height: 15,
              ),
              Text(
                widget.title!,
                style: boldBlack16,
                textAlign: (widget.titleCenter)?TextAlign.center:TextAlign.start,
              ),
              const SizedBox(
                height: 15,
              ),
              (widget.descriptions == "")
                  ? Container()
                  : Text(
                      widget.descriptions!,
                      style: regularBlack14,
                      textAlign: TextAlign.center,
                    ),
              (widget.descriptions == "")
                  ? Container()
                  : const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
