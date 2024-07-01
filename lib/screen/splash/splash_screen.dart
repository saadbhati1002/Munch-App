import 'dart:convert';
import 'package:app/models/user/user_model.dart';
import 'package:app/screen/auth/login/login_screen.dart';
import 'package:app/screen/dashboard/dashboard_screen.dart';
import 'package:app/utility/color.dart';
import 'package:app/utility/constant.dart';
import 'package:app/utility/images.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

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
    });
    super.initState();
  }

  _navigation() async {
    var response = await AppConstant.getUserDetail();
    if (response != null && response != "null") {
      UserRes responseUser = UserRes.fromJson(jsonDecode(response));
      AppConstant.userData = responseUser.data;
      AppConstant.bearerToken = responseUser.data?.token ?? "";
      Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.leftToRight,
          duration: Duration(milliseconds: AppConstant.pageAnimationDuration),
          child: DashBoardScreen(),
        ),
      );
    } else {
      Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.rightToLeft,
          duration: Duration(milliseconds: AppConstant.pageAnimationDuration),
          child: LoginScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.mainColor,
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * .75,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            height: MediaQuery.of(context).size.height * .3,
            width: MediaQuery.of(context).size.width * .6,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
                color: ColorConstant.white, shape: BoxShape.circle),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * .27,
                width: MediaQuery.of(context).size.width * .56,
                child: Image.asset(Images.logo),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
