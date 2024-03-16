import 'dart:convert';
import 'dart:io';

import 'package:app/api/repository/auth/auth.dart';
import 'package:app/models/user/user_model.dart';
import 'package:app/screen/dashboard/dashboard_screen.dart';
import 'package:app/utility/color.dart';
import 'package:app/utility/constant.dart';
import 'package:app/widgets/app_bar_back.dart';
import 'package:app/widgets/common_button.dart';
import 'package:app/widgets/common_text_field.dart';
import 'package:app/widgets/common_text_field_text.dart';
import 'package:app/widgets/custom_image_view_circular.dart';
import 'package:app/widgets/show_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  bool isLoading = false;
  TextEditingController userNameController = TextEditingController();
  TextEditingController userDateOfBirthController = TextEditingController();
  TextEditingController userPhoneNumberController = TextEditingController();
  TextEditingController userAddressController = TextEditingController();
  TextEditingController userBioController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  File? userImage;
  @override
  void initState() {
    _checkUserData();
    super.initState();
  }

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
                  height: MediaQuery.of(context).size.height * .03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        imagePickerPopUp();
                      },
                      child: SizedBox(
                        height: 120,
                        width: 120,
                        child: Stack(
                          children: [
                            userImage == null
                                ? CustomImageCircular(
                                    imagePath: AppConstant.userData!.image,
                                    height: 120,
                                    width: 120,
                                  )
                                : Container(
                                    height: 120,
                                    width: 120,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: FileImage(userImage!),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                height: 35,
                                width: 35,
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: ColorConstant.white),
                                child: const Icon(
                                  Icons.camera_alt,
                                  size: 25,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .03,
                ),
                Container(
                  color: ColorConstant.white,
                  width: MediaQuery.of(context).size.width,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      commonTextFieldText(title: 'Full Name'),
                      CustomTextFormField(
                        hintText: 'Your Name',
                        controller: userNameController,
                        context: context,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      commonTextFieldText(title: 'Phone Number'),
                      CustomTextFormField(
                        hintText: 'Your Phone Number',
                        controller: userPhoneNumberController,
                        context: context,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      commonTextFieldText(title: 'Date of Birth'),
                      CustomTextFormField(
                        onTap: () {
                          _selectDate(context);
                        },
                        hintText: 'Your Date of Birth',
                        controller: userDateOfBirthController,
                        context: context,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      commonTextFieldText(title: 'Address'),
                      CustomTextFormField(
                        hintText: 'Your Address',
                        controller: userAddressController,
                        context: context,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      commonTextFieldText(title: 'Bio'),
                      CustomTextFormField(
                        hintText: 'Your Bio',
                        controller: userBioController,
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
                    title: "Update",
                    onTap: () {
                      _updateUserProfile();
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

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    FocusManager.instance.primaryFocus?.unfocus();

    if (picked != null) {
      userDateOfBirthController.text = DateFormat('yyyy-MM-dd').format(picked);
      setState(() {});
    }
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
                      'update Profile Image',
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

  _checkUserData() {
    if (AppConstant.userData != null) {
      if (AppConstant.userData!.name != null &&
          AppConstant.userData!.name != "null" &&
          AppConstant.userData!.name != "") {
        userNameController.text = AppConstant.userData!.name!;
      }
      if (AppConstant.userData!.phoneNumber != null &&
          AppConstant.userData!.phoneNumber != "null" &&
          AppConstant.userData!.phoneNumber != "") {
        userPhoneNumberController.text = AppConstant.userData!.phoneNumber!;
      }
      if (AppConstant.userData!.userBio != null &&
          AppConstant.userData!.userBio != "null" &&
          AppConstant.userData!.userBio != "") {
        userBioController.text = AppConstant.userData!.userBio!;
      }
      if (AppConstant.userData!.dateOfBirth != null &&
          AppConstant.userData!.dateOfBirth != "null" &&
          AppConstant.userData!.dateOfBirth != "") {
        userDateOfBirthController.text = AppConstant.userData!.dateOfBirth!;
      }
      if (AppConstant.userData!.address != null &&
          AppConstant.userData!.address != "null" &&
          AppConstant.userData!.address != "") {
        userAddressController.text = AppConstant.userData!.address!;
      }
      setState(() {});
    }
  }

  Future _updateUserProfile() async {
    if (AppConstant.userData!.image == null &&
        AppConstant.userData!.image == "" &&
        AppConstant.userData!.image == "null") {
      if (userImage == null) {
        toastShow(message: "Please upload your image");
        return;
      }
    }

    if (userNameController.text.isEmpty) {
      toastShow(message: "Please enter your name");
      return;
    }
    if (userPhoneNumberController.text.isEmpty) {
      toastShow(message: "Please enter your phone number");
      return;
    }
    if (userDateOfBirthController.text.isEmpty) {
      toastShow(message: "Please enter your date of birth");
      return;
    }
    if (userBioController.text.isEmpty) {
      toastShow(message: "Please enter your bio");
      return;
    }
    try {
      setState(() {
        isLoading = true;
      });
      UserRes response = await AuthRepository().userProfileUpdateApiCall(
        address: userAddressController.text.trim(),
        bio: userBioController.text.trim(),
        dateOfBirth: userDateOfBirthController.text.trim(),
        phoneNumber: userPhoneNumberController.text.trim(),
        userImage: userImage,
        userName: userNameController.text.trim(),
      );
      if (response.success == true) {
        toastShow(message: response.message);
        AppConstant.userData!.address = response.data!.address!;
        AppConstant.userData!.image = response.data!.image!;
        AppConstant.userData!.phoneNumber = response.data!.phoneNumber!;
        AppConstant.userData!.name = response.data!.name!;
        AppConstant.userData!.dateOfBirth = response.data!.dateOfBirth!;
        AppConstant.userData!.userBio = response.data!.userBio!;
        response.data = AppConstant.userData!;
        await AppConstant.userDetailSaved(json.encode(response));
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
