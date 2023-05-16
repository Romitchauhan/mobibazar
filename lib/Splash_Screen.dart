import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobibazar/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushNamedAndRemoveUntil(
        context,
        MyRoutes.homeRoute,
            (Route<dynamic> route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Mobi Bazar',
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}
