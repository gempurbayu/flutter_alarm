// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:charts_flutter/flutter.dart' as charts;


import '../clock/clock.dart';
import '../bloc/hour/h_bloc.dart';
import '../bloc/minute/m_bloc.dart';
import '../notification.dart';
import '../charts.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
  bool isOn = false;
  bool isAM = true;
  List<bool> isSelected = List.generate(2, (index) => false);

  String hour = '0';
  String minute = '0';

  @override
  void initState() {
    super.initState();
    Notif.init();
    listenNotification();
    isSelected[0] = true;
  }

  void listenNotification() =>
      Notif.onNotification.stream.listen(onClickNotification);

  void onClickNotification(String? payload) {
    showModalBottomSheet<void>(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: BCharts(
            data: [
              TimeOpen(
                payload,
                DateTime.now().difference(DateTime.parse(payload!)).inSeconds,
                charts.ColorUtil.fromDartColor(
                  Color(0xff65D1BA),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  void showSnackBar() {
    String formattedDate = DateFormat('yyyy-MM-dd  hh:mm a').format(
      setDateTime(),
    );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Alarm active for $formattedDate'),
      ),
    );
  }

  DateTime setDateTime() {
    DateTime now = DateTime.now();
    return DateTime(
        now.year,
        now.month,
        now.hour > (isAM ? int.parse(hour) : int.parse(hour) + 12)
            ? now.day + 1
            : now.hour == (isAM ? int.parse(hour) : int.parse(hour) + 12) &&
                    now.minute >= int.parse(minute) &&
                    now.second > 0
                ? now.day + 1
                : now.day,
        isAM? int.parse(hour) : int.parse(hour) + 12,
        int.parse(minute));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: Size.fromHeight(1),
      child: AppBar(),),
      backgroundColor: Color(0xff001402),
      body: Column(
        children: [
          Padding(padding: const EdgeInsets.only(top: 100),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Stockbit ',
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.w900,
                    fontSize: 40,
                  ),
                ),
                Text(
                  'Alarm',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                  ),
                ),
              ],
            ),
          ),
          Padding(padding: const EdgeInsets.only(top: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BlocBuilder<HourBloc, HourState>(
                  builder: (context, state) {
                    Future.delayed(Duration.zero, () {
                      if (state is LoadedHour) {
                        setState(() {
                          hour = state.hour;
                        });
                      }
                    });
                    return Text(state is LoadedHour ? state.hour : '00',
                      style: TextStyle(
                        fontSize: 54, 
                        fontWeight: FontWeight.bold, 
                        color: isOn ? Colors.green : Colors.white
                      ),
                    );
                  },
                ),
                SizedBox(
                  width: 5,
                ),
                Text(":",
                  style: TextStyle(fontSize: 54, 
                  fontWeight: FontWeight.bold, 
                  color: isOn ? Colors.green : Colors.white),
                ),
                SizedBox(
                  width: 5,
                ),
                BlocBuilder<MinuteBloc, MinuteState>(
                  builder: (context, state) {
                    Future.delayed(Duration.zero, () {
                      if (state is LoadedMinute) {
                        setState(() {
                          minute = state.minute;
                        });
                      }
                    });
                    return Text(state is LoadedMinute ? state.minute : '00',
                      style: TextStyle(
                          fontSize: 54, 
                        fontWeight: FontWeight.bold, 
                        color: isOn ? Colors.green : Colors.white
                      )
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: ToggleButtons(
                    selectedColor: Color(0xff65D1BA),
                    color: Colors.white,
                    children: const [
                      Text(
                        'AM',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'PM',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                    onPressed: (int index) {
                      setState(() {
                        for (int buttonIndex = 0;
                            buttonIndex < isSelected.length;
                            buttonIndex++) {
                          if (buttonIndex == index) {
                            isAM = index == 0 ? true : false;
                            isOn = false;
                            isSelected[buttonIndex] = true;
                          } else {
                            isSelected[buttonIndex] = false;
                          }
                        }
                      });
                    },
                    isSelected: isSelected,
                  ),
                ),
              ],
            ),
          ),
          Clock(),
          Padding(padding: const EdgeInsets.only(top: 60),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center ,
              children: [
                Transform.scale(
                  scale: 1.2,
                  child: FlutterSwitch(
                    value: isOn,
                    activeColor: Color(0xff65D1BA),
                    inactiveColor: Colors.redAccent,
                    showOnOff: true,
                    onToggle: (value) {
                      setState(() {
                        isOn = value;
                        if (isOn) {
                          Notif.showNotificationSchedule(
                              title: 'Alarm App',
                              body: 'Your alarm is active',
                              payload: setDateTime().toString(),
                              scheduleDate: setDateTime());
                          Future.delayed(
                              Duration(
                                  seconds: setDateTime()
                                      .difference(DateTime.now())
                                      .inSeconds), () {
                            isOn = false;
                          });
                          showSnackBar();
                        } else {
                          Notif.cancel();
                        }
                      });
                    }
                  ),
                ),
              ],
            ),  
          ),
        ],
      ),
    );
  }
}