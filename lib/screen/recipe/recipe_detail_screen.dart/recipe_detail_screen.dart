import 'dart:io';

import 'package:app/api/repository/recipe/recipe.dart';
import 'package:app/models/recipe/like_unlike/like_unlike_model.dart';
import 'package:app/models/recipe/recipe_model.dart';
import 'package:app/screen/recipe/comments/comments_screen.dart';
import 'package:app/screen/video_player/video_player_screen.dart';
import 'package:app/utility/color.dart';
import 'package:app/utility/constant.dart';
import 'package:app/utility/images.dart';
import 'package:app/widgets/app_bar_back.dart';
import 'package:app/widgets/custom_image_view.dart';
import 'package:app/widgets/custom_image_view_circular.dart';
import 'package:app/widgets/show_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecipeDetailScreen extends StatefulWidget {
  final RecipeData? recipeData;
  const RecipeDetailScreen({super.key, this.recipeData});

  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  bool isLoading = false;
  @override
  void initState() {
    setState(() {});
    super.initState();
  }

  Future<bool> willPopScope() {
    Navigator.pop(context, widget.recipeData!.isLikedByMe == true ? 0 : 1);

    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: willPopScope,
      child: Scaffold(
        backgroundColor: ColorConstant.backGroundColor,
        appBar: customAppBarBack(
          context: context,
          onTap: () {
            Navigator.pop(
                context, widget.recipeData!.isLikedByMe == true ? 0 : 1);
          },
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CustomImageCircular(
                          imagePath: widget.recipeData!.userImage ?? "",
                          height: 35,
                          width: 35,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          widget.recipeData!.user ?? AppConstant.appName,
                          style: const TextStyle(
                              fontSize: 13,
                              color: ColorConstant.black,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  widget.recipeData!.media.toString().contains('.mp4')
                      ? GestureDetector(
                          onTap: () {
                            Get.to(() => VideoPlayerScreen(
                                  videoPath:
                                      "${AppConstant.imagePath}${widget.recipeData!.media}",
                                ));
                          },
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 1,
                            height: MediaQuery.of(context).size.height * .45,
                            child: Stack(
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 1,
                                  height:
                                      MediaQuery.of(context).size.height * .45,
                                  child: widget.recipeData!
                                              .isVideoThumbnailLoading ==
                                          true
                                      ? Container(
                                          color: ColorConstant.white,
                                        )
                                      : Image.file(
                                          File(widget
                                                  .recipeData!.videoThumbnail ??
                                              ""),
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
                          imagePath: widget.recipeData!.media,
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
                        InkWell(
                          onTap: () {
                            if (widget.recipeData!.isLikedByMe == true) {
                              _recipeUnlike();
                            } else {
                              _recipeLike();
                            }
                          },
                          child: Text(
                            "${widget.recipeData!.likeCount}  Likes",
                            style: const TextStyle(
                                fontSize: 12,
                                color: ColorConstant.black,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RecipeCommentsScreen(
                                  recipeID: widget.recipeData!.id,
                                ),
                              ),
                            );
                          },
                          child: const SizedBox(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CustomImage(
                                  imagePath: Images.comment,
                                  isAssetsImage: true,
                                  width: 18,
                                  height: 18,
                                ),
                                SizedBox(
                                  width: 7,
                                ),
                                Text(
                                  "Comment",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: ColorConstant.black,
                                      fontWeight: FontWeight.w400),
                                ),
                                Icon(
                                  Icons.arrow_right,
                                  color: ColorConstant.mainColor,
                                )
                              ],
                            ),
                          ),
                        ),
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
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 10.0,
                        childAspectRatio: 4,
                        crossAxisSpacing: 12,
                      ),
                      itemCount: widget.recipeData!.categories!.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return categoryBox(
                            title: widget.recipeData!.categories![index],
                            context: context);
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      widget.recipeData!.nameDish ?? AppConstant.appName,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: ColorConstant.mainColor,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      widget.recipeData!.tagLine ?? AppConstant.appName,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        color: ColorConstant.greyDarkColor,
                        fontSize: 10,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Save to meal plan",
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
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        recipeTimeWidget(
                            title:
                                "Preparation Time: ${widget.recipeData!.preparationTime} Mins"),
                        recipeTimeWidget(
                            title:
                                "Cooking Time: ${widget.recipeData!.cookingTime} Mins"),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      widget.recipeData!.smallDesc ?? "",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: SizedBox(
                      height: 35,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'INGREDIENT LIST',
                                  style: TextStyle(
                                    height: 1,
                                    fontWeight: FontWeight.w500,
                                    color: ColorConstant.mainColor,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  'Shop for these items',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: ColorConstant.greyDarkColor,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            alignment: Alignment.center,
                            height: 35,
                            decoration: BoxDecoration(
                              color: ColorConstant.greyColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              "Serves: ${widget.recipeData!.servingPotions} Portions",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  height: 1,
                                  fontSize: 13,
                                  color: ColorConstant.mainColor,
                                  fontWeight: FontWeight.w500),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  widget.recipeData!.ingredientList.isNotEmpty
                      ? Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: ColorConstant.greyColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListView.builder(
                            itemCount: widget.recipeData!.ingredientList.length,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Text(
                                '\u2022 ${widget.recipeData!.ingredientList[index]}',
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: ColorConstant.black,
                                    fontWeight: FontWeight.w400),
                              );
                            },
                          ),
                        )
                      : const SizedBox(),
                  const SizedBox(
                    height: 20,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      'METHOD',
                      style: TextStyle(
                        height: 1,
                        fontWeight: FontWeight.w500,
                        color: ColorConstant.mainColor,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      widget.recipeData!.methodTagline ?? AppConstant.appName,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        color: ColorConstant.greyDarkColor,
                        fontSize: 10,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      widget.recipeData!.method ?? AppConstant.appName,
                      style: const TextStyle(
                          fontSize: 12,
                          color: ColorConstant.black,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      'CHEFS WHISPER',
                      style: TextStyle(
                        height: 1,
                        fontWeight: FontWeight.w500,
                        color: ColorConstant.mainColor,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      widget.recipeData!.chefsWhisperTagline ??
                          AppConstant.appName,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        color: ColorConstant.greyDarkColor,
                        fontSize: 10,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      widget.recipeData!.chefsWhisper ?? AppConstant.appName,
                      style: const TextStyle(
                          fontSize: 12,
                          color: ColorConstant.black,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                ],
              ),
            ),
            isLoading ? const ShowProgressBar() : const SizedBox()
          ],
        ),
      ),
    );
  }

  Widget categoryBox({String? title, BuildContext? context}) {
    return Container(
      height: 24,
      width: MediaQuery.of(context!).size.width * .29,
      decoration: BoxDecoration(
        color: ColorConstant.mainColor,
        borderRadius: BorderRadius.circular(20),
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

  Widget recipeTimeWidget({String? title}) {
    return Container(
      alignment: Alignment.center,
      height: 35,
      width: MediaQuery.of(context).size.width * .46,
      decoration: BoxDecoration(
        color: ColorConstant.greyColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        title!,
        textAlign: TextAlign.center,
        style: const TextStyle(
            height: 1,
            fontSize: 13,
            color: ColorConstant.mainColor,
            fontWeight: FontWeight.w500),
      ),
    );
  }

  _recipeLike() async {
    try {
      setState(() {
        isLoading = true;
      });
      LikeUnlikeRes response = await RecipeRepository()
          .recipeLikeApiCall(recipeID: widget.recipeData!.id);
      if (response.success == true) {
        widget.recipeData!.likeCount = widget.recipeData!.likeCount! + 1;
        widget.recipeData!.isLikedByMe = true;
        toastShow(message: response.message);
      } else {
        toastShow(message: response.message);
        if (response.message!.trim() == "You are already Like This Recipy.") {
          widget.recipeData!.likeCount = widget.recipeData!.likeCount! + 1;
          widget.recipeData!.isLikedByMe = true;
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  _recipeUnlike({String? recipeID, int? index}) async {
    try {
      setState(() {
        isLoading = true;
      });
      LikeUnlikeRes response =
          await RecipeRepository().recipeUnlikeApiCall(recipeID: recipeID);
      if (response.success == true) {
        widget.recipeData!.likeCount = widget.recipeData!.likeCount! - 1;
        widget.recipeData!.isLikedByMe = false;
        toastShow(message: response.message);
      } else {
        toastShow(message: response.message);
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
