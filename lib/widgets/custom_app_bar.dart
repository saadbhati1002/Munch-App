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
    backgroundColor: ColorConstant.white,
    centerTitle: false,
    automaticallyImplyLeading: false,
    title: GestureDetector(
      onTap: () {
        // Get.to(() => const ProfileScreen());
      },
      child: Container(
        margin: const EdgeInsets.only(top: 9.5, bottom: 9.5, left: 9.5),
        height: 47,
        width: MediaQuery.of(context!).size.width * .6,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CustomImage(
                height: 32,
                width: 32,
                isFromAppBar: true,
                imagePath: "",
              ),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * .37,
                child: const Text(
                  "Demo User",
                  maxLines: 1,
                  style: TextStyle(
                      fontSize: 14,
                      color: ColorConstant.white,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.only(top: 3, right: 10),
        child: GestureDetector(
          onTap: () {
            key.currentState!.openEndDrawer();
          },
          child: const FaIcon(
            FontAwesomeIcons.bars,
            color: ColorConstant.mainColor,
          ),
        ),
      )
    ],
  );
}
