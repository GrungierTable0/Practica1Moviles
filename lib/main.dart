/*
import 'package:flutter/material.dart';
import 'package:practica1/provider/theme_provider.dart';
import 'package:practica1/screens/dashboard_screen.dart';
import 'package:practica1/screens/list_task_screen.dart';
import 'package:practica1/screens/login_screen.dart';
import 'package:practica1/screens/profile_screen.dart';
import 'package:practica1/screens/splash_sceen2.dart';
import 'package:practica1/screens/splash_screen.dart';
import 'package:practica1/screens/task_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

  Future<void> main() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var keepLogin = prefs.getBool('keepLogin');
    //ThemeProvider tema = Provider.of<ThemeProvider>(context);
    print(keepLogin);
    runApp(
      MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ProfileScreen(),
        
        //home: keepLogin == true ? SplashScreen2() : SplashScreen(),
        routes: {
          '/dash' : (BuildContext context) => DashboardScreen(),
          '/login' : (BuildContext context) => LoginScreen(),
          '/task' : (BuildContext context) => ListTaskScreen(),
          '/add' : (BuildContext context) => TaskScreen(),
        }
      )
    );
  }

class PMSNApp extends StatelessWidget {
  const PMSNApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
    );
  }
}*/
import 'package:flutter/material.dart';
import 'package:practica1/provider/theme_provider.dart';
import 'package:practica1/screens/dashboard_screen.dart';
import 'package:practica1/screens/list_popular_screen.dart';
import 'package:practica1/screens/list_task_screen.dart';
import 'package:practica1/screens/login_screen.dart';
import 'package:practica1/screens/popular_detail_screen.dart';
import 'package:practica1/screens/profile_screen.dart';
import 'package:practica1/screens/splash_screen.dart';
import 'package:practica1/screens/task_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(), child: PMSNApp()
    );
  }
}

class PMSNApp extends StatelessWidget {
  const PMSNApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeProvider tema = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: 'Practica1',
      theme: tema.getthemeData(),
      home:  DashboardScreen(),
      routes: {
        '/dash': (BuildContext context) => DashboardScreen(),
        '/login': (BuildContext context) => LoginScreen(),
        '/task': (BuildContext context) => ListTaskScreen(),
        '/add': (BuildContext context) => TaskScreen(),
        '/list': (BuildContext context) => ListPopularScreen(),
        '/detail': (BuildContext context) => PopularDetailScreen(),
        '/profile': (BuildContext context) => ProfileScreen(),
        
      },
    );
  }
}

