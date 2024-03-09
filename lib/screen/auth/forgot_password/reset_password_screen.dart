import 'package:app/screen/auth/login/login_screen.dart';
import 'package:app/utility/color.dart';
import 'package:app/utility/images.dart';
import 'package:app/widgets/common_button.dart';
import 'package:app/widgets/common_text_field.dart';
import 'package:app/widgets/common_text_field_text.dart';
import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.backGroundColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .12,
            ),
            Container(
              alignment: Alignment.center,
              child: const Text(
                "Reset Password",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: ColorConstant.organColor),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 150,
              width: 150,
              child: Image.asset(Images.logo),
            ),
            const SizedBox(
              height: 50,
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
                    height: 15,
                  ),
                  commonTextFieldText(title: 'Password'),
                  CustomTextFormField(
                    hintText: 'Enter password',
                    context: context,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  commonTextFieldText(title: 'Confirm Password'),
                  CustomTextFormField(
                    hintText: 'Enter confirm password',
                    context: context,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: CommonButton(
                color: ColorConstant.mainColor,
                textColor: ColorConstant.white,
                title: "Reset",
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
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
