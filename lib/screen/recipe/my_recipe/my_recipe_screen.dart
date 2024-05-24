import 'dart:io';

import 'package:app/api/repository/recipe/recipe.dart';
import 'package:app/models/common_model.dart';
import 'package:app/models/recipe/like_unlike/like_unlike_model.dart';
import 'package:app/models/recipe/recipe_model.dart';
import 'package:app/screen/add_recipe/add_recipe_screen.dart';
import 'package:app/screen/recipe/detail/recipe_detail_screen.dart';
import 'package:app/screen/video_player/video_player_screen.dart';
import 'package:app/utility/color.dart';
import 'package:app/utility/constant.dart';
import 'package:app/widgets/app_bar_back.dart';
import 'package:app/widgets/common_skeleton.dart';
import 'package:app/widgets/custom_image_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class MyRecipeScreen extends StatefulWidget {
  const MyRecipeScreen({super.key});

  @override
  State<MyRecipeScreen> createState() => _MyRecipeScreenState();
}

class _MyRecipeScreenState extends State<MyRecipeScreen> {
  bool isRecipeLoading = false;
  bool isLoading = false;
  List<RecipeData> recipeList = [];
  @override
  void initState() {
    _getRecipeList();
    super.initState();
  }

  Future _getRecipeList() async {
    try {
      setState(() {
        isRecipeLoading = true;
      });
      RecipeRes response = await RecipeRepository().getMyRecipesApiCall();
      if (response.data.isNotEmpty) {
        recipeList = response.data;
        _checkForUserRecipeLike();
        _getVideoThumbnail();
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      if (mounted) {
        setState(() {
          isRecipeLoading = false;
        });
      }
    }
  }

  _checkForUserRecipeLike() {
    for (int i = 0; i < recipeList.length; i++) {
      var contain = recipeList[i].likedUsers.where(
          (element) => element.id.toString() == AppConstant.userData!.id);
      if (contain.isNotEmpty) {
        recipeList[i].isLikedByMe = true;
      }
    }
    if (mounted) {
      setState(() {});
    }
  }

  Future _getVideoThumbnail() async {
    for (int i = 0; i < recipeList.length; i++) {
      if (recipeList[i].media.toString().contains(".mp4")) {
        setState(() {
          recipeList[i].isVideoThumbnailLoading = true;
        });

        recipeList[i].videoThumbnail = await VideoThumbnail.thumbnailFile(
            video: "${AppConstant.imagePath}${recipeList[i].media}",
            thumbnailPath: (await getTemporaryDirectory()).path,
            imageFormat: ImageFormat.PNG,
            quality: 75,
            maxHeight: 100);
        if (mounted) {
          setState(() {
            recipeList[i].isVideoThumbnailLoading = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.backGroundColor,
      appBar: customAppBarBack(
        context: context,
        onTap: () {
          Navigator.pop(context);
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: const Text(
                          'My Recipes',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: ColorConstant.mainColor,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: const Text(
                          'Save, Schedule, Prepare',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: ColorConstant.greyColor,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () async {
                      var response =
                          await Get.to(() => const AddRecipeScreen());
                      if (response != null) {}
                    },
                    child: Container(
                      height: 37,
                      decoration: BoxDecoration(
                        color: ColorConstant.mainColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      alignment: Alignment.center,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          "Add a recipe",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: ColorConstant.white),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            isRecipeLoading == false
                ? recipeList.isNotEmpty
                    ? ListView.builder(
                        itemCount: recipeList.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () async {
                              int recipeListIndex = 0;
                              for (int i = 0; i < recipeList.length; i++) {
                                if (recipeList[index].id.toString() ==
                                    recipeList[i].id.toString()) {
                                  recipeListIndex = i;
                                }
                              }
                              var response = await Get.to(
                                () => RecipeDetailScreen(
                                  recipeData: recipeList[recipeListIndex],
                                ),
                              );
                              if (response != null) {
                                if (response == 0 &&
                                    recipeList[recipeListIndex].isLikedByMe ==
                                        false) {
                                  recipeList[recipeListIndex].isLikedByMe =
                                      true;
                                  recipeList[recipeListIndex].likeCount =
                                      recipeList[recipeListIndex].likeCount! +
                                          1;
                                } else if (response == 1 &&
                                    recipeList[recipeListIndex].isLikedByMe ==
                                        true) {
                                  recipeList[recipeListIndex].isLikedByMe =
                                      false;
                                  recipeList[recipeListIndex].likeCount =
                                      recipeList[recipeListIndex].likeCount! -
                                          1;
                                }
                                setState(() {});
                              }
                            },
                            child: savedRecipe(
                              data: recipeList[index],
                            ),
                          );
                        },
                      )
                    : SizedBox(
                        height: MediaQuery.of(context).size.height * .45,
                        width: MediaQuery.of(context).size.width * 1,
                        child: const Center(
                          child: Text(
                            "No Saved Recipe Found",
                            style: TextStyle(
                                fontSize: 16,
                                color: ColorConstant.greyColor,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: 10,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return const CommonSkeleton();
                    },
                  )
          ],
        ),
      ),
    );
  }

  Widget savedRecipe({RecipeData? data}) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Container(
            height: 1,
            width: MediaQuery.of(context).size.width,
            color: ColorConstant.greyColor,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              data!.media.toString().contains('.mp4')
                  ? GestureDetector(
                      onTap: () {
                        Get.to(() => VideoPlayerScreen(
                              videoPath:
                                  "${AppConstant.imagePath}${data.media}",
                            ));
                      },
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * .35,
                        height: 120,
                        child: Stack(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .35,
                              height: 120,
                              child: data.isVideoThumbnailLoading == true
                                  ? Container(
                                      color: ColorConstant.white,
                                    )
                                  : Image.file(
                                      File(data.videoThumbnail ?? ""),
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
                      borderRadius: 0,
                      imagePath: data.media,
                      width: MediaQuery.of(context).size.width * .35,
                      height: 120,
                    ),
              Container(
                height: 120,
                width: MediaQuery.of(context).size.width * .58,
                margin: const EdgeInsets.symmetric(horizontal: 13),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.nameDish ?? "",
                      style: const TextStyle(
                        fontFamily: "rubik",
                        fontWeight: FontWeight.bold,
                        color: ColorConstant.mainColor,
                        fontSize: 16,
                      ),
                    ),
                    GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 10.0,
                        childAspectRatio: 4,
                        crossAxisSpacing: 12,
                      ),
                      itemCount: data.categories!.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return categoryWidget(
                            title: data.categories![index], context: context);
                      },
                    ),
                    Text(
                      DateFormat('dd MMMM yyyy')
                          .format(DateTime.parse(
                              data.createdAt ?? DateTime.now().toString()))
                          .toString(),
                      style: const TextStyle(
                        fontSize: 10,
                        color: ColorConstant.greyDarkColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 13, vertical: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: data.isApproved == "0"
                            ? ColorConstant.waitingColor
                            : data.isApproved == "1"
                                ? ColorConstant.publishedColor
                                : data.isApproved == "2"
                                    ? ColorConstant.rejectColor
                                    : ColorConstant.mainColor.withOpacity(0.9),
                      ),
                      child: Text(
                        data.isApproved == "0"
                            ? "Waiting for approval"
                            : data.isApproved == "1"
                                ? "Published"
                                : data.isApproved == "2"
                                    ? "Rejected By Admin"
                                    : "Private Recipe",
                        style: const TextStyle(
                          fontSize: 10,
                          color: ColorConstant.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget categoryWidget({String? title, BuildContext? context}) {
    return Container(
      height: 18,
      decoration: BoxDecoration(
        color: ColorConstant.mainColor,
        borderRadius: BorderRadius.circular(20),
      ),
      alignment: Alignment.center,
      child: Text(
        title!,
        style: const TextStyle(
            fontFamily: "rubik",
            fontSize: 10,
            color: ColorConstant.white,
            fontWeight: FontWeight.w400),
      ),
    );
  }

  void appClosePopUp({int? index}) async {
    return showDialog(
      context: context,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shape: const RoundedRectangleBorder(
                  side: BorderSide(
                    color: ColorConstant.greyColor,
                  ),
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
                      'Do you want to delete this recipe?',
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
                                color: ColorConstant.mainColor,
                                borderRadius: BorderRadius.circular(8)),
                            height: 35,
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
                            _recipeDelete(index: index);
                            Navigator.pop(context);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: ColorConstant.mainColor,
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

  _recipeLike({String? recipeID, int? index}) async {
    try {
      setState(() {
        isLoading = true;
      });
      LikeUnlikeRes response =
          await RecipeRepository().recipeLikeApiCall(recipeID: recipeID);
      if (response.success == true) {
        recipeList[index!].likeCount = recipeList[index].likeCount! + 1;
        recipeList[index].isLikedByMe = true;
        toastShow(message: response.message);
      } else {
        toastShow(message: response.message);
        if (response.message!.trim() == "You are already Like This Recipy.") {
          recipeList[index!].likeCount = recipeList[index].likeCount! + 1;
          recipeList[index].isLikedByMe = true;
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
        recipeList[index!].likeCount = recipeList[index].likeCount! - 1;
        recipeList[index].isLikedByMe = false;
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

  Future _recipeDelete({int? index}) async {
    try {
      setState(() {
        isLoading = true;
      });
      CommonRes response = await RecipeRepository()
          .deleteRecipeApiCall(recipeID: recipeList[index!].id.toString());
      if (response.success == true) {
        toastShow(message: "Recipe Deleted successfully");
        recipeList.removeAt(index);
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
