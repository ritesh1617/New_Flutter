import 'package:flutter/material.dart';
import 'package:grievance/model/Grievance.dart';
import 'package:grievance/theme/color.dart';
import 'package:grievance/theme/string.dart';
import 'package:grievance/theme/style.dart';
import 'package:grievance/utils/constants.dart';

class CardAudioWidget extends StatelessWidget {
  Grievance? model;

  CardAudioWidget({Key? key, required Grievance model}) : super(key: key) {
    this.model = model;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        Text(
          "${model!.title}",
          style: regularBlack12,
        ),
        Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 50,
                height: 50,
                margin: const EdgeInsets.only(top: 10),
                child: const Icon(
                  Icons.play_arrow_rounded,
                  size: 25,
                  color: colors.whiteTemp,
                ),
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                        colors: [colors.firstColor, colors.secondColor])),
              ),
              Expanded(
                  child: Column(
                children: [
                  Slider(
                    min: 0,
                    max: 100,
                    value: 20,
                    thumbColor: colors.primary,
                    activeColor: colors.primary,
                    inactiveColor: colors.primaryLight,
                    onChanged: (value) {
                      // setState(() {
                      //   _value = value;
                      // });
                    },
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 25, right: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "00:00",
                          style: regularGray12,
                        ),
                        Text(
                          "30:00",
                          style: regularGray12,
                        )
                      ],
                    ),
                  )
                ],
              ))
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
