import 'dart:convert';
import 'dart:io';

import 'package:app/api/repository/auth.dart';
import 'package:app/models/user/user_model.dart';
import 'package:app/screen/auth/login/login_screen.dart';
import 'package:app/screen/dashboard/dashborad_screen.dart';
import 'package:app/utility/color.dart';
import 'package:app/utility/constant.dart';
import 'package:app/utility/images.dart';
import 'package:app/widgets/common_button.dart';
import 'package:app/widgets/common_text_field.dart';
import 'package:app/widgets/common_text_field_text.dart';
import 'package:app/widgets/show_progress_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  bool passwordVisibility = true;
  bool isLoading = false;
  final ImagePicker _picker = ImagePicker();

  File? userImage;
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
                  height: MediaQuery.of(context).size.height * .08,
                ),
                Container(
                  alignment: Alignment.center,
                  child: const Text(
                    "Signup",
                    style: TextStyle(
                        fontSize: 20,
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
                      Container(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                imagePickerPopUp();
                              },
                              child: SizedBox(
                                height: 75,
                                width: 75,
                                child: Stack(
                                  children: [
                                    userImage != null
                                        ? Container(
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  width: 1,
                                                  color:
                                                      ColorConstant.greyColor),
                                              image: DecorationImage(
                                                  image: FileImage(userImage!),
                                                  fit: BoxFit.cover),
                                            ),
                                          )
                                        : Container(
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  width: 1,
                                                  color:
                                                      ColorConstant.greyColor),
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
                        controller: userNameController,
                        context: context,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      commonTextFieldText(title: 'Email'),
                      CustomTextFormField(
                        controller: emailController,
                        hintText: 'Enter your email',
                        context: context,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      commonTextFieldText(title: 'Password'),
                      CustomTextFormField(
                        hintText: 'Enter your Password',
                        controller: passwordController,
                        context: context,
                        isObscureText: passwordVisibility,
                        // suffix: GestureDetector(
                        //   onTap: () {
                        //     setState(() {
                        //       passwordVisibility = !passwordVisibility;
                        //     });
                        //   },
                        //   child: Icon(
                        //     passwordVisibility
                        //         ? Icons.visibility_off
                        //         : Icons.remove_red_eye,
                        //     size: 17,
                        //   ),
                        // ),
                      ),
                      // const SizedBox(
                      //   height: 17,
                      // ),
                      commonTextFieldText(title: 'Your Bio'),
                      CustomTextFormField(
                        controller: bioController,
                        hintText: 'User Bio',
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
                    title: "Signup",
                    onTap: () {
                      _userRegister();
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
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
                  height: 20,
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
                        CupertinoPageRoute(
                          builder: (context) => const LoginScreen(),
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

  void imagePickerPopUp() async {
    return showDialog(
      context: context,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shape: const RoundedRectangleBorder(
                side: BorderSide(color: ColorConstant.greyColor),
                borderRadius: BorderRadius.all(
                  Radius.circular(15.0),
                ),
              ),
              elevation: 0,
              backgroundColor: ColorConstant.white,
              actionsPadding: const EdgeInsets.symmetric(vertical: 0),
              title: Container(
                alignment: Alignment.topLeft,
                decoration: BoxDecoration(
                    color: ColorConstant.white,
                    borderRadius: BorderRadius.circular(15)),
                // height: MediaQuery.of(context).size.height * .25,
                width: MediaQuery.of(context).size.width * .7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Upload Profile Image',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: ColorConstant.black,
                        fontSize: 18,
                        fontFamily: 'inter',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop(false);
                            imageFromGallery();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: ColorConstant.mainColor,
                                borderRadius: BorderRadius.circular(8)),
                            height: 35,
                            width: MediaQuery.of(context).size.width * .2,
                            alignment: Alignment.center,
                            child: const Text(
                              'Gallery',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: ColorConstant.white),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop(false);
                            imageFromCamera();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: ColorConstant.mainColor,
                                borderRadius: BorderRadius.circular(8)),
                            height: 35,
                            width: MediaQuery.of(context).size.width * .2,
                            alignment: Alignment.center,
                            child: const Text(
                              'Camera',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: ColorConstant.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  imageFromCamera() async {
    try {
      final XFile? result =
          await _picker.pickImage(source: ImageSource.camera, imageQuality: 75);
      if (result != null) {
        userImage = File(result.path);
        setState(() {});
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  imageFromGallery() async {
    try {
      final XFile? result = await _picker.pickImage(
          source: ImageSource.gallery, imageQuality: 75);
      if (result != null) {
        userImage = File(result.path);
        setState(() {});
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  _userRegister() async {
    if (userImage == null) {
      toastShow(message: "Please upload user image");
      return;
    }
    if (userNameController.text.isEmpty) {
      toastShow(message: "Please enter your full name");
      return;
    }
    if (emailController.text.isEmpty) {
      toastShow(message: "Please enter your email");
    }
    if (passwordController.text.isEmpty) {
      toastShow(message: "Please enter your password");
    }
    if (bioController.text.isEmpty) {
      toastShow(message: "Please enter your bio");
    }
    try {
      setState(() {
        isLoading = true;
      });
      UserRes response = await AuthRepository().userRegisterApiCall(
        bio: bioController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        userImage: userImage,
        userName: userNameController.text.trim(),
      );
      if (response.success == true) {
        AppConstant.bearerToken = response.data!.token!;
        AppConstant.userData = response.data;
        response.data!.userEmail = emailController.text.trim();
        response.data!.userBio = bioController.text.trim();
        await AppConstant.userDetailSaved(json.encode(response));
        toastShow(message: response.message);
        Get.to(() => const DashBoardScreen());
      } else {
        toastShow(message: "Email already exists");
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
