import 'dart:io';
import 'dart:ui';

import 'package:app/api/repository/list/list.dart';
import 'package:app/api/repository/recipe/recipe.dart';
import 'package:app/models/list/add/add_list_model.dart';
import 'package:app/models/recipe/calender/calender_model.dart';
import 'package:app/models/recipe/like_unlike/like_unlike_model.dart';
import 'package:app/models/recipe/recipe_model.dart';
import 'package:app/screen/profile/profile_screen.dart';
import 'package:app/screen/recipe/comments/comments_screen.dart';
import 'package:app/screen/video_player/video_player_screen.dart';
import 'package:app/utility/color.dart';
import 'package:app/utility/constant.dart';
import 'package:app/widgets/app_bar_back.dart';
import 'package:app/widgets/custom_image_view.dart';
import 'package:app/widgets/custom_image_view_circular.dart';
import 'package:app/widgets/micro_loader.dart';
import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';

class RecipeDetailScreen extends StatefulWidget {
  final RecipeData? recipeData;
  const RecipeDetailScreen({super.key, this.recipeData});

  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  double methodFontSize = 12;
  bool isLoading = false;
  bool isSavedToMyCalender = false;
  List<CalenderData> calenderRecipeList = [];

  @override
  void initState() {
    _getCalenderRecipe();
    super.initState();
  }

  Future<bool> willPopScope() {
    Navigator.pop(context, widget.recipeData!.isLikedByMe == true ? 0 : 1);

    return Future.value(true);
  }

  Future _getCalenderRecipe() async {
    try {
      setState(() {
        isLoading = true;
      });
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
        }
        _checkForRecipeSaved();
      }
      return response;
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  _checkForRecipeSaved() {
    var response = calenderRecipeList
        .where((element) => element.recipeId == widget.recipeData!.id!);
    if (response.isNotEmpty) {
      isSavedToMyCalender = T;
    }
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
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.leftToRight,
                                duration: Duration(
                                    milliseconds:
                                        AppConstant.pageAnimationDuration),
                                child: VideoPlayerScreen(
                                  videoPath:
                                      "${AppConstant.imagePath}${widget.recipeData!.media}",
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
                        widget.recipeData!.isLoading == false
                            ? InkWell(
                                onTap: () {
                                  if (widget.recipeData!.isLikedByMe == true) {
                                    _recipeUnlike(
                                        recipeID: widget.recipeData!.id);
                                  } else {
                                    _recipeLike();
                                  }
                                },
                                child: Text(
                                  (widget.recipeData!.likeCount == 0 ||
                                          widget.recipeData!.likeCount == 1)
                                      ? "${widget.recipeData!.likeCount}  Like"
                                      : "${widget.recipeData!.likeCount}  Likes",
                                  style: const TextStyle(
                                      fontSize: 12,
                                      color: ColorConstant.black,
                                      fontWeight: FontWeight.w400),
                                ),
                              )
                            : microLoader(height: 16, width: 16),
                        GestureDetector(
                          onTap: () async {
                            var response = await Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.leftToRight,
                                duration: Duration(
                                    milliseconds:
                                        AppConstant.pageAnimationDuration),
                                child: RecipeCommentsScreen(
                                  recipeID: widget.recipeData!.id,
                                  count: widget.recipeData!.commentCount,
                                ),
                              ),
                            );
                            if (response != null && response != "0") {
                              widget.recipeData!.commentCount =
                                  int.parse(response);
                              setState(() {});
                            }
                          },
                          child: SizedBox(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: SvgPicture.asset(
                                      "assets/images/comment.svg"),
                                ),
                                const SizedBox(
                                  width: 7,
                                ),
                                Text(
                                  (widget.recipeData!.commentCount == 0 ||
                                          widget.recipeData!.commentCount == 1)
                                      ? "${widget.recipeData!.commentCount} Comment"
                                      : "${widget.recipeData!.commentCount} Comments",
                                  style: const TextStyle(
                                      fontSize: 12,
                                      color: ColorConstant.black,
                                      fontWeight: FontWeight.w400),
                                ),
                                const Icon(
                                  Icons.arrow_right,
                                  color: ColorConstant.mainColor,
                                )
                              ],
                            ),
                          ),
                        ),
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
                                  child: SvgPicture.asset(
                                      "assets/images/share.svg"),
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: GestureDetector(
                      onTap: () {
                        if (isSavedToMyCalender) {
                          toastShow(message: "Already saved to your calender");
                          return;
                        }
                        _selectDate(context);
                      },
                      child: const Row(
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
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  if (widget.recipeData!.featured == 0) ...[
                    premiumData(),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                    ),
                  ] else if (widget.recipeData!.featured == 1 &&
                      AppConstant.userData!.isPremiumUser == true) ...[
                    premiumData(),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                    ),
                  ] else ...[
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .5,
                      width: MediaQuery.of(context).size.width,
                      child: Stack(
                        children: [
                          SingleChildScrollView(
                            physics: const NeverScrollableScrollPhysics(),
                            child: premiumData(),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 5,
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  'PREMIUM FEATURE',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: ColorConstant.mainColor,
                                    fontSize: 20,
                                    fontFamily: 'inter',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  child: Text(
                                    'To access this feature to upgrade to premium profile.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: ColorConstant.black,
                                      fontSize: 12,
                                      fontFamily: 'inter',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 35,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      PageTransition(
                                        type: PageTransitionType.leftToRight,
                                        duration: Duration(
                                            milliseconds: AppConstant
                                                .pageAnimationDuration),
                                        child: const ProfileScreen(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    decoration: BoxDecoration(
                                        color: ColorConstant.mainColor,
                                        borderRadius: BorderRadius.circular(8)),
                                    height: 35,
                                    width: MediaQuery.of(context).size.width,
                                    alignment: Alignment.center,
                                    child: const Text(
                                      'Upgrade Now',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          color: ColorConstant.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ).frosted(
                            blur: 5,
                            frostColor: ColorConstant.white,
                            frostOpacity: 0.7,
                          ),
                        ],
                      ),
                    )
                  ],
                ],
              ),
            ),
            // isLoading ? const ShowProgressBar() : const SizedBox()
          ],
        ),
      ),
    );
  }

  Widget premiumData() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              recipeTimeWidget(
                  title:
                      "Prep Time: ${widget.recipeData!.preparationTime} Mins"),
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
                    color: ColorConstant.greyColor.withOpacity(0.4),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: ColorConstant.greyColor.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        List buy = [];
                        for (int i = 0;
                            i < widget.recipeData!.ingredientList.length;
                            i++) {
                          buy.insert(0, '0');
                        }
                        _ingredientSaveToMyList(
                          widget.recipeData!.ingredientList
                              .toString()
                              .replaceAll("[", '')
                              .replaceAll("]", ''),
                          buy
                              .toString()
                              .replaceAll("[", '')
                              .replaceAll("]", ''),
                        );
                        await Clipboard.setData(
                          ClipboardData(
                            text: widget.recipeData!.ingredientList
                                .toString()
                                .replaceAll("[", '')
                                .replaceAll("]", ''),
                          ),
                        );
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Save List',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 12,
                                color: ColorConstant.black,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.copy,
                            color: ColorConstant.black,
                            size: 18,
                          ),
                        ],
                      ),
                    ),
                    ListView.builder(
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
                  ],
                ),
              )
            : const SizedBox(),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'METHOD',
                style: TextStyle(
                  height: 1,
                  fontWeight: FontWeight.w500,
                  color: ColorConstant.mainColor,
                  fontSize: 20,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (methodFontSize < 32) {
                        methodFontSize++;
                        setState(() {});
                      }
                    },
                    child: Container(
                      height: 25,
                      width: 25,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          width: 1,
                          color: ColorConstant.mainColor,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.add,
                        color: ColorConstant.mainColor,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (methodFontSize > 10) {
                        methodFontSize--;
                        setState(() {});
                      }
                    },
                    child: Container(
                      height: 25,
                      width: 25,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          width: 1,
                          color: ColorConstant.mainColor,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.remove,
                        color: ColorConstant.mainColor,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            widget.recipeData!.method ?? AppConstant.appName,
            style: TextStyle(
                fontSize: methodFontSize,
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
            "CHEF'S WHISPER",
            style: TextStyle(
              height: 1,
              fontWeight: FontWeight.w500,
              color: ColorConstant.mainColor,
              fontSize: 20,
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
      ],
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
        color: ColorConstant.greyColor.withOpacity(0.4),
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

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      _saveToMyCalender(date: DateFormat('yyyy-MM-dd').format(picked));
    }
  }

  _saveToMyCalender({String? date}) async {
    try {
      setState(() {
        isLoading = true;
      });
      LikeUnlikeRes response = await RecipeRepository()
          .saveToMyCalenderApiCall(date: date, recipeID: widget.recipeData!.id);
      if (response.success == true) {
        toastShow(message: "Saved to my calender successfully");
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

  _recipeLike() async {
    try {
      setState(() {
        widget.recipeData!.isLoading = true;
      });
      LikeUnlikeRes response = await RecipeRepository()
          .recipeLikeApiCall(recipeID: widget.recipeData!.id);
      if (response.success == true) {
        widget.recipeData!.likeCount = widget.recipeData!.likeCount! + 1;
        widget.recipeData!.isLikedByMe = true;
      } else {
        if (response.message!.trim() == "You are already like this recipe.") {
          widget.recipeData!.likeCount = widget.recipeData!.likeCount! + 1;
          widget.recipeData!.isLikedByMe = true;
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        widget.recipeData!.isLoading = false;
      });
    }
  }

  _recipeUnlike({String? recipeID}) async {
    try {
      setState(() {
        widget.recipeData!.isLoading = true;
      });
      LikeUnlikeRes response =
          await RecipeRepository().recipeUnlikeApiCall(recipeID: recipeID);
      if (response.success == true) {
        widget.recipeData!.likeCount = widget.recipeData!.likeCount! - 1;
        widget.recipeData!.isLikedByMe = false;
        // toastShow(message: response.message);
      } else {
        toastShow(message: response.message);
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        widget.recipeData!.isLoading = false;
      });
    }
  }

  Future _ingredientSaveToMyList(ingredient, buy) async {
    try {
      setState(() {
        isLoading = true;
      });
      AddListRes response = await ListRepository().addListApiCall(
          ingredient: ingredient,
          recipeName: widget.recipeData!.nameDish,
          servingPortion: widget.recipeData!.servingPotions,
          buy: buy);
      if (response.success == true) {
        toastShow(message: "Saved to your list");
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
