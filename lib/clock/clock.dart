// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_alarm_gempur/clock/hand_minute.dart';

import 'clock_painter.dart';
import 'hand_hour.dart';

class Clock extends StatefulWidget {
  const Clock({Key? key}) : super(key: key);

  @override
  _ClockState createState() => _ClockState();
}

class _ClockState extends State<Clock> with TickerProviderStateMixin {
  double wheelSize = 300;
  final double longNeedleHeight = 40;
  final double shortNeedleHeight = 25;

  @override
  Widget build(BuildContext context) {
    ClockPainter clockPainter = ClockPainter(
        wheelSize: wheelSize,
        longNeedleHeight: longNeedleHeight,
        shortNeedleHeight: shortNeedleHeight,
        context: context);

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
          ),
        ),
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: wheelSize,
              height: wheelSize,
              child: Container(
                  color: Colors.transparent,
                  child: Center(child: CustomPaint(painter: clockPainter))),
            ),
            Container(
              width: wheelSize,
              height: wheelSize,
              color: Colors.transparent,
              child: Center(
                child: Container(
                  width: 15,
                  height: 15,
                  decoration: BoxDecoration(
                      color: Color(0xffffffff),
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
            MinuteHand(),
            HourHand(),
          ],
        )
      ],
    );
  }
}