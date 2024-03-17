import 'package:app/screen/add_recipe/add_recipe_screen.dart';
import 'package:app/screen/auth/edit_profile/edit_profile_screen.dart';
import 'package:app/screen/auth/password_change/password_change_screen.dart';
import 'package:app/screen/home_maker/home_maker_screen.dart';
import 'package:app/screen/membership/my_memership_screen.dart';
import 'package:app/screen/my_plans/my_planes_screen.dart';
import 'package:app/screen/recipe/my_recipe/my_recipe_screen.dart';
import 'package:app/screen/splash/splash_screen.dart';
import 'package:app/utility/color.dart';
import 'package:app/utility/constant.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class CommonDrawer extends StatefulWidget {
  const CommonDrawer({super.key});

  @override
  State<CommonDrawer> createState() => _CommonDrawerState();
}

class _CommonDrawerState extends State<CommonDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: ColorConstant.white,
      child: Container(
        height: MediaQuery.of(context).size.height * 1,
        width: MediaQuery.of(context).size.width,
        color: ColorConstant.white,
        child: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .08,
              ),
              const Text(
                "EXPLORE MORE",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: ColorConstant.organColor),
              ),
              const Text(
                "Manage, Explore, Create",
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: ColorConstant.greyColor),
              ),
              const SizedBox(
                height: 35,
              ),
              commonRaw(
                icon: const FaIcon(FontAwesomeIcons.userSecret),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeMakerScreen(),
                    ),
                  );
                },
                title: "Meet The Homemakers",
              ),
              const SizedBox(
                height: 20,
              ),
              commonRaw(
                icon: const FaIcon(FontAwesomeIcons.bellConcierge),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddRecipeScreen(),
                    ),
                  );
                },
                title: "Recipe Creation",
              ),
              const SizedBox(
                height: 20,
              ),
              commonRaw(
                icon: const FaIcon(FontAwesomeIcons.bookOpen),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MyPlanesScreen(),
                    ),
                  );
                },
                title: "My Plans",
              ),
              const SizedBox(
                height: 20,
              ),
              commonRaw(
                icon: const FaIcon(FontAwesomeIcons.listCheck),
                onTap: () {
                  Get.to(() => const MyRecipeScreen());
                },
                title: "My List",
              ),
              const SizedBox(
                height: 20,
              ),
              const Divider(
                thickness: 1,
                color: ColorConstant.greyColor,
              ),
              const SizedBox(
                height: 20,
              ),
              commonRaw(
                icon: const FaIcon(FontAwesomeIcons.dollar),
                onTap: () {
                  Get.to(() => const MyMembershipScreen());
                },
                title: "Payments",
              ),
              const SizedBox(
                height: 20,
              ),
              commonRaw(
                icon: const FaIcon(FontAwesomeIcons.userPen),
                onTap: () {
                  Get.to(() => const EditProfileScreen());
                },
                title: "Profile Update",
              ),
              const SizedBox(
                height: 20,
              ),
              commonRaw(
                icon: const FaIcon(FontAwesomeIcons.lockOpen),
                onTap: () {
                  Get.to(() => const ChangePasswordScreen());
                },
                title: "Change Password",
              ),
              const SizedBox(
                height: 20,
              ),
              commonRaw(
                icon: const FaIcon(FontAwesomeIcons.robot),
                onTap: () {},
                title: "Ask AI",
              ),
              const SizedBox(
                height: 20,
              ),
              const Divider(
                thickness: 1,
                color: ColorConstant.greyColor,
              ),
              const SizedBox(
                height: 20,
              ),
              commonRaw(
                icon: const FaIcon(FontAwesomeIcons.circleInfo),
                onTap: () {},
                title: "Help",
              ),
              const SizedBox(
                height: 20,
              ),
              commonRaw(
                icon: const FaIcon(FontAwesomeIcons.circleQuestion),
                onTap: () {},
                title: "FAQs",
              ),
              const SizedBox(
                height: 20,
              ),
              commonRaw(
                icon: const FaIcon(FontAwesomeIcons.heart),
                onTap: () {},
                title: "Follow Us",
              ),
              const SizedBox(
                height: 20,
              ),
              commonRaw(
                icon: const FaIcon(FontAwesomeIcons.rightFromBracket),
                onTap: () {
                  logOutPopUp();
                },
                title: "Log Out",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget commonRaw({FaIcon? icon, String? title, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          icon!,
          const SizedBox(
            width: 15,
          ),
          Text(
            title!,
            style: const TextStyle(
                fontSize: 14,
                color: ColorConstant.black,
                fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }

  void logOutPopUp() async {
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
                  )),
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
                      'Are you sure?',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: ColorConstant.black,
                        fontSize: 18,
                        fontFamily: 'inter',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 13,
                    ),
                    const Text(
                      'Do you want to logout from this app?',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: ColorConstant.black,
                        fontSize: 14,
                        fontFamily: 'inter',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: ColorConstant.mainColor,
                                borderRadius: BorderRadius.circular(8)),
                            height: 35,
                            // width: MediaQuery.of(context).size.width * .2,
                            alignment: Alignment.center,
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Text(
                                'No',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: ColorConstant.white),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            userLogOut();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: ColorConstant.mainColor,
                                borderRadius: BorderRadius.circular(8)),
                            height: 35,
                            // width: MediaQuery.of(context).size.width * .2,
                            alignment: Alignment.center,
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Text(
                                'Yes',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: ColorConstant.white),
                              ),
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

  userLogOut() async {
    toastShow(message: "Log out successfully");

    await AppConstant.userDetailSaved("null");
    Get.to(() => const SplashScreen());
  }
}
