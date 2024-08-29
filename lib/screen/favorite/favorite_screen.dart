import 'dart:async';

import 'package:app/api/repository/recipe/recipe.dart';
import 'package:app/models/recipe/like_unlike/like_unlike_model.dart';
import 'package:app/models/recipe/recipe_model.dart';
import 'package:app/screen/recipe/detail/recipe_detail_screen.dart';
import 'package:app/utility/color.dart';
import 'package:app/utility/constant.dart';
import 'package:app/widgets/common_drawer.dart';
import 'package:app/widgets/custom_app_bar.dart';
import 'package:app/widgets/recipe_list_widget.dart';
import 'package:app/widgets/recipe_skeleton.dart';
import 'package:app/widgets/search_text_field.dart';
import 'package:app/widgets/show_progress_bar.dart';
import 'package:flutter/material.dart';

import 'package:page_transition/page_transition.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  bool isRecipeLoading = false;
  bool isLoading = false;

  List<RecipeData> recipeList = [];
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  Timer? _debounce;
  String? searchedName;

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
      RecipeRes response = await RecipeRepository().getMyLikedRecipeApiCall();
      if (response.data.isNotEmpty) {
        recipeList = response.data;
        _checkForUserRecipeLike();
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      if (mounted) {
        if (mounted) {
          setState(() {
            isRecipeLoading = false;
          });
        }
      }
    }
  }

  _checkForUserRecipeLike() {
    for (int i = 0; i < recipeList.length; i++) {
      recipeList[i].isLikedByMe = true;
    }
    setState(() {});
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
      endDrawer: const CommonDrawer(),
      key: _key,
      backgroundColor: ColorConstant.backGroundColor,
      appBar: customAppBar(
        _key,
        context: context,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30,
                ),
                Container(
                  alignment: Alignment.center,
                  child: const Text(
                    'Saved/liked',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: ColorConstant.organColor,
                      fontSize: 20,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: const Text(
                    'The recipes that you love',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: ColorConstant.greyColor,
                      fontSize: 10,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: CustomSearchTextField(
                    onChanged: _onSearchChanged,
                    context: context,
                    hintText: 'Search for recipe',
                    prefix: const Icon(
                      Icons.search,
                      size: 25,
                      color: ColorConstant.greyColor,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                isRecipeLoading == false
                    ? recipeList.isEmpty
                        ? SizedBox(
                            height: MediaQuery.of(context).size.height * .45,
                            width: MediaQuery.of(context).size.width * 1,
                            child: const Center(
                              child: Text(
                                "No Liked/Saved Recipe Found",
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
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return searchedName == null || searchedName == ""
                                  ? GestureDetector(
                                      onTap: () async {
                                        var response = await Navigator.push(
                                          context,
                                          PageTransition(
                                            type:
                                                PageTransitionType.leftToRight,
                                            duration: Duration(
                                                milliseconds: AppConstant
                                                    .pageAnimationDuration),
                                            child: RecipeDetailScreen(
                                              recipeData: recipeList[index],
                                            ),
                                          ),
                                        );
                                        if (response != null) {
                                          if (response == 0 &&
                                              recipeList[index].isLikedByMe ==
                                                  false) {
                                            recipeList[index].isLikedByMe =
                                                true;
                                            recipeList[index].likeCount =
                                                recipeList[index].likeCount! +
                                                    1;
                                          } else if (response == 1 &&
                                              recipeList[index].isLikedByMe ==
                                                  true) {
                                            recipeList[index].isLikedByMe =
                                                false;
                                            recipeList[index].likeCount =
                                                recipeList[index].likeCount! -
                                                    1;
                                          }
                                          setState(() {});
                                        }
                                      },
                                      child: recipeListWidget(
                                          isFromRecipe: true,
                                          context: context,
                                          recipeData: recipeList[index],
                                          onTap: () {
                                            if (recipeList[index].isLikedByMe ==
                                                true) {
                                              _recipeUnlike(
                                                  recipeID:
                                                      recipeList[index].id,
                                                  index: index);
                                            } else {
                                              _recipeLike(
                                                recipeID: recipeList[index].id,
                                                index: index,
                                              );
                                            }
                                          }),
                                    )
                                  : searchedName!
                                          .contains(recipeList[index].nameDish!)
                                      ? GestureDetector(
                                          onTap: () async {
                                            var response = await Navigator.push(
                                              context,
                                              PageTransition(
                                                type: PageTransitionType
                                                    .leftToRight,
                                                duration: Duration(
                                                    milliseconds: AppConstant
                                                        .pageAnimationDuration),
                                                child: RecipeDetailScreen(
                                                  recipeData: recipeList[index],
                                                ),
                                              ),
                                            );
                                            if (response != null) {
                                              if (response == 0 &&
                                                  recipeList[index]
                                                          .isLikedByMe ==
                                                      false) {
                                                recipeList[index].isLikedByMe =
                                                    true;
                                                recipeList[index].likeCount =
                                                    recipeList[index]
                                                            .likeCount! +
                                                        1;
                                              } else if (response == 1 &&
                                                  recipeList[index]
                                                          .isLikedByMe ==
                                                      true) {
                                                recipeList[index].isLikedByMe =
                                                    false;
                                                recipeList[index].likeCount =
                                                    recipeList[index]
                                                            .likeCount! -
                                                        1;
                                              }
                                              setState(() {});
                                            }
                                          },
                                          child: recipeListWidget(
                                              isFromRecipe: true,
                                              context: context,
                                              recipeData: recipeList[index],
                                              onTap: () {
                                                if (recipeList[index]
                                                        .isLikedByMe ==
                                                    true) {
                                                  _recipeUnlike(
                                                      recipeID:
                                                          recipeList[index].id,
                                                      index: index);
                                                } else {
                                                  _recipeLike(
                                                    recipeID:
                                                        recipeList[index].id,
                                                    index: index,
                                                  );
                                                }
                                              }),
                                        )
                                      : const SizedBox();
                            },
                          )
                    : ListView.builder(
                        itemCount: 10,
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return recipeSkeleton(context: context);
                        },
                      ),
              ],
            ),
          ),
          isLoading ? const ShowProgressBar() : const SizedBox()
        ],
      ),
    );
  }

  _recipeLike({String? recipeID, int? index}) async {
    try {
      setState(() {
        recipeList[index!].isLoading = true;
      });
      LikeUnlikeRes response =
          await RecipeRepository().recipeLikeApiCall(recipeID: recipeID);
      if (response.success == true) {
        recipeList[index!].likeCount = recipeList[index].likeCount! + 1;
        recipeList[index].isLikedByMe = true;
      } else {
        if (response.message!.trim() == "You are already like this recipe.") {
          recipeList[index!].likeCount = recipeList[index].likeCount! + 1;
          recipeList[index].isLikedByMe = true;
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        recipeList[index!].isLoading = true;
      });
    }
  }

  _recipeUnlike({String? recipeID, int? index}) async {
    try {
      setState(() {
        recipeList[index!].isLoading = true;
      });
      LikeUnlikeRes response =
          await RecipeRepository().recipeUnlikeApiCall(recipeID: recipeID);
      if (response.success == true) {
        recipeList[index!].likeCount = recipeList[index].likeCount! - 1;
        recipeList[index].isLikedByMe = false;
        recipeList.removeAt(index);
      } else {
        toastShow(message: response.message);
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        // recipeList[index!].isLoading = true;
      });
    }
  }
}
