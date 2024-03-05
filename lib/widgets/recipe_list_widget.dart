import 'package:app/models/recipe/recipe_model.dart';
import 'package:app/utility/color.dart';
import 'package:app/utility/constant.dart';
import 'package:app/utility/images.dart';
import 'package:app/widgets/custom_image_view.dart';
import 'package:app/widgets/custom_image_view_circular.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget recipeListWidget({BuildContext? context, RecipeData? recipeData}) {
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomImageCircular(
                imagePath: recipeData!.userImage ?? "",
                height: 35,
                width: 35,
              ),
              Text(
                recipeData.user ?? AppConstant.appName,
                style: const TextStyle(
                    fontSize: 14,
                    color: ColorConstant.black,
                    fontWeight: FontWeight.w500),
              ),
              const FaIcon(
                FontAwesomeIcons.ellipsis,
                color: ColorConstant.black,
              )
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        recipeData.media.toString().contains('.mp4')
            ? const SizedBox()
            : CustomImage(
                width: MediaQuery.of(context).size.width * 1,
                height: MediaQuery.of(context).size.height * .45,
                imagePath: recipeData.media,
              ),
        const SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
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
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                height: 30,
                decoration: BoxDecoration(
                  color: ColorConstant.greyColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.favorite,
                      color: ColorConstant.mainColor,
                      size: 18,
                    ),
                    const SizedBox(
                      width: 7,
                    ),
                    Text(
                      "${recipeData.likeCount} Likes",
                      style: const TextStyle(
                          fontSize: 12,
                          color: ColorConstant.black,
                          fontWeight: FontWeight.w400),
                    )
                  ],
                ),
              ),
              const SizedBox(
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SizedBox(
            child: RichText(
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              text: TextSpan(
                text: 'Hello ',
                style: DefaultTextStyle.of(context).style,
                children: <TextSpan>[
                  TextSpan(
                    text: '${recipeData.nameDish} - ',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: ColorConstant.mainColor,
                      fontSize: 14,
                    ),
                  ),
                  TextSpan(
                    text: recipeData.smallDesc,
                    style: const TextStyle(
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
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 10.0,
              childAspectRatio: 4,
              crossAxisSpacing: 12,
            ),
            itemCount: recipeData.categories!.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return categoryBox(
                  title: recipeData.categories![index], context: context);
            },
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    ),
  );
}

Widget categoryBox({String? title, BuildContext? context}) {
  return Container(
    height: 24,
    width: MediaQuery.of(context!).size.width * .29,
    decoration: BoxDecoration(
      color: ColorConstant.mainColor,
      borderRadius: BorderRadius.circular(15),
    ),
    alignment: Alignment.center,
    child: Text(
      title!,
      style: const TextStyle(
          fontSize: 14,
          color: ColorConstant.white,
          fontWeight: FontWeight.w400),
    ),
  );
}
