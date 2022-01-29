// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../clock/clock.dart';
import '../bloc/hour/h_bloc.dart';
import '../bloc/minute/m_bloc.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
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
                          Text("Your Alarm is On");
                        } else {
                          Text("Your Alarm is Off");
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