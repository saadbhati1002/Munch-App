import 'dart:convert';

import 'package:app/api/repository/membership/membership.dart';
import 'package:app/models/common_model.dart';
import 'package:app/models/membership/list/membership_list_model.dart';
import 'package:app/models/user/user_model.dart';
import 'package:app/screen/dashboard/dashboard_screen.dart';
import 'package:app/utility/color.dart';
import 'package:app/utility/constant.dart';
import 'package:app/widgets/app_bar_title.dart';
import 'package:app/widgets/common_button.dart';
import 'package:app/widgets/common_text_field_text.dart';
import 'package:app/widgets/custom_image_view_circular.dart';
import 'package:app/widgets/show_progress_bar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<MembershipData> membershipList = [];
  bool isLoading = false;
  bool isShowPlan = false;
  MembershipData? selectedMembership;

  Map<String, dynamic>? paymentIntent;
  @override
  void initState() {
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
            selectedMembership = membershipList.first;
          }
        }
        if (AppConstant.userData!.latestPlanName != null) {
          for (int i = 0; i < membershipList.length; i++) {
            if (membershipList[i].id ==
                AppConstant.userData!.latestPlanName!.plan!.id) {
              selectedMembership = membershipList[i];
            }
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
      appBar: titleAppBar(
        context: context,
        title: "Back",
        onTap: () {
          Navigator.pop(context);
        },
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * .03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        CustomImageCircular(
                          imagePath: AppConstant.userData!.image != null
                              ? "${AppConstant.imagePath}${AppConstant.userData!.image}"
                              : null,
                          height: 120,
                          width: 120,
                        ),
                        if (AppConstant.userData!.userEmail!.toLowerCase() !=
                            "saadbhati1002@gmail.com") ...[
                          const SizedBox(
                            height: 20,
                          ),
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
                        ]
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .05,
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
                      commonDesign(text: AppConstant.userData!.name),
                      const SizedBox(
                        height: 10,
                      ),
                      commonTextFieldText(title: 'Email'),
                      commonDesign(text: AppConstant.userData!.userEmail),
                      const SizedBox(
                        height: 10,
                      ),
                      commonTextFieldText(title: 'Phone Number'),
                      commonDesign(text: AppConstant.userData!.phoneNumber),
                      const SizedBox(
                        height: 10,
                      ),
                      commonTextFieldText(title: 'Date of Birth'),
                      commonDesign(text: AppConstant.userData!.dateOfBirth),
                      const SizedBox(
                        height: 10,
                      ),
                      commonTextFieldText(title: 'Address'),
                      commonDesign(text: AppConstant.userData!.address),
                      const SizedBox(
                        height: 10,
                      ),
                      commonTextFieldText(title: 'Bio'),
                      commonDesign(text: AppConstant.userData!.userBio),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
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

  Widget commonDesign({String? text}) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(top: 5),
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: ColorConstant.greyColor,
          width: 1,
        ),
      ),
      alignment: Alignment.centerLeft,
      child: Text(
        text ?? '',
        style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: ColorConstant.black),
      ),
    );
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
                    if (AppConstant.userData!.isPremiumUser == true) {
                      if (selectedMembership!.id ==
                          AppConstant.userData!.latestPlanName!.plan!.id) {
                        toastShow(
                            message:
                                "You can not subscribe with the active plan");
                        return;
                      }
                    }
                    if (selectedMembership!.amount == "0") {
                      _byMembership(membershipType: 0);
                    } else {
                      makeStripePayment(selectedMembership!.amount);
                    }
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
        selectedMembership = membershipData;
        setState(() {});
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
                color: selectedMembership == null
                    ? Colors.transparent
                    : selectedMembership!.id == membershipData!.id
                        ? ColorConstant.mainColor
                        : Colors.transparent),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    membershipData!.title!,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: selectedMembership == null
                          ? ColorConstant.mainColor
                          : selectedMembership!.id == membershipData.id
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
                      color: selectedMembership == null
                          ? ColorConstant.black
                          : selectedMembership!.id == membershipData.id
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
                      color: selectedMembership == null
                          ? Colors.transparent
                          : selectedMembership!.id == membershipData.id
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
                        color: selectedMembership == null
                            ? ColorConstant.black
                            : selectedMembership!.id == membershipData.id
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

  createPaymentIntent(String amount, String currency) async {
    try {
      //Request body
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card',
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

  Future<void> makeStripePayment(String? priceTotal) async {
    setState(() {
      isLoading = true;
    });
    Stripe.publishableKey = AppConstant.stripePublic;
    Stripe.merchantIdentifier = 'Munch Mondays';
    await Stripe.instance.applySettings();
    int price = double.parse(priceTotal!).toInt();
    try {
      paymentIntent = await createPaymentIntent(price.toString(), 'AED');

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          // Client secret key from payment data
          paymentIntentClientSecret: paymentIntent!['client_secret'],
          googlePay: const PaymentSheetGooglePay(
              // Currency and country code is accourding to India
              testEnv: true,
              currencyCode: "AED",
              merchantCountryCode: "AE"),
          // Merchant Name
          merchantDisplayName: 'Munch Mondays',
          // return URl if you want to add
          // returnURL: 'flutterstripe://redirect',
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
        _byMembership(membershipType: 1);
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

      //STEP 3: Display Payment sheet
      // displayPaymentSheet();
    } catch (err) {
      throw Exception(err);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future _byMembership({int? membershipType}) async {
    try {
      setState(() {
        isLoading = true;
      });
      CommonRes response = await MembershipRepository().byMemberShip(
        memberShipID: selectedMembership!.id.toString(),
      );
      if (response.success == true) {
        toastShow(message: "Your subscription created");
        AppConstant.userData!.isPremiumUser =
            membershipType == 0 ? false : true;
        AppConstant.userData!.latestPlanName = LatestPlanName();
        AppConstant.userData!.latestPlanName!.id = 1;
        AppConstant.userData!.latestPlanName!.updatedAt =
            DateTime.now().toString();
        AppConstant.userData!.latestPlanName!.createdAt =
            DateTime.now().toString();
        AppConstant.userData!.latestPlanName!.planId = selectedMembership!.id;
        AppConstant.userData!.latestPlanName!.userId =
            int.parse(AppConstant.userData!.id ?? "0");
        AppConstant.userData!.latestPlanName!.plan = Plan();
        AppConstant.userData!.latestPlanName!.plan!.id = selectedMembership!.id;
        AppConstant.userData!.latestPlanName!.plan!.amount =
            selectedMembership!.amount;
        AppConstant.userData!.latestPlanName!.plan!.days =
            selectedMembership!.days;
        AppConstant.userData!.latestPlanName!.plan!.desc =
            selectedMembership!.desc;
        AppConstant.userData!.latestPlanName!.plan!.title =
            selectedMembership!.title;
        AppConstant.userData!.latestPlanName!.plan!.createdAt =
            DateTime.now().toString();
        AppConstant.userData!.latestPlanName!.plan!.updatedAt =
            DateTime.now().toString();

        await AppConstant.userDetailSaved(json.encode(AppConstant.userData));
        Get.to(() => const DashBoardScreen());
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
