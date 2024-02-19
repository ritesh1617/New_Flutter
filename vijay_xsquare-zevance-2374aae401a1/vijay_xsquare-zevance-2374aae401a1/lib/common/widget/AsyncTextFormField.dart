import 'dart:async';

import 'package:flutter/material.dart';
import 'package:grievance/theme/color.dart';
import 'package:grievance/theme/style.dart';

class AsyncTextFormField extends StatefulWidget {
  final Future<bool> Function(String) validator;
  final Duration validationDebounce;
  final TextEditingController controller;
  final String hintText;
  final String lable;
  final String isValidatingMessage;
  final String valueIsEmptyMessage;
  final String valueIsInvalidMessage;

  const AsyncTextFormField(
      {Key? key,
        required this.validator,
        required this.validationDebounce,
        required this.controller,
        this.isValidatingMessage = "please wait for the validation to complete",
        this.valueIsEmptyMessage = 'please enter a value',
        this.valueIsInvalidMessage = 'please enter a valid value',
        this.hintText = '',
        this.lable = ''
      })
      : super(key: key);

  @override
  _AsyncTextFormFieldState createState() => _AsyncTextFormFieldState();
}

class _AsyncTextFormFieldState extends State<AsyncTextFormField> {
  Timer? _debounce;
  var isValidating = false;
  var isValid = false;
  var isDirty = false;
  var isWaiting = false;
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
          (widget.lable != "")
              ? Text(
            widget.lable,
            style: regularGray14,
          )
              : Container(),
          (widget.lable != "")
              ? const SizedBox(
            height: 5,
          )
              : Container(),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            // validator: (value) {
            //   if (isValidating) {
            //     return widget.isValidatingMessage;
            //   }
            //   if (value?.isEmpty ?? false) {
            //     return widget.valueIsEmptyMessage;
            //   }
            //   if (!isWaiting && !isValid) {
            //     return widget.valueIsInvalidMessage;
            //   }
            //   return null;
            // },
            onChanged: (text) async {
              isDirty = true;
              if (text.isEmpty) {
                setState(() {
                  isValid = false;
                  print('is empty');
                });
                cancelTimer();
                return;
              }
              isWaiting = true;
              cancelTimer();
              _debounce = Timer(widget.validationDebounce, () async {
                isWaiting = false;
                isValid = await validate(text);
                print(isValid);
                setState((){

                });
                isValidating = false;
              });
            },
            textAlign: TextAlign.start,
            controller: widget.controller,
            maxLines: 1,
            textInputAction: TextInputAction.next,
            style: const TextStyle(
                color: colors.blackTemp,
                fontSize: 14.0,
                fontWeight: FontWeight.normal),
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
              hintText: widget.hintText,
              hintStyle: Theme.of(context).textTheme.subtitle2!.copyWith(
                  color: Colors.grey, fontWeight: FontWeight.normal),
              // filled: true,
              // fillColor: Theme.of(context).colorScheme.lightWhite,
              contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20, vertical: 5),
              prefixIconConstraints:
              const BoxConstraints(minWidth: 40, maxHeight: 25), suffix: SizedBox(height: 20, width: 20, child: _getSuffixIcon())
              // focusedBorder: OutlineInputBorder(
              //   borderSide: BorderSide(color: Theme.of(context).colorScheme.fontColor),
              //   borderRadius: BorderRadius.circular(10.0),
              // ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  void cancelTimer() {
    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
    }
  }

  Future<bool> validate(String text) async {
    setState(() {
      isValidating = true;
    });
    final isValid = await widget.validator(text);
    isValidating = false;
    return isValid;
  }

  Widget _getSuffixIcon() {
    if (isValidating) {
      return const CircularProgressIndicator(
        strokeWidth: 2.0,
        valueColor: AlwaysStoppedAnimation(colors.secondary),
      );
    } else {
      if (!isValid && isDirty) {
        return const Icon(
          Icons.cancel,
          color: Colors.red,
          size: 20,
        );
      } else if (isValid) {
        return const Icon(
          Icons.check_circle,
          color: Colors.green,
          size: 20,
        );
      } else {
        return Container();
      }
    }
  }
}