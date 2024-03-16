import 'package:app/api/repository/auth/auth.dart';
import 'package:app/models/common_model.dart';
import 'package:app/screen/dashboard/dashboard_screen.dart';
import 'package:app/utility/color.dart';
import 'package:app/utility/constant.dart';

import 'package:app/widgets/app_bar_back.dart';
import 'package:app/widgets/common_button.dart';
import 'package:app/widgets/common_text_field.dart';
import 'package:app/widgets/common_text_field_text.dart';
import 'package:app/widgets/show_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController userCurrentPassword = TextEditingController();
  TextEditingController userNewtPassword = TextEditingController();
  TextEditingController userConfirmNewPassword = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.backGroundColor,
      appBar: customAppBarBack(
        context: context,
        onTap: () {
          Navigator.pop(context);
        },
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * .08,
                ),
                Container(
                  alignment: Alignment.center,
                  child: const Text(
                    "Change Password",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: ColorConstant.organColor),
                  ),
                ),
                const SizedBox(
                  height: 40,
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
                      commonTextFieldText(title: 'Current Password'),
                      CustomTextFormField(
                        controller: userCurrentPassword,
                        hintText: 'Enter Current Password',
                        isObscureText: true,
                        context: context,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      commonTextFieldText(title: 'New Password'),
                      CustomTextFormField(
                        controller: userNewtPassword,
                        isObscureText: true,
                        hintText: 'New Password',
                        context: context,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      commonTextFieldText(title: 'Confirm Password'),
                      CustomTextFormField(
                        controller: userConfirmNewPassword,
                        isObscureText: true,
                        hintText: 'Enter Confirm Password',
                        context: context,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: CommonButton(
                    color: ColorConstant.mainColor,
                    textColor: ColorConstant.white,
                    title: "Change Password",
                    onTap: () {
                      _changePassword();
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

  _changePassword() async {
    if (userCurrentPassword.text.isEmpty) {
      toastShow(message: "Please enter your current password");
      return;
    }
    if (userNewtPassword.text.isEmpty) {
      toastShow(message: "Please enter new password");
      return;
    }
    if (userNewtPassword.text.length < 8) {
      toastShow(message: "New password length must be grater than 8 digit");
      return;
    }
    if (userConfirmNewPassword.text.isEmpty) {
      toastShow(message: "Please enter confirm password");
      return;
    }
    if (userNewtPassword.text.trim() != userConfirmNewPassword.text.trim()) {
      toastShow(message: "New password and confirm password does not match");
      return;
    }
    try {
      setState(() {
        isLoading = true;
      });
      CommonRes response = await AuthRepository().changePasswordApiCall(
        newPassword: userNewtPassword.text.trim(),
        oldPassword: userCurrentPassword.text.trim(),
      );
      if (response.message == "Password has been changed successfully") {
        toastShow(message: response.message);
        Get.to(() => const DashBoardScreen());
      } else {
        toastShow(message: response.message);
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
