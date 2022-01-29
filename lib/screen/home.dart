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
              )
              ],
          ),
            
          ),
        ],
      ),
    );
  }
}