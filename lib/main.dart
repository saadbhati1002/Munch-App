import 'package:app/screen/splash/splash_screen.dart';
import 'package:app/utility/color.dart';
import 'package:app/utility/constant.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppConstant.appName,
      theme: ThemeData(
        fontFamily: "rubik",
        colorScheme:
            ColorScheme.fromSeed(seedColor: ColorConstant.backGroundColor),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
