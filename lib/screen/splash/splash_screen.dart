import 'dart:convert';

import 'package:app/models/user/user_model.dart';
import 'package:app/screen/auth/login/login_screen.dart';
import 'package:app/screen/dashboard/dashboard_screen.dart';
import 'package:app/utility/color.dart';
import 'package:app/utility/constant.dart';
import 'package:app/utility/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2)).then((value) {
      _navigation();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    });
    super.initState();
  }

  _navigation() async {
    var response = await AppConstant.getUserDetail();
    if (response != null && response != "null") {
      UserRes responseUser = UserRes.fromJson(jsonDecode(response));
      AppConstant.userData = responseUser.data;
      AppConstant.bearerToken = responseUser.data!.token!;
      Get.to(() => const DashBoardScreen());
    } else {
      Get.to(() => const LoginScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.backGroundColor,
      body: Center(
        child: Image.asset(Images.logo),
      ),
    );
  }
}
