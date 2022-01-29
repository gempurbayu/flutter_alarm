// ignore_for_file: prefer_const_constructors
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './bloc/hour/h_bloc.dart';
import './bloc/minute/m_bloc.dart';
import './screen/home.dart';

void main() {
  runApp(MultiBlocProvider(providers: [
    BlocProvider<HourBloc>(
      create: (context) => HourBloc(),
    ),
    BlocProvider<MinuteBloc>(
      create: (context) => MinuteBloc(),
    ),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Stock Bit Alarm',
      theme: ThemeData(
          primarySwatch: Colors.green,
          visualDensity: VisualDensity.adaptivePlatformDensity),
      home: Home(),
    );
  }
}