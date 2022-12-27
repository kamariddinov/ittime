import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ittime/Pages/HomePage.dart';
import 'Constants/Constants.dart';
import 'Data/Data.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  String page = lates_url;
  void initState() {
    getConent(page);
    Timer.periodic(const Duration(seconds: 10), (timer) => getConent(page));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IT Time',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const MainPage(),
    );
  }
}
