
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:musicapp/const/colors.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';


class song_volume_updown extends StatefulWidget {
  const song_volume_updown({Key? key}) : super(key: key);

  @override
  State<song_volume_updown> createState() => _song_volume_updownState();
}

class _song_volume_updownState extends State<song_volume_updown> {
 
 var value=30.0;
  @override
  Widget build(BuildContext context) {
    return SfRadialGauge(
      animationDuration: 1,
      enableLoadingAnimation: true,
      axes: [
        RadialAxis(
          useRangeColorForAxis: true,
          startAngle: 0,
          endAngle: 180,
          canRotateLabels:false,
          interval: 10,
          isInversed: true,
          maximum: 100,
          minimum: 0,
          showAxisLine: true,
          showLabels: false,
          showTicks: false,
          ranges: [
            GaugeRange(
              startValue: 0,
               endValue: value,
               color: primarycolor,
               )
          ],
          pointers: [
            MarkerPointer(
              color: primarycolor,
              borderWidth: 20,
              value: value,
              onValueChanged: (valuee) {
                setState(() {
                  value=valuee;
                });
              },
              enableAnimation: true,
              enableDragging: true,
              markerType: MarkerType.circle,
              markerHeight: 30,
              markerWidth: 30,
            ),
          ],
          annotations: [
            GaugeAnnotation(
              horizontalAlignment: GaugeAlignment.center,
              angle: 30,
              positionFactor: 0.02,
              widget: Container(
                width: 280,
                height: 280,
                decoration: BoxDecoration(
                  color: divcolor,
                  borderRadius: BorderRadius.circular(1000),
                  image: DecorationImage(image: AssetImage("assets/a2.jpg"),fit: BoxFit.cover),
                ),
              ))
          ],
        )
      ],
    );
  }
}