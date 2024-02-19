import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../theme/color.dart';
import '../../theme/style.dart';


class CTextFieldPass extends StatefulWidget {
  String? hintText = "";
  String? lable;
  TextEditingController? controller = new TextEditingController();
  TextInputType? keyboardType = TextInputType.text;
  TextInputFormatter? inputFormatters;
  double margin = 20.0;
  bool readOnly = false;
  Function? onPressed=()=>{};
  FocusNode _focus = new FocusNode();
  IconData? icon;

  CTextFieldPass(
      {this.hintText,
        this.lable,
        this.controller,
        this.keyboardType,
        this.inputFormatters,
        this.margin = 20.0,
        this.readOnly=false,
        this.onPressed,this.icon});

  @override
  _CTextFieldState createState() => _CTextFieldState();
}

class _CTextFieldState extends State<CTextFieldPass> {

  bool _obscureTextoldpswd=true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(
        top: 10.0,
        start: 25.0,
        end: 25.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.lable!,style: regularGray14,),
          const SizedBox(height: 5,),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            controller: widget.controller,
            focusNode: widget._focus,
            obscureText: _obscureTextoldpswd,
            cursorColor: colors.primary,
            textCapitalization: TextCapitalization.sentences,
            style: const TextStyle(
                color: colors.blackTemp,
                fontSize: 14.0,
                fontWeight: FontWeight.normal),
            decoration: InputDecoration(
              fillColor: colors.whiteTemp,
              contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              enabledBorder: OutlineInputBorder(
                borderSide:  BorderSide(color: colors.grayLight, width: 1.0),
                borderRadius: BorderRadius.circular(10.0),
              ),
              focusedBorder:OutlineInputBorder(
                borderSide:  BorderSide(color: colors.grayLight, width: 1.0),
                borderRadius: BorderRadius.circular(10.0),
              ),
              filled: true,
              prefixIcon:(widget.icon!=null)? Icon(
                (widget.icon==null)?Icons.alternate_email_outlined : widget.icon!,
                color: Theme.of(context).colorScheme.fontColor,
                size: 17,
              ):null,
              hintText: widget.hintText,
              hintStyle: Theme.of(context).textTheme.subtitle2!.copyWith(
                  color: Colors.grey,
                  fontWeight: FontWeight.normal),
              // filled: true,
              // fillColor: Theme.of(context).colorScheme.lightWhite,

              prefixIconConstraints: const BoxConstraints(minWidth: 40, maxHeight: 25),
              // focusedBorder: OutlineInputBorder(
              //   borderSide: BorderSide(color: Theme.of(context).colorScheme.fontColor),
              //   borderRadius: BorderRadius.circular(10.0),
              // ),
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    _obscureTextoldpswd = !_obscureTextoldpswd;
                  });
                },
                child: Icon(
                  _obscureTextoldpswd
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: Colors.black12,
                  semanticLabel: _obscureTextoldpswd
                      ? 'show password'
                      : 'hide password',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

