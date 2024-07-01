import 'dart:convert';
import 'dart:io';

import 'package:app/api/repository/auth/auth.dart';
import 'package:app/api/repository/membership/membership.dart';
import 'package:app/models/membership/list/membership_list_model.dart';
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
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  bool isLoading = false;
  bool isShowPlan = false;
  int? selectedMembership;
  String? amount;
  List<MembershipData> membershipList = [];

  Map<String, dynamic>? paymentIntent;
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
    _getMembershipList();
    super.initState();
  }

  Future _getMembershipList() async {
    try {
      setState(() {
        isLoading = true;
      });
      MembershipRes response =
          await MembershipRepository().getMembershipListApiCall();
      if (response.data != null) {
        membershipList = response.data!;

        if (membershipList.first.amount == "0") {
          if (AppConstant.userData!.isPremiumUser == false) {
            selectedMembership = membershipList.first.id!;
          }
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
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
                  height: MediaQuery.of(context).size.height * .02,
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
                  height: MediaQuery.of(context).size.height * .02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        isShowPlan = true;
                        setState(() {});
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: ColorConstant.mainColor,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        height: 30,
                        width: MediaQuery.of(context).size.width * .4,
                        alignment: Alignment.center,
                        child: const Text(
                          "Choose Plan",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .02,
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
          isShowPlan ? membershipListWidget() : const SizedBox(),
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

  Widget membershipListWidget() {
    return Container(
      color: ColorConstant.black.withOpacity(0.2),
      width: MediaQuery.of(context).size.width * 1,
      height: MediaQuery.of(context).size.height * 1,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: ColorConstant.white,
        ),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isShowPlan = false;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(top: 10, left: 5),
                      height: 23,
                      width: 30,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: ColorConstant.black,
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        color: ColorConstant.white,
                        size: 18,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      'Back',
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'inter',
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                alignment: Alignment.center,
                child: const Text(
                  'SUBSCRIPTION PLANS',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: ColorConstant.mainColor,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: const Text(
                  'Select a plan, you will be billed as per you selection.',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: ColorConstant.greyColor,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ListView.builder(
                itemCount: membershipList.length,
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return membershipWidget(
                    membershipData: membershipList[index],
                  );
                },
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: CommonButton(
                  color: ColorConstant.mainColor,
                  textColor: ColorConstant.white,
                  title: "Subscribe",
                  onTap: () {
                    if (selectedMembership == null) {
                      toastShow(
                          message: "Please select membership plan to proceed");
                      return;
                    }
                    makeStripePayment(amount);
                    setState(() {
                      isShowPlan = false;
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget membershipWidget({MembershipData? membershipData}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          amount = membershipData.amount;
          selectedMembership = membershipData.id;
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Material(
          elevation: 2,
          borderRadius: BorderRadius.circular(5),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: selectedMembership == membershipData!.id
                    ? ColorConstant.mainColor
                    : Colors.transparent),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    membershipData.title!,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: selectedMembership == membershipData.id
                          ? ColorConstant.white
                          : ColorConstant.mainColor,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 0,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    "${membershipData.amount!} AED/ ${membershipData.days!} Days",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: selectedMembership == membershipData.id
                          ? ColorConstant.white
                          : ColorConstant.black,
                    ),
                  ),
                ),
                if (AppConstant.userData!.isPremiumUser == false &&
                    membershipData.amount == "0") ...[
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: selectedMembership == membershipData.id
                          ? ColorConstant.white
                          : Colors.transparent,
                      border: Border.all(color: ColorConstant.greyColor),
                    ),
                    child: const Text(
                      "Currently active",
                      style:
                          TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
                const SizedBox(
                  height: 0,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    membershipData.desc!,
                    maxLines: 3,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: selectedMembership == membershipData.id
                            ? ColorConstant.white
                            : ColorConstant.black),
                  ),
                ),
              ],
            ),
          ),
        ),
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
        _cropImage(result.path);
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
        _cropImage(result.path);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future _cropImage(String? imagePath) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imagePath!,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: ColorConstant.mainColor,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Image Crop',
        ),
        WebUiSettings(
          context: context,
        ),
      ],
    );
    if (croppedFile != null) {
      userImage = File(croppedFile.path);
      setState(() {});
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
        AppConstant.userData = response.data;

        await AppConstant.userDetailSaved(json.encode(response));
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.leftToRight,
            duration: Duration(milliseconds: AppConstant.pageAnimationDuration),
            child: const DashBoardScreen(),
          ),
        );
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

  Future<void> makeStripePayment(String? priceTotal) async {
    Stripe.publishableKey = AppConstant.stripePublic;
    Stripe.merchantIdentifier = 'Mohd Saad bhati';
    await Stripe.instance.applySettings();
    int price = double.parse(priceTotal!).toInt();
    try {
      paymentIntent = await createPaymentIntent(price.toString(), 'INR');

      // STEP 2: Initialize Payment Sheet
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret:
                paymentIntent!['client_secret'], //Gotten from payment intent
            style: ThemeMode.light,
            merchantDisplayName: 'NowoChat',
          ))
          .then((value) {});

      //STEP 3: Display Payment sheet
      displayPaymentSheet();
    } catch (err) {
      throw Exception(err);
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent!['client_secret'],
          customFlow: true,
          allowsDelayedPaymentMethods: true,
          googlePay: const PaymentSheetGooglePay(
            merchantCountryCode: 'IN',
            testEnv: true,
          ),
          style: ThemeMode.light,
          merchantDisplayName: 'NowoChat',
        ),
      );
      await Stripe.instance.presentPaymentSheet().then((value) {
        showDialog(
            context: context,
            builder: (_) => const AlertDialog(
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 100.0,
                      ),
                      SizedBox(height: 10.0),
                      Text("Payment Successful!"),
                    ],
                  ),
                ));
        // paymentSuccess(
        //   transactionID: DateTime.now().millisecondsSinceEpoch.toString(),
        // );
        paymentIntent = null;
      }).onError((error, stackTrace) {
        throw Exception(error);
      });
    } on StripeException catch (e) {
      debugPrint(e.toString());
      const AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Icon(
                  Icons.cancel,
                  color: Colors.red,
                ),
                Text("Payment Failed"),
              ],
            ),
          ],
        ),
      );
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      //Request body
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
      };

      //Make post request to Stripe
      var response = await Dio().post(
        'https://api.stripe.com/v1/payment_intents',
        data: body,
        options: Options(
          headers: {
            'Authorization': 'Bearer ${AppConstant.stripeSecretKey}',
            'Content-Type': 'application/x-www-form-urlencoded'
          },
        ),
      );
      paymentIntent = response.data;
      return response.data;
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  calculateAmount(String amount) {
    final calculatedAmount = (int.parse(amount)) * 100;
    return calculatedAmount.toString();
  }
}
