import 'package:flutter/material.dart';
import 'package:barts/screens/home.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:page_transition/page_transition.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'consts/colors.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Permission.storage.request();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'barts',
      theme: ThemeData(
        fontFamily: 'rock',
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
        )
      ),
      home:   AnimatedSplashScreen(
          duration: 4500,
          backgroundColor: bgDarkColor ,
          splash: 'assets/images/logo.png',
          nextScreen:  HomeScreen(),
          pageTransitionType: PageTransitionType.rightToLeftWithFade

      ),
    );
  }
}
