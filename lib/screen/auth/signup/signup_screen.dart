import 'package:app/screen/auth/login/login_screen.dart';
import 'package:app/utility/color.dart';
import 'package:app/utility/images.dart';
import 'package:app/widgets/common_button.dart';
import 'package:app/widgets/common_text_field.dart';
import 'package:app/widgets/common_text_field_text.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.backGroundColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .1,
            ),
            Container(
              alignment: Alignment.center,
              child: const Text(
                "Signup",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: ColorConstant.organColor),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              decoration: BoxDecoration(
                  color: ColorConstant.white,
                  borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 15),
              margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 0),
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 60,
                          width: 60,
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      width: 1, color: ColorConstant.greyColor),
                                  image: const DecorationImage(
                                    image: AssetImage(Images.logo),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Container(
                                  height: 28,
                                  width: 28,
                                  alignment: Alignment.center,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: ColorConstant.white),
                                  child: const Icon(
                                    Icons.camera_alt,
                                    size: 20,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        commonTextFieldText(title: 'Add profile picture'),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  commonTextFieldText(title: 'Full Name'),
                  CustomTextFormField(
                    hintText: 'Enter your full name',
                    context: context,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  commonTextFieldText(title: 'Email'),
                  CustomTextFormField(
                    hintText: 'Enter your email',
                    context: context,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  commonTextFieldText(title: 'Password'),
                  CustomTextFormField(
                    // isObscureText: isPassword,
                    hintText: 'Enter your bio',
                    context: context,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  commonTextFieldText(title: 'Your Bio'),
                  CustomTextFormField(
                    hintText: 'User Email',
                    context: context,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: CommonButton(
                color: ColorConstant.mainColor,
                textColor: ColorConstant.white,
                title: "Signup",
                onTap: () {},
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
                title: "Login",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
