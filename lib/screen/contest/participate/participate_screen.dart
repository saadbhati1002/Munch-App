import 'dart:io';

import 'package:app/api/repository/contest/contest.dart';
import 'package:app/models/common_model.dart';
import 'package:app/utility/color.dart';
import 'package:app/utility/constant.dart';
import 'package:app/widgets/app_bar_back.dart';
import 'package:app/widgets/common_button.dart';
import 'package:app/widgets/search_text_field.dart';
import 'package:app/widgets/show_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ParticipateScreen extends StatefulWidget {
  final String? contestID;
  const ParticipateScreen({super.key, this.contestID});

  @override
  State<ParticipateScreen> createState() => _ParticipateScreenState();
}

class _ParticipateScreenState extends State<ParticipateScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? imageSelected;
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
                const SizedBox(
                  height: 30,
                ),
                Container(
                  alignment: Alignment.center,
                  child: const Text(
                    'Add Participation',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: ColorConstant.mainColor,
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: CustomSearchTextField(
                    controller: titleController,
                    context: context,
                    borderRadius: 10,
                    hintText: "Write the title",
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: CustomSearchTextField(
                    controller: descriptionController,
                    context: context,
                    borderRadius: 10,
                    isMaxLine: true,
                    hintText: "Write the description",
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () {
                    imagePickerPopUp();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: imageSelected == null
                        ? Container(
                            height: 140,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: ColorConstant.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            alignment: Alignment.center,
                            child: const Icon(
                              Icons.image,
                              size: 45,
                              color: ColorConstant.greyDarkColor,
                            ),
                          )
                        : Container(
                            height: 140,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: ColorConstant.white,
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: FileImage(imageSelected!),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
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
                    title: "Submit",
                    onTap: () {
                      _participateInContest();
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
                      'Upload Your Recipe Image',
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
        imageSelected = File(result.path);
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
        imageSelected = File(result.path);
        setState(() {});
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  _participateInContest() async {
    if (titleController.text.isEmpty) {
      toastShow(message: "Please enter title");
      return;
    }
    if (descriptionController.text.isEmpty) {
      toastShow(message: "Please enter description");
      return;
    }
    if (imageSelected == null) {
      toastShow(message: "Please upload image");
      return;
    }
    try {
      setState(() {
        isLoading = true;
      });
      FocusManager.instance.primaryFocus?.unfocus();

      CommonRes response = await ContestRepository()
          .participateInContestApiCall(contestID: widget.contestID);
      if (response.success == true) {
        Get.back(result: "1");
        toastShow(message: response.message);
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
