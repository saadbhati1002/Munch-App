import 'package:app/api/repository/recipe/recipe.dart';
import 'package:app/models/recipe/like_unlike/like_unlike_model.dart';
import 'package:app/models/recipe/recipe_model.dart';
import 'package:app/screen/recipe/detail/recipe_detail_screen.dart';
import 'package:app/utility/color.dart';
import 'package:app/utility/constant.dart';
import 'package:app/widgets/app_bar_back.dart';
import 'package:app/widgets/recipe_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:skeletons/skeletons.dart';
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
      body: isRecipeLoading == false
          ? recipeList.isEmpty
              ? SizedBox(
                  height: MediaQuery.of(context).size.height * .8,
                  width: MediaQuery.of(context).size.width * 1,
                  child: const Center(
                    child: Text(
                      "No Created Recipe Found",
                      style: TextStyle(
                          fontSize: 16,
                          color: ColorConstant.greyColor,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: recipeList.length,
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () async {
                        var response = await Get.to(
                          () => RecipeDetailScreen(
                            recipeData: recipeList[index],
                          ),
                        );
                        if (response != null) {
                          if (response == 0 &&
                              recipeList[index].isLikedByMe == false) {
                            recipeList[index].isLikedByMe = true;
                            recipeList[index].likeCount =
                                recipeList[index].likeCount! + 1;
                          } else if (response == 1 &&
                              recipeList[index].isLikedByMe == true) {
                            recipeList[index].isLikedByMe = false;
                            recipeList[index].likeCount =
                                recipeList[index].likeCount! - 1;
                          }
                          setState(() {});
                        }
                      },
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  recipeList[index].isApproved == "0"
                                      ? "Waiting For Review"
                                      : recipeList[index].isApproved == "1"
                                          ? "Approved By Admin"
                                          : recipeList[index].isApproved == "2"
                                              ? "Rejected By Admin"
                                              : "Private Recipe",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: recipeList[index].isApproved == "0"
                                        ? ColorConstant.organColor
                                        : recipeList[index].isApproved == "1"
                                            ? ColorConstant.greenColor
                                            : recipeList[index].isApproved ==
                                                    "2"
                                                ? ColorConstant.redColor
                                                : ColorConstant.black,
                                  ),
                                ),
                                recipeList[index].isApproved == "1"
                                    ? const SizedBox()
                                    : GestureDetector(
                                        onTap: () {},
                                        child: const FaIcon(
                                          FontAwesomeIcons.xmark,
                                          color: ColorConstant.mainColor,
                                        ),
                                      )
                              ],
                            ),
                          ),
                          recipeListWidget(
                              isFromRecipe: true,
                              isMyRecipe: true,
                              context: context,
                              recipeData: recipeList[index],
                              onTap: () {
                                if (recipeList[index].isLikedByMe == true) {
                                  _recipeUnlike(
                                      recipeID: recipeList[index].id,
                                      index: index);
                                } else {
                                  _recipeLike(
                                    recipeID: recipeList[index].id,
                                    index: index,
                                  );
                                }
                              }),
                        ],
                      ),
                    );
                  },
                )
          : ListView.builder(
              itemCount: 10,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return recipeSkeleton();
              },
            ),
    );
  }

  Widget recipeSkeleton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(10),
        shadowColor: ColorConstant.mainColor,
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 0.9, color: ColorConstant.mainColor),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SkeletonTheme(
              themeMode: ThemeMode.light,
              child: SkeletonAvatar(
                style: SkeletonAvatarStyle(
                  height: MediaQuery.of(context).size.height * .4,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
            ),
          ),
        ),
      ),
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
}
