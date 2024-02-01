import 'package:app/utility/color.dart';
import 'package:app/widgets/custom_image_view.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

customAppBar(
  key, {
  BuildContext? context,
  Function? setState,
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
        // Get.to(() => const ProfileScreen());
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CustomImage(
              height: 45,
              width: 45,
              imagePath: "",
            ),
            const SizedBox(
              width: 10,
            ),
            SizedBox(
              width: MediaQuery.of(context!).size.width * .56,
              child: const Text(
                "Demo User",
                maxLines: 1,
                style: TextStyle(
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
            key.currentState!.openEndDrawer();
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
