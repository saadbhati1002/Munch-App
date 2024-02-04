import 'package:app/utility/color.dart';
import 'package:app/utility/images.dart';
import 'package:app/widgets/custom_image_view.dart';
import 'package:flutter/material.dart';

Widget contestListWidget({
  BuildContext? context,
}) {
  return Container(
    width: MediaQuery.of(context!).size.width * 1,
    color: ColorConstant.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 1,
          width: MediaQuery.of(context).size.width * 1,
          color: ColorConstant.greyColor,
        ),
        const SizedBox(
          height: 15,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomImage(
                imagePath: Images.logo,
                isAssetsImage: true,
                height: 25,
                width: 25,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "Demo User",
                style: TextStyle(
                    fontSize: 13,
                    color: ColorConstant.black,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            "Best recipe ever",
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: ColorConstant.black),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            "A recipe is a set of instructions that describes how to prepare or make something, especially a of prepared food. A sub-recipe or sub recipe is a recipe for an that will be called for in the instructions for the main recipe.",
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: ColorConstant.black),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "20 Participant",
                style: TextStyle(
                    fontSize: 12,
                    color: ColorConstant.black,
                    fontWeight: FontWeight.w700),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Participate",
                    style: TextStyle(
                        height: 1,
                        fontSize: 12,
                        color: ColorConstant.black,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  Icon(
                    Icons.arrow_right,
                    color: ColorConstant.mainColor,
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    ),
  );
}
