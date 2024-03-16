import 'dart:io';

import 'package:app/models/recipe/recipe_model.dart';
import 'package:app/screen/video_player/video_player_screen.dart';
import 'package:app/utility/color.dart';
import 'package:app/utility/constant.dart';
import 'package:app/utility/images.dart';
import 'package:app/widgets/custom_image_view.dart';
import 'package:app/widgets/custom_image_view_circular.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget recipeListWidget(
    {BuildContext? context,
    RecipeData? recipeData,
    VoidCallback? onTap,
    bool? isFromRecipe,
    bool? isMyRecipe}) {
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
        isMyRecipe == true
            ? const SizedBox()
            : Padding(
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
                    const SizedBox(
                      width: 20,
                    ),
                  ],
                ),
              ),
        const SizedBox(
          height: 15,
        ),
        recipeData!.media.toString().contains('.mp4')
            ? GestureDetector(
                onTap: () {
                  Get.to(() => VideoPlayerScreen(
                        videoPath:
                            "${AppConstant.imagePath}${recipeData.media}",
                      ));
                },
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 1,
                  height: MediaQuery.of(context).size.height * .45,
                  child: Stack(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 1,
                        height: MediaQuery.of(context).size.height * .45,
                        child: recipeData.isVideoThumbnailLoading == true
                            ? Container(
                                color: ColorConstant.white,
                              )
                            : Image.file(
                                File(recipeData.videoThumbnail ?? ""),
                                fit: BoxFit.fill,
                              ),
                      ),
                      Center(
                        child: Container(
                          height: 45,
                          width: 45,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: ColorConstant.greyColor),
                          child: const Icon(
                            Icons.play_arrow,
                            size: 35,
                            color: ColorConstant.mainColor,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
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
              GestureDetector(
                onTap: () {
                  AppConstant.shareAppLink();
                },
                child: const SizedBox(
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
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                height: 30,
                decoration: BoxDecoration(
                  color: ColorConstant.greyColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: GestureDetector(
                  onTap: onTap,
                  child: Row(
                    children: [
                      Icon(
                        Icons.favorite,
                        color: recipeData.isLikedByMe == true
                            ? ColorConstant.mainColor
                            : ColorConstant.greyDarkColor,
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
                text: '',
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
        SizedBox(
          height: isFromRecipe == true ? 10 : 0,
        ),
        isFromRecipe == true
            ? Padding(
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
              )
            : const SizedBox(),
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
