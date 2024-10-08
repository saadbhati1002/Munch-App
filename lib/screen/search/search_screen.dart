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
import 'package:app/widgets/recipe_skeleton.dart';
import 'package:app/widgets/search_text_field.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<RecipeData> recipeList = [];
  List<RecipeData> recipeListAll = [];
  List<CategoryData> categoryList = [];
  List<CategoryData> categoryListAll = [];
  CategoryData? selectedCategory;
  bool isRecipeLoading = false;
  bool isLoading = false;
  Timer? _debounce;
  String? searchedName;
  bool isMoreRecipeLoading = false;
  int recipeCount = 0;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _getData();
    _scrollController.addListener(_onScroll);

    super.initState();
  }

  _onScroll() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      _getRecipe();
    }
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
        categoryListAll = response.data!;
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {}
  }

  Future _getRecipe() async {
    recipeCount = recipeCount + 10;
    isMoreRecipeLoading = false;
    try {
      RecipeRes response =
          await RecipeRepository().getRecipesApiCall(count: recipeCount);
      if (response.data.isNotEmpty) {
        recipeList = response.data;
        recipeListAll = response.data;
        _checkForUserRecipeLike();
        if (recipeList.length == recipeCount) {
          isMoreRecipeLoading = true;
        }
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

  @override
  void dispose() {
    _debounce?.cancel();

    super.dispose();
  }

  _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 1000), () {
      searchedName = query;
      _getRecipeForSearch();
    });
  }

  Future _getRecipeForSearch() async {
    isMoreRecipeLoading = false;
    try {
      setState(() {
        isLoading = true;
      });
      RecipeRes response = await RecipeRepository()
          .getRecipesApiCall(count: recipeCount, search: searchedName);
      if (response.data.isNotEmpty) {
        recipeList = response.data;
        recipeListAll = response.data;
        _checkForUserRecipeLike();
        _getSearchedRecipe();
        if (recipeList.length == recipeCount) {
          isMoreRecipeLoading = true;
        }
      }
      return response;
    } catch (e) {
      debugPrint(e.toString());
    } finally {}
  }

  _getSearchedRecipe() {
    setState(() {
      isRecipeLoading = true;
    });
    recipeList = [];
    categoryList = [];
    for (int i = 0; i < recipeListAll.length; i++) {
      if (recipeListAll[i].nameDish!.toString().contains(searchedName!)) {
        recipeList.add(recipeListAll[i]);
        for (int j = 0; j < recipeListAll[i].categories!.length; j++) {
          var contain = categoryList.where(
            (element) => element.name == recipeListAll[i].categories![j],
          );
          if (contain.isEmpty) {
            categoryList.insert(
                0,
                CategoryData(
                  id: "0",
                  name: recipeListAll[i].categories![j],
                ));
            categoryList[0].name = recipeListAll[i].categories![j];
          }
        }
      }
    }
    setState(() {
      isRecipeLoading = false;
      isLoading = false;
    });
  }

  _getCategoryRecipe() async {
    setState(() {
      isRecipeLoading = true;
    });
    await Future.delayed(const Duration(seconds: 1)).then((value) {
      recipeList = [];
      categoryList = [];
      categoryList.insert(
        0,
        CategoryData(id: "0", name: selectedCategory!.name),
      );
      categoryList[0].name = selectedCategory!.name;
      for (int i = 0; i < recipeListAll.length; i++) {
        for (int j = 0; j < recipeListAll[i].categories!.length; j++) {
          if (recipeListAll[i].categories![j] == selectedCategory!.name) {
            recipeList.add(recipeListAll[i]);
          }
        }
      }
    });

    setState(() {
      isRecipeLoading = false;
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
        controller: _scrollController,
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
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            isRecipeLoading == false
                ? searchedName == null || searchedName == ""
                    ? ListView.builder(
                        itemCount: recipeList.length + 1,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return (index < recipeList.length)
                              ? recipeList[index].isApproved == "1"
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
                                  : const SizedBox()
                              : (isMoreRecipeLoading)
                                  ? recipeSkeleton(context: context)
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
                      return recipeSkeleton(context: context);
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
        GestureDetector(
          onTap: () {
            selectedCategory = category;
            _getCategoryRecipe();
          },
          child: Container(
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
        ),
        const SizedBox(
          height: 10,
        ),
        ListView.builder(
          itemCount: recipeList.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return recipeList[index].isApproved == "1"
                ? GestureDetector(
                    onTap: () async {
                      var response = await Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.leftToRight,
                          duration: Duration(
                              milliseconds: AppConstant.pageAnimationDuration),
                          child: RecipeDetailScreen(
                            recipeData: recipeList[index],
                          ),
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
                    child: recipeListWidget(
                        isFromRecipe: true,
                        context: context,
                        recipeData: recipeList[index],
                        onTap: () {
                          if (recipeList[index].isLikedByMe == true) {
                            _recipeUnlike(
                                recipeID: recipeList[index].id, index: index);
                          } else {
                            _recipeLike(
                              recipeID: recipeList[index].id,
                              index: index,
                            );
                          }
                        }),
                  )
                : const SizedBox();
          },
        )
      ],
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
