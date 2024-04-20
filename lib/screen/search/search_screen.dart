import 'dart:async';

import 'package:app/api/repository/category/category.dart';
import 'package:app/api/repository/recipe/recipe.dart';
import 'package:app/models/category/category_model.dart';
import 'package:app/models/recipe/like_unlike/like_unlike_model.dart';
import 'package:app/models/recipe/recipe_model.dart';
import 'package:app/screen/recipe/detail/recipe_detail_screen.dart';
import 'package:app/utility/color.dart';
import 'package:app/utility/constant.dart';
import 'package:app/widgets/app_bar_back.dart';
import 'package:app/widgets/recipe_list_widget.dart';
import 'package:app/widgets/search_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:skeletons/skeletons.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<RecipeData> recipeList = [];
  List<CategoryData> categoryList = [];

  bool isRecipeLoading = false;
  bool isLoading = false;
  Timer? _debounce;
  String? searchedName;
  @override
  void initState() {
    _getData();
    super.initState();
  }

  _getData() async {
    if (mounted) {
      setState(() {
        isRecipeLoading = true;
      });
    }
    await _getCategory();
    await _getRecipe();
    if (mounted) {
      setState(() {
        isRecipeLoading = false;
      });
    }
  }

  Future _getCategory() async {
    try {
      setState(() {
        isLoading = true;
      });
      CategoryRes response = await CategoryRepository().getCategoryApiCall();
      if (response.data != null) {
        categoryList = response.data!;
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {}
  }

  Future _getRecipe() async {
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
  void dispose() {
    _debounce?.cancel();

    super.dispose();
  }

  _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 1000), () {
      setState(() {
        searchedName = query;
      });
    });
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
              child: CustomSearchTextField(
                onChanged: _onSearchChanged,
                context: context,
                hintText: 'Search for Recipe',
                prefix: const Icon(
                  Icons.search,
                  size: 25,
                  color: ColorConstant.greyColor,
                ),
                suffix: const Icon(
                  Icons.filter_alt_rounded,
                  size: 25,
                  color: ColorConstant.greyColor,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            isRecipeLoading == false
                ? searchedName == null || searchedName == ""
                    ? ListView.builder(
                        itemCount: recipeList.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          int itemCount = recipeList.length;
                          int reversedIndex = itemCount - 1 - index;
                          return recipeList[reversedIndex].isApproved == "1"
                              ? GestureDetector(
                                  onTap: () async {
                                    var response = await Get.to(
                                      () => RecipeDetailScreen(
                                        recipeData: recipeList[reversedIndex],
                                      ),
                                    );
                                    if (response != null) {
                                      if (response == 0 &&
                                          recipeList[reversedIndex]
                                                  .isLikedByMe ==
                                              false) {
                                        recipeList[reversedIndex].isLikedByMe =
                                            true;
                                        recipeList[reversedIndex].likeCount =
                                            recipeList[reversedIndex]
                                                    .likeCount! +
                                                1;
                                      } else if (response == 1 &&
                                          recipeList[reversedIndex]
                                                  .isLikedByMe ==
                                              true) {
                                        recipeList[reversedIndex].isLikedByMe =
                                            false;
                                        recipeList[reversedIndex].likeCount =
                                            recipeList[reversedIndex]
                                                    .likeCount! -
                                                1;
                                      }
                                      setState(() {});
                                    }
                                  },
                                  child: recipeListWidget(
                                      isFromRecipe: true,
                                      context: context,
                                      recipeData: recipeList[reversedIndex],
                                      onTap: () {
                                        if (recipeList[reversedIndex]
                                                .isLikedByMe ==
                                            true) {
                                          _recipeUnlike(
                                              recipeID:
                                                  recipeList[reversedIndex].id,
                                              index: reversedIndex);
                                        } else {
                                          _recipeLike(
                                            recipeID:
                                                recipeList[reversedIndex].id,
                                            index: reversedIndex,
                                          );
                                        }
                                      }),
                                )
                              : const SizedBox();
                        },
                      )
                    : ListView.builder(
                        itemCount: categoryList.length,
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return categoryWidget(categoryList[index]);
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
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }

  Widget categoryWidget(CategoryData? category) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 35,
          margin: const EdgeInsets.only(top: 10),
          width: MediaQuery.of(context).size.width * .29,
          decoration: BoxDecoration(
            color: ColorConstant.mainColor,
            borderRadius: BorderRadius.circular(5),
          ),
          alignment: Alignment.center,
          child: Text(
            category!.name ?? "",
            style: const TextStyle(
                fontSize: 14,
                color: ColorConstant.white,
                fontWeight: FontWeight.w400),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        ListView.builder(
          itemCount: recipeList.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            int itemCount = recipeList.length;
            int reversedIndex = itemCount - 1 - index;
            return recipeList[reversedIndex].isApproved == "1"
                ? recipeList[reversedIndex].categories!.contains(category.name)
                    ? recipeList[reversedIndex]
                            .nameDish!
                            .toLowerCase()
                            .contains(searchedName!.toLowerCase())
                        ? GestureDetector(
                            onTap: () async {
                              var response = await Get.to(
                                () => RecipeDetailScreen(
                                  recipeData: recipeList[reversedIndex],
                                ),
                              );
                              if (response != null) {
                                if (response == 0 &&
                                    recipeList[reversedIndex].isLikedByMe ==
                                        false) {
                                  recipeList[reversedIndex].isLikedByMe = true;
                                  recipeList[reversedIndex].likeCount =
                                      recipeList[reversedIndex].likeCount! + 1;
                                } else if (response == 1 &&
                                    recipeList[reversedIndex].isLikedByMe ==
                                        true) {
                                  recipeList[reversedIndex].isLikedByMe = false;
                                  recipeList[reversedIndex].likeCount =
                                      recipeList[reversedIndex].likeCount! - 1;
                                }
                                setState(() {});
                              }
                            },
                            child: recipeListWidget(
                                isFromRecipe: true,
                                context: context,
                                recipeData: recipeList[reversedIndex],
                                onTap: () {
                                  if (recipeList[reversedIndex].isLikedByMe ==
                                      true) {
                                    _recipeUnlike(
                                        recipeID: recipeList[reversedIndex].id,
                                        index: reversedIndex);
                                  } else {
                                    _recipeLike(
                                      recipeID: recipeList[reversedIndex].id,
                                      index: reversedIndex,
                                    );
                                  }
                                }),
                          )
                        : const SizedBox()
                    : const SizedBox()
                : const SizedBox();
          },
        )
      ],
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
