import 'package:app/screen/auth/forgot_password/reset_password_screen.dart';
import 'package:app/utility/color.dart';
import 'package:app/utility/images.dart';
import 'package:app/widgets/common_button.dart';
import 'package:app/widgets/common_text_field_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class VerifyOTPScreen extends StatefulWidget {
  const VerifyOTPScreen({super.key});

  @override
  State<VerifyOTPScreen> createState() => _VerifyOTPScreenState();
}

class _VerifyOTPScreenState extends State<VerifyOTPScreen> {
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
                "Verify OTP",
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
                    height: 20,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: commonTextFieldText(
                        title:
                            'We send otp on your register emil address testXXX@gmail.com'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  OtpTextField(
                    numberOfFields: 5,
                    borderColor: ColorConstant.mainColor,

                    showFieldAsBox: true,

                    onCodeChanged: (String code) {},

                    onSubmit: (String verificationCode) {}, // end onSubmit
                  ),
                  const SizedBox(
                    height: 20,
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
                title: "Verify OTP",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ResetPasswordScreen(),
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
