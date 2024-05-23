import 'dart:io';

import 'package:app/api/repository/recipe/recipe.dart';
import 'package:app/models/recipe/calender/calender_model.dart';
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
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class MyPlanesScreen extends StatefulWidget {
  const MyPlanesScreen({super.key});

  @override
  State<MyPlanesScreen> createState() => _MyPlanesScreenState();
}

class _MyPlanesScreenState extends State<MyPlanesScreen> {
  bool isRecipeLoading = false;
  List<RecipeData> recipeList = [];
  List<CalenderData> calenderRecipeList = [];
  String? selectedDate;
  @override
  void initState() {
    _getData();
    super.initState();
  }

  _getData() async {
    selectedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

    setState(() {
      isRecipeLoading = true;
    });
    await _getRecipeList();
    await _getCalenderRecipe();
  }

  Future _getRecipeList() async {
    try {
      RecipeRes response = await RecipeRepository().getRecipesApiCall();
      if (response.data.isNotEmpty) {
        recipeList = response.data;
        _checkForUserRecipeLike();
        _getVideoThumbnail();
      }
      return response;
    } catch (e) {
      debugPrint(e.toString());
    } finally {}
  }

  Future _getCalenderRecipe() async {
    try {
      CalenderRes response =
          await RecipeRepository().getCalenderRecipeApiCall();
      if (response.data.isNotEmpty) {
        for (int i = 0; i < response.data.length; i++) {
          if (response.data[i].userId.toString() ==
              AppConstant.userData!.id.toString()) {
            calenderRecipeList.add(
              response.data[i],
            );
          }
          _getCalenderVideoThumbnail();
        }
      }
      return response;
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

  Future _getCalenderVideoThumbnail() async {
    for (int i = 0; i < calenderRecipeList.length; i++) {
      if (recipeList[i].media.toString().contains(".mp4")) {
        setState(() {
          calenderRecipeList[i].isVideoThumbnailLoading = true;
        });
        calenderRecipeList[i].videoThumbnail =
            await VideoThumbnail.thumbnailFile(
                video: "${AppConstant.imagePath}${calenderRecipeList[i].media}",
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
                          'Meal Plan',
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
                      if (response != null) {
                        _getData();
                      }
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
            GestureDetector(
              onTap: () {
                _selectDate(context);
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                height: 60,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: ColorConstant.mainColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      selectedDate == null
                          ? "        "
                          : DateFormat('EEEE')
                              .format(DateTime.parse(selectedDate!))
                              .toString(),
                      style: const TextStyle(
                          fontSize: 14,
                          color: ColorConstant.white,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .3,
                      child: Text(
                        selectedDate == null
                            ? "Select Date"
                            : DateFormat('dd MMM yyyy')
                                .format(DateTime.parse(selectedDate!))
                                .toString(),
                        style: const TextStyle(
                            fontSize: 14,
                            color: ColorConstant.white,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    const Icon(
                      Icons.calendar_month,
                      color: ColorConstant.white,
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            isRecipeLoading == false
                ? calenderRecipeList.isNotEmpty
                    ? ListView.builder(
                        itemCount: calenderRecipeList.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return selectedDate == null
                              ? GestureDetector(
                                  onTap: () async {
                                    int recipeListIndex = 0;
                                    for (int i = 0;
                                        i < recipeList.length;
                                        i++) {
                                      if (calenderRecipeList[index]
                                              .recipeId
                                              .toString() ==
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
                                          recipeList[recipeListIndex]
                                                  .isLikedByMe ==
                                              false) {
                                        recipeList[recipeListIndex]
                                            .isLikedByMe = true;
                                        recipeList[recipeListIndex].likeCount =
                                            recipeList[recipeListIndex]
                                                    .likeCount! +
                                                1;
                                      } else if (response == 1 &&
                                          recipeList[recipeListIndex]
                                                  .isLikedByMe ==
                                              true) {
                                        recipeList[recipeListIndex]
                                            .isLikedByMe = false;
                                        recipeList[recipeListIndex].likeCount =
                                            recipeList[recipeListIndex]
                                                    .likeCount! -
                                                1;
                                      }
                                      setState(() {});
                                    }
                                  },
                                  child: savedRecipe(
                                    calenderData: calenderRecipeList[index],
                                  ),
                                )
                              : selectedDate == calenderRecipeList[index].date
                                  ? GestureDetector(
                                      onTap: () async {
                                        int recipeListIndex = 0;
                                        for (int i = 0;
                                            i < recipeList.length;
                                            i++) {
                                          if (calenderRecipeList[index]
                                                  .recipeId
                                                  .toString() ==
                                              recipeList[i].id.toString()) {
                                            recipeListIndex = i;
                                          }
                                        }
                                        var response = await Get.to(
                                          () => RecipeDetailScreen(
                                            recipeData:
                                                recipeList[recipeListIndex],
                                          ),
                                        );
                                        if (response != null) {
                                          if (response == 0 &&
                                              recipeList[recipeListIndex]
                                                      .isLikedByMe ==
                                                  false) {
                                            recipeList[recipeListIndex]
                                                .isLikedByMe = true;
                                            recipeList[recipeListIndex]
                                                    .likeCount =
                                                recipeList[recipeListIndex]
                                                        .likeCount! +
                                                    1;
                                          } else if (response == 1 &&
                                              recipeList[recipeListIndex]
                                                      .isLikedByMe ==
                                                  true) {
                                            recipeList[recipeListIndex]
                                                .isLikedByMe = false;
                                            recipeList[recipeListIndex]
                                                    .likeCount =
                                                recipeList[recipeListIndex]
                                                        .likeCount! -
                                                    1;
                                          }
                                          setState(() {});
                                        }
                                      },
                                      child: savedRecipe(
                                        calenderData: calenderRecipeList[index],
                                      ),
                                    )
                                  : const SizedBox();
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

  Widget savedRecipe({CalenderData? calenderData}) {
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
              calenderData!.media.toString().contains('.mp4')
                  ? GestureDetector(
                      onTap: () {
                        Get.to(() => VideoPlayerScreen(
                              videoPath:
                                  "${AppConstant.imagePath}${calenderData.media}",
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
                              child: calenderData.isVideoThumbnailLoading ==
                                      true
                                  ? Container(
                                      color: ColorConstant.white,
                                    )
                                  : Image.file(
                                      File(calenderData.videoThumbnail ?? ""),
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
                      imagePath: calenderData.media,
                      width: MediaQuery.of(context).size.width * .35,
                      height: 120,
                    ),
              Container(
                width: MediaQuery.of(context).size.width * .6,
                margin: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 7,
                    ),
                    RichText(
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        text: '',
                        children: <TextSpan>[
                          TextSpan(
                            text: '${calenderData.nameDish} - ',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: ColorConstant.mainColor,
                              fontSize: 14,
                            ),
                          ),
                          TextSpan(
                            text: calenderData.smallDesc,
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              color: ColorConstant.black,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      DateFormat('dd MMMM yyyy')
                          .format(DateTime.parse(calenderData.date!))
                          .toString(),
                      style: const TextStyle(
                        fontSize: 14,
                        color: ColorConstant.greyDarkColor,
                        fontWeight: FontWeight.w700,
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

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      selectedDate = DateFormat('yyyy-MM-dd').format(picked);
      setState(() {});
    }
  }
}
