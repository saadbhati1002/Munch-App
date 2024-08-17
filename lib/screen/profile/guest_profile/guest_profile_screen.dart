import 'package:app/api/repository/user/user.dart';
import 'package:app/models/user/user_model.dart';
import 'package:app/utility/color.dart';
import 'package:app/utility/constant.dart';
import 'package:app/widgets/app_bar_title.dart';
import 'package:app/widgets/common_text_field_text.dart';
import 'package:app/widgets/custom_image_view_circular.dart';
import 'package:app/widgets/show_progress_bar.dart';
import 'package:flutter/material.dart';

class GuestProfileScreen extends StatefulWidget {
  final String? userID;
  const GuestProfileScreen({super.key, this.userID});

  @override
  State<GuestProfileScreen> createState() => _GuestProfileScreenState();
}

class _GuestProfileScreenState extends State<GuestProfileScreen> {
  bool isLoading = false;
  UserData? userData;
  @override
  void initState() {
    _getUserDetail();
    super.initState();
  }

  _getUserDetail() async {
    try {
      setState(() {
        isLoading = true;
      });
      UserRes response =
          await UserRepository().getUserByIdApiCall(userID: widget.userID);
      if (response.success == true) {
        userData = response.data;
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        setState(() {
          isLoading = false;
        });
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
      body: isLoading == true
          ? const ShowProgressBar()
          : Column(
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
                          imagePath: AppConstant.userData!.image,
                          height: 120,
                          width: 120,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: ColorConstant.mainColor,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          height: 30,
                          width: MediaQuery.of(context).size.width * .4,
                          alignment: Alignment.center,
                          child: const Text(
                            "Normal Member",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
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
                      commonDesign(text: userData!.name),
                      const SizedBox(
                        height: 10,
                      ),
                      commonTextFieldText(title: 'Phone Number'),
                      commonDesign(text: userData!.phoneNumber),
                      const SizedBox(
                        height: 10,
                      ),
                      commonTextFieldText(title: 'Date of Birth'),
                      commonDesign(text: userData!.dateOfBirth),
                      const SizedBox(
                        height: 10,
                      ),
                      commonTextFieldText(title: 'Address'),
                      commonDesign(text: userData!.address),
                      const SizedBox(
                        height: 10,
                      ),
                      commonTextFieldText(title: 'Bio'),
                      commonDesign(text: userData!.userBio),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Widget commonDesign({String? text}) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(top: 5),
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
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
}
