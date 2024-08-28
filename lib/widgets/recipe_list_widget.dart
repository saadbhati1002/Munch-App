import 'dart:io';
import 'package:app/screen/profile/guest_profile/guest_profile_screen.dart';
import 'package:get/get.dart';
import 'package:app/models/recipe/recipe_model.dart';
import 'package:app/screen/video_player/video_player_screen.dart';
import 'package:app/utility/color.dart';
import 'package:app/utility/constant.dart';
import 'package:app/widgets/custom_image_view.dart';
import 'package:app/widgets/custom_image_view_circular.dart';
import 'package:app/widgets/micro_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';

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
        const SizedBox(
          height: 5,
        ),
        isMyRecipe == true
            ? const SizedBox()
            : Column(
                children: [
                  const Divider(
                    thickness: 2,
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: GestureDetector(
                      onTap: () {
                        Get.to(
                          () => GuestProfileScreen(
                            userID: recipeData.userID,
                          ),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CustomImageCircular(
                            imagePath: recipeData!.userImage ?? "",
                            height: 35,
                            width: 35,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            recipeData.user ?? AppConstant.appName,
                            style: const TextStyle(
                                fontSize: 12,
                                fontFamily: "rubik",
                                color: ColorConstant.black,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
        const SizedBox(
          height: 13,
        ),
        recipeData!.media.toString().toLowerCase().contains('.mp4')
            ? GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.leftToRight,
                      duration: Duration(
                          milliseconds: AppConstant.pageAnimationDuration),
                      child: VideoPlayerScreen(
                        videoPath: recipeData.media,
                      ),
                    ),
                  );
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
                                fit: BoxFit.contain,
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
                child: SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 21,
                        height: 19,
                        child: SvgPicture.asset("assets/images/share.svg"),
                      ),
                      const SizedBox(
                        width: 7,
                      ),
                      const Text(
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
              InkWell(
                onTap: onTap,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  height: 30,
                  decoration: BoxDecoration(
                    color: ColorConstant.greyColor.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      !recipeData.isLoading
                          ? Icon(
                              Icons.favorite,
                              color: recipeData.isLikedByMe == true
                                  ? ColorConstant.mainColor
                                  : ColorConstant.greyDarkColor,
                              size: 18,
                            )
                          : microLoader(height: 16, width: 16),
                      const SizedBox(
                        width: 7,
                      ),
                      Text(
                        (recipeData.likeCount == 0 || recipeData.likeCount == 1)
                            ? "${recipeData.likeCount} Like"
                            : "${recipeData.likeCount} Likes",
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
                      fontWeight: FontWeight.w700,
                      fontFamily: "rubik",
                      color: ColorConstant.mainColor,
                      fontSize: 12,
                    ),
                  ),
                  TextSpan(
                    text: recipeData.smallDesc,
                    style: const TextStyle(
                      fontFamily: "rubik",
                      fontWeight: FontWeight.w500,
                      color: ColorConstant.black,
                      fontSize: 12,
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
        recipeData.categories!.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 22,
                  child: ListView.builder(
                    // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    //   crossAxisCount: 3,
                    //   mainAxisSpacing: 10.0,
                    //   childAspectRatio: 4,
                    //   crossAxisSpacing: 12,
                    // ),
                    scrollDirection: Axis.horizontal,
                    itemCount: recipeData.categories!.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return categoryBox(
                          title: recipeData.categories![index],
                          context: context);
                    },
                  ),
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
  return Padding(
    padding: const EdgeInsets.only(right: 7),
    child: Container(
      height: 18,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: ColorConstant.mainColor,
        borderRadius: BorderRadius.circular(15),
      ),
      alignment: Alignment.center,
      child: Text(
        title!,
        style: const TextStyle(
          fontSize: 12,
          color: ColorConstant.white,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}
