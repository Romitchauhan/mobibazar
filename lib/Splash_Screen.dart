import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobibazar/routes.dart';
import 'package:velocity_x/velocity_x.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      // Navigate to the main screen
      VxNavigator.of(context).push(Uri.parse(MyRoutes.homeRoute));
    });
  }


  @override
  Widget build(BuildContext context) {
    // Build your splash screen UI here
    return Scaffold(
      body: Center(
        child: "Mobi Bazar".text.xl2.bold.color(context.theme.accentColor).make()
        ),
      );
  }
}
