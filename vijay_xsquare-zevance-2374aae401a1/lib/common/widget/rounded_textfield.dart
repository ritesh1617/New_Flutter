import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grievance/theme/string.dart';

import '../../theme/color.dart';
import '../../theme/style.dart';

class CRoundedTextField extends StatelessWidget {
  String? hintText = "";
  String? lable;
  TextEditingController? controller = TextEditingController();
  TextInputType? keyboardType = TextInputType.text;
  TextInputFormatter? inputFormatters;
  double margin = 20.0;
  int line = 1;
  bool readOnly = false;
  bool dropDown = false;
  Function? onPressed = () => {};
  //VoidCallback? onInfo=()=>{};
  ValueSetter<BuildContext?>? onInfo = (value) async {};
  bool infoVisible=false;
  final FocusNode _focus = FocusNode();
  IconData? icon;
  bool suffix = false;
  List<String>? items;
  int maxLength=0;

  CRoundedTextField(
      {Key? key, this.hintText,
      this.lable,
      this.controller,
      this.keyboardType,
      this.inputFormatters,
      this.dropDown = false,
      this.items,
      this.margin = 20.0,
      this.readOnly = false,
      this.infoVisible = false,
      this.onPressed,
      this.onInfo,
      this.icon,
      this.suffix = false,
      this.maxLength=0,
      this.line = 1}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (!dropDown)
        ? Padding(
            padding: const EdgeInsetsDirectional.only(
              top: 10.0,
              start: 25.0,
              end: 25.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                (lable != "")
                    ? Row(
                      children: [
                        Text(
                            lable!,
                            style: boldGray13,
                          ),
                        const Expanded(child: SizedBox()),(infoVisible)?GestureDetector(
                            onTap:()=>onInfo!(context),
                            child: const Icon(Icons.info_outline_rounded,size: 15,color: colors.black54,)):Container()
                      ],
                    )
                    : Container(),
                const SizedBox(height: 5,),
                TextFormField(
                  keyboardType: keyboardType,
                  textInputAction: TextInputAction.next,
                  controller: controller,
                  focusNode: _focus,
                  enabled: !readOnly,
                  maxLines: line,
                  textCapitalization: TextCapitalization.sentences,
                  maxLength: (maxLength!=0)?maxLength:null,
                  cursorColor: colors.primary,
                  style: regularBlack14,
                  decoration: InputDecoration(
                    fillColor: colors.whiteTemp,
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: colors.grayLight, width: 1.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: colors.grayLight, width: 1.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),

                    filled: true,
                    prefixIcon: (icon != null)
                        ? Icon(
                            (icon == null)
                                ? Icons.alternate_email_outlined
                                : icon!,
                            color: Theme.of(context).colorScheme.fontColor,
                            size: 17,
                          )
                        : null,
                    hintText: hintText,
                    hintStyle:regularGray14,
                    // filled: true,
                    // fillColor: Theme.of(context).colorScheme.lightWhite,
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: 20, vertical: (line == 1) ? 0 : 15),
                    prefixIconConstraints:
                        BoxConstraints(minWidth: 40, maxHeight: 25),
                    suffixIcon: (suffix)?Container(
                        margin: EdgeInsets.all(4),
                        child: Image.asset(Images.ic_google)):null,
                    // focusedBorder: OutlineInputBorder(
                    //   borderSide: BorderSide(color: Theme.of(context).colorScheme.fontColor),
                    //   borderRadius: BorderRadius.circular(10.0),
                    // ),
                  ),
                ),
              ],
            ),
          )
        : Padding(
            padding: const EdgeInsetsDirectional.only(
              top: 10.0,
              start: 25.0,
              end: 25.0,
            ),
            child: PopupMenuButton<String>(
              child: TextFormField(
                keyboardType: keyboardType,
                textInputAction: TextInputAction.next,
                controller: controller,
                focusNode: _focus,
                textCapitalization: TextCapitalization.sentences,
                enabled: false,
                cursorColor: colors.primary,
                style: const TextStyle(
                    color: colors.blackTemp,
                    fontSize: 14.0,
                    fontWeight: FontWeight.normal),
                decoration: InputDecoration(
                  fillColor: colors.lightWhite2,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  filled: true,
                  prefixIcon: Icon(
                    (icon == null) ? Icons.alternate_email_outlined : icon!,
                    color: Theme.of(context).colorScheme.fontColor,
                    size: 17,
                  ),
                  hintText: hintText,
                  suffixIcon: IconButton(
                    onPressed: () => {},
                    icon: Icon(Icons.arrow_drop_down),
                  ),
                  hintStyle: Theme.of(context).textTheme.subtitle2!.copyWith(
                      color: Theme.of(context).colorScheme.fontColor,
                      fontWeight: FontWeight.normal),
                  // filled: true,
                  // fillColor: Theme.of(context).colorScheme.lightWhite,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  prefixIconConstraints: const BoxConstraints(minWidth: 40, maxHeight: 25),
                  // focusedBorder: OutlineInputBorder(
                  //   borderSide: BorderSide(color: Theme.of(context).colorScheme.fontColor),
                  //   borderRadius: BorderRadius.circular(10.0),
                  // ),
                ),
              ),
              onSelected: (String value) {
                controller!.text = value;
              },
              itemBuilder: (BuildContext context) {
                return items!.map<PopupMenuItem<String>>((String value) {
                  return PopupMenuItem(
                      child: Text(
                        value,
                        style: regularBlack14,
                      ),
                      value: value);
                }).toList();
              },
            ),);
  }
}
