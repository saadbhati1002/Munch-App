import 'dart:convert';

import 'package:app/api/repository/auth/auth.dart';
import 'package:app/models/user/user_model.dart';
import 'package:app/screen/auth/forgot_password/forgot_password_screen.dart';
import 'package:app/screen/auth/signup/signup_screen.dart';
import 'package:app/screen/dashboard/dashboard_screen.dart';
import 'package:app/utility/color.dart';
import 'package:app/utility/constant.dart';
import 'package:app/utility/images.dart';
import 'package:app/widgets/common_button.dart';
import 'package:app/widgets/common_text_field.dart';
import 'package:app/widgets/common_text_field_text.dart';
import 'package:app/widgets/show_progress_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isPassword = true;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.backGroundColor,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * .06,
                ),
                Container(
                  alignment: Alignment.center,
                  child: const Text(
                    "Login",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: ColorConstant.organColor),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .02,
                ),
                SizedBox(
                  height: 150,
                  width: 150,
                  child: Image.asset(Images.logo),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .02,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: ColorConstant.white,
                      borderRadius: BorderRadius.circular(10)),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 13, vertical: 15),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 0),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      commonTextFieldText(title: 'Email'),
                      CustomTextFormFieldNormal(
                        controller: emailController,
                        hintText: 'User Email',
                        context: context,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      commonTextFieldText(title: 'Password'),
                      CustomTextFormFieldNormal(
                        controller: passwordController,
                        isObscureText: isPassword,
                        isPassword: true,
                        hintText: 'User Password',
                        suffix: GestureDetector(
                          onTap: () {
                            setState(() {
                              isPassword = !isPassword;
                            });
                          },
                          child: Icon(
                            isPassword
                                ? Icons.remove_red_eye
                                : Icons.visibility_off,
                          ),
                        ),
                        context: context,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ForgotPasswordScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      "Forgot Password?",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: ColorConstant.greyDarkColor),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 35,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: CommonButton(
                    color: ColorConstant.mainColor,
                    textColor: ColorConstant.white,
                    title: "Login",
                    onTap: () {
                      _userLogin();
                    },
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Container(
                  alignment: Alignment.center,
                  child: const Text(
                    "OR",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: ColorConstant.greyDarkColor),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: CommonButton(
                    color: ColorConstant.white,
                    textColor: ColorConstant.black,
                    title: "Signup",
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => const SignupScreen(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          isLoading ? const ShowProgressBar() : const SizedBox()
        ],
      ),
    );
  }

  _userLogin() async {
    if (emailController.text.isEmpty) {
      toastShow(message: "Please enter your email");
    }
    if (passwordController.text.isEmpty) {
      toastShow(message: "Please enter your password");
    }
    try {
      setState(() {
        isLoading = true;
      });
      FocusManager.instance.primaryFocus?.unfocus();
      UserRes response = await AuthRepository().userLoginApiCall(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      if (response.success == true) {
        AppConstant.bearerToken = response.data!.token!;
        response.data!.userEmail = emailController.text.trim();
        AppConstant.userData = response.data;
        await AppConstant.userDetailSaved(json.encode(response.data));
        toastShow(message: response.message);
        if (AppConstant.userData!.latestPlanName != null) {
          try {
            DateTime subscriptionDate = DateTime.parse(
                AppConstant.userData!.latestPlanName!.createdAt ??
                    DateTime.now().toString());
            subscriptionDate = subscriptionDate.add(
              Duration(
                days: int.parse(
                    AppConstant.userData!.latestPlanName!.plan!.days ?? "0"),
              ),
            );

            if (DateTime.now().isBefore(subscriptionDate)) {
              AppConstant.userData!.isPremiumUser = true;
            }
          } catch (e) {
            debugPrint(e.toString());
          }
        }
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.leftToRight,
            duration: Duration(milliseconds: AppConstant.pageAnimationDuration),
            child: const DashBoardScreen(),
          ),
        );
      } else {
        toastShow(message: "Invalid email or password");
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
