import 'package:app/utility/color.dart';
import 'package:app/utility/images.dart';
import 'package:app/widgets/custom_image_view.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget recipeListWidget({BuildContext? context}) {
  return SizedBox(
    width: MediaQuery.of(context!).size.width,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 1.5,
          decoration: const BoxDecoration(color: ColorConstant.greyDarkColor),
        ),
        const SizedBox(
          height: 15,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomImage(
                imagePath: "",
                height: 35,
                width: 35,
              ),
              Text(
                "Demo User",
                style: TextStyle(
                    fontSize: 13,
                    color: ColorConstant.black,
                    fontWeight: FontWeight.w500),
              ),
              FaIcon(
                FontAwesomeIcons.ellipsis,
                color: ColorConstant.black,
              )
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 1,
          height: MediaQuery.of(context).size.height * .45,
          child: Image.asset(
            Images.recipe,
            fit: BoxFit.fill,
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomImage(
                      imagePath: Images.share,
                      isAssetsImage: true,
                      width: 21,
                      height: 19,
                    ),
                    SizedBox(
                      width: 7,
                    ),
                    Text(
                      "Share",
                      style: TextStyle(
                          fontSize: 12,
                          color: ColorConstant.black,
                          fontWeight: FontWeight.w400),
                    )
                  ],
                ),
              ),
              SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "View",
                      style: TextStyle(
                          fontSize: 12,
                          color: ColorConstant.black,
                          fontWeight: FontWeight.w400),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 2.5),
                      child: Icon(
                        Icons.arrow_right,
                        color: ColorConstant.mainColor,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: SizedBox(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Name of the dish - ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: ColorConstant.mainColor,
                      fontSize: 14,
                    ),
                  ),
                  TextSpan(
                    text:
                        'how to prepare or make something, especially a of prepared food. A sub-recipe or sub recipe is a recipe for an that will be called for in the instructions for the main recipe.',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: ColorConstant.black,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 40,
        ),
      ],
    ),
  );
}
