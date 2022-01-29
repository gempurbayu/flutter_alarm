import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
  bool isOn = false;
  bool isAM = true;
  List<bool> isSelected = List.generate(2, (index) => false);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: isOn ? Colors.green : Colors.white,
        centerTitle: true,
        title: Text(
          'Stockbit Alarm',
          style: TextStyle(
            color: isOn ? Color(0xffffffff) : Colors.green,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(padding: const EdgeInsets.only(top: 80),
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
          Padding(padding: const EdgeInsets.only(top: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("00",
                style: TextStyle(
                        fontSize: 54, 
                        fontWeight: FontWeight.bold, 
                        color: isOn ? Colors.green : Colors.black)
                ),
                SizedBox(
                  width: 5,
                ),
                Text(":",
                  style: TextStyle(fontSize: 54, 
                  fontWeight: FontWeight.bold, 
                  color: isOn ? Colors.green : Colors.black),
                ),
                SizedBox(
                  width: 5,
                ),
                Text("00",
                style: TextStyle(
                        fontSize: 54, 
                        fontWeight: FontWeight.bold, 
                        color: isOn ? Colors.green : Colors.black)
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: ToggleButtons(
                    selectedColor: Color(0xff65D1BA),
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
        ],
      ),
    );
  }
}