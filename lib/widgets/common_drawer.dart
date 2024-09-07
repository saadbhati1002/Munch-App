import 'package:app/screen/add_recipe/add_recipe_screen.dart';
import 'package:app/screen/auth/edit_profile/edit_profile_screen.dart';
import 'package:app/screen/auth/password_change/password_change_screen.dart';
import 'package:app/screen/faqs/faq_screen.dart';
import 'package:app/screen/feedback/feedback_screen.dart';
import 'package:app/screen/home_maker/home_maker_screen.dart';
import 'package:app/screen/list/list_screen.dart';
import 'package:app/screen/membership/my_memership_screen.dart';
import 'package:app/screen/my_plans/my_planes_screen.dart';
import 'package:app/screen/profile/profile_screen.dart';
import 'package:app/screen/recipe/my_recipe/my_recipe_screen.dart';
import 'package:app/screen/social_media/social_media_share_screen.dart';
import 'package:app/screen/splash/splash_screen.dart';
import 'package:app/utility/color.dart';
import 'package:app/utility/constant.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';

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
          child: SingleChildScrollView(
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
                  icon: FaIcon(
                    FontAwesomeIcons.userSecret,
                    color: ColorConstant.mainColor.withOpacity(0.8),
                  ),
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
                  icon: FaIcon(
                    FontAwesomeIcons.bellConcierge,
                    color: ColorConstant.mainColor.withOpacity(0.8),
                  ),
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
                  icon: FaIcon(
                    FontAwesomeIcons.bookOpen,
                    color: ColorConstant.mainColor.withOpacity(0.8),
                  ),
                  onTap: () {
                    if (AppConstant.userData!.isPremiumUser == true) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MyPlanesScreen(),
                        ),
                      );
                    } else {
                      popUpForNormalUsers();
                    }
                  },
                  title: "Meal Plans",
                ),
                const SizedBox(
                  height: 20,
                ),
                commonRaw(
                  icon: FaIcon(
                    FontAwesomeIcons.bowlFood,
                    color: ColorConstant.mainColor.withOpacity(0.8),
                  ),
                  onTap: () {
                    if (AppConstant.userData!.isPremiumUser == true) {
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.leftToRight,
                          duration: Duration(
                              milliseconds: AppConstant.pageAnimationDuration),
                          child: const MyRecipeScreen(),
                        ),
                      );
                    } else {
                      popUpForNormalUsers();
                    }
                  },
                  title: "My Recipes",
                ),
                const SizedBox(
                  height: 20,
                ),
                commonRaw(
                  icon: FaIcon(
                    FontAwesomeIcons.listCheck,
                    color: ColorConstant.mainColor.withOpacity(0.8),
                  ),
                  onTap: () {
                    if (AppConstant.userData!.isPremiumUser == true) {
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.leftToRight,
                          duration: Duration(
                              milliseconds: AppConstant.pageAnimationDuration),
                          child: const ListScreen(),
                        ),
                      );
                    } else {
                      popUpForNormalUsers();
                    }
                  },
                  title: "Shopping List",
                ),
                const SizedBox(
                  height: 20,
                ),
                const Divider(
                  thickness: 1,
                  color: ColorConstant.greyColor,
                ),
                if (AppConstant.userData!.userEmail!.toLowerCase() !=
                    "saadbhati1002@gmail.com") ...[
                  const SizedBox(
                    height: 20,
                  ),
                  commonRaw(
                    icon: FaIcon(
                      FontAwesomeIcons.dollar,
                      color: ColorConstant.mainColor.withOpacity(0.8),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.leftToRight,
                          duration: Duration(
                              milliseconds: AppConstant.pageAnimationDuration),
                          child: const MyMembershipScreen(),
                        ),
                      );
                    },
                    title: "Payment History",
                  ),
                ],
                const SizedBox(
                  height: 20,
                ),
                commonRaw(
                  icon: FaIcon(
                    FontAwesomeIcons.userPen,
                    color: ColorConstant.mainColor.withOpacity(0.8),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.leftToRight,
                        duration: Duration(
                            milliseconds: AppConstant.pageAnimationDuration),
                        child: const EditProfileScreen(),
                      ),
                    );
                  },
                  title: "Profile Update",
                ),
                const SizedBox(
                  height: 20,
                ),
                commonRaw(
                  icon: FaIcon(
                    FontAwesomeIcons.lockOpen,
                    color: ColorConstant.mainColor.withOpacity(0.8),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.leftToRight,
                        duration: Duration(
                            milliseconds: AppConstant.pageAnimationDuration),
                        child: const ChangePasswordScreen(),
                      ),
                    );
                  },
                  title: "Change Password",
                ),
                // const SizedBox(
                //   height: 20,
                // ),
                // commonRaw(
                //   icon: FaIcon(
                //     FontAwesomeIcons.robot,
                //     color: ColorConstant.mainColor.withOpacity(0.8),
                //   ),
                //   onTap: () {
                //     Navigator.push(
                //       context,
                //       PageTransition(
                //         type: PageTransitionType.leftToRight,
                //         duration: Duration(
                //             milliseconds: AppConstant.pageAnimationDuration),
                //         child: const ChatScreen(),
                //       ),
                //     );
                //   },
                //   title: "Ask AI",
                // ),
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
                  icon: FaIcon(
                    FontAwesomeIcons.star,
                    color: ColorConstant.mainColor.withOpacity(0.8),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.leftToRight,
                        duration: Duration(
                            milliseconds: AppConstant.pageAnimationDuration),
                        child: const FeedBackScreen(),
                      ),
                    );
                  },
                  title: "Feedback",
                ),
                const SizedBox(
                  height: 20,
                ),
                commonRaw(
                  icon: FaIcon(
                    FontAwesomeIcons.circleQuestion,
                    color: ColorConstant.mainColor.withOpacity(0.8),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.leftToRight,
                        duration: Duration(
                            milliseconds: AppConstant.pageAnimationDuration),
                        child: const FAQScreen(),
                      ),
                    );
                  },
                  title: "FAQs",
                ),
                const SizedBox(
                  height: 20,
                ),
                commonRaw(
                  icon: FaIcon(
                    FontAwesomeIcons.heart,
                    color: ColorConstant.mainColor.withOpacity(0.8),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.leftToRight,
                        duration: Duration(
                            milliseconds: AppConstant.pageAnimationDuration),
                        child: const SocialMediaShareScreen(),
                      ),
                    );
                  },
                  title: "Follow Us",
                ),
                const SizedBox(
                  height: 20,
                ),
                commonRaw(
                  icon: FaIcon(
                    FontAwesomeIcons.rightFromBracket,
                    color: ColorConstant.mainColor.withOpacity(0.8),
                  ),
                  onTap: () {
                    logOutPopUp();
                  },
                  title: "Log Out",
                ),
                const SizedBox(
                  height: 80,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget commonRaw({FaIcon? icon, String? title, VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            SizedBox(width: 41, child: icon!),
            Text(
              title!,
              style: const TextStyle(
                  fontSize: 14,
                  color: ColorConstant.black,
                  fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }

  void popUpForNormalUsers() async {
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
                width: MediaQuery.of(context).size.width * .9,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'PREMIUM FEATURE',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: ColorConstant.mainColor,
                        fontSize: 20,
                        fontFamily: 'inter',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    const Text(
                      'To access this feature to upgrade to premium profile.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: ColorConstant.black,
                        fontSize: 12,
                        fontFamily: 'inter',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.leftToRight,
                            duration: Duration(
                                milliseconds:
                                    AppConstant.pageAnimationDuration),
                            child: const ProfileScreen(),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: ColorConstant.mainColor,
                            borderRadius: BorderRadius.circular(8)),
                        height: 35,
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.center,
                        child: const Text(
                          'Upgrade Now',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: ColorConstant.white),
                        ),
                      ),
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
                                color: ColorConstant.mainColor.withOpacity(0.8),
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
                                color: ColorConstant.mainColor.withOpacity(0.8),
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
    Navigator.push(
      context,
      PageTransition(
          type: PageTransitionType.leftToRight,
          duration: Duration(milliseconds: AppConstant.pageAnimationDuration),
          child: const SplashScreen()),
    );
  }
}
