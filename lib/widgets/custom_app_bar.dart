import 'package:app/screen/notification/notification_screen.dart';
import 'package:app/screen/profile/profile_screen.dart';
import 'package:app/utility/color.dart';
import 'package:app/utility/constant.dart';
import 'package:app/widgets/custom_image_view_circular.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';

customAppBar(
  key, {
  BuildContext? context,
}) {
  return AppBar(
    elevation: 0,
    toolbarHeight: 60,
    titleSpacing: 0,
    backgroundColor: ColorConstant.backGroundColor,
    centerTitle: false,
    automaticallyImplyLeading: false,
    title: GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.leftToRight,
            duration: Duration(milliseconds: AppConstant.pageAnimationDuration),
            child: const ProfileScreen(),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomImageCircular(
              height: 45,
              width: 45,
              imagePath: AppConstant.userData!.image != null
                  ? "${AppConstant.imagePath}${AppConstant.userData!.image}"
                  : null,
            ),
            const SizedBox(
              width: 10,
            ),
            SizedBox(
              width: MediaQuery.of(context!).size.width * .53,
              child: Text(
                AppConstant.userData!.name ?? AppConstant.appName,
                maxLines: 1,
                style: const TextStyle(
                    fontSize: 20,
                    color: ColorConstant.black,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      ),
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.only(top: 3, right: 20),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.leftToRight,
                  duration:
                      Duration(milliseconds: AppConstant.pageAnimationDuration),
                  child: const NotificationScreen()),
            );
          },
          child: const Icon(
            Icons.notifications,
            color: ColorConstant.mainColor,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 3, right: 15),
        child: GestureDetector(
          onTap: () {
            key.currentState!.openEndDrawer();
          },
          child: Container(
            height: 38,
            width: 38,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: ColorConstant.white),
            child: const FaIcon(
              FontAwesomeIcons.bars,
              color: ColorConstant.mainColor,
            ),
          ),
        ),
      ),
    ],
  );
}
