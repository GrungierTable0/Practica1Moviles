
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:practica1/screens/counter_screen.dart';
import 'package:practica1/screens/dashboard_screen.dart';
import 'package:practica1/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'package:sqflite/sqflite.dart';


class SplashScreen2 extends StatelessWidget {
  const SplashScreen2({Key? key}): super(key: key);
  
  
  

  @override
  Widget build(BuildContext context) {
    
    return SplashScreenView (
      navigateRoute: DashboardScreen(),
      duration: 3000,
      imageSize: 200,
      imageSrc: "assets/logo.png",
      text: "Practica 1\nJuan Pablo Jaramillo Nieto",
      textType: TextType.ScaleAnimatedText,
      textStyle: TextStyle(
        fontSize: 30.0,
        
      ),
      backgroundColor: Colors.white,
      
    );  

  }
}