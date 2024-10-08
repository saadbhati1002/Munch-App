import 'dart:async';

import 'package:app/api/repository/article/article.dart';
import 'package:app/models/recipe/like_unlike/like_unlike_model.dart';
import 'package:app/models/recipe/recipe_model.dart';
import 'package:app/screen/article/detail/article_detail_screen.dart';
import 'package:app/utility/color.dart';
import 'package:app/utility/constant.dart';
import 'package:app/widgets/app_bar_back.dart';
import 'package:app/widgets/recipe_list_widget.dart';
import 'package:app/widgets/search_text_field.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';
import 'package:page_transition/page_transition.dart';

class ArticleSearchScreen extends StatefulWidget {
  const ArticleSearchScreen({super.key});

  @override
  State<ArticleSearchScreen> createState() => _ArticleSearchScreenState();
}

class _ArticleSearchScreenState extends State<ArticleSearchScreen> {
  List<RecipeData> articleList = [];
  final ScrollController _scrollController = ScrollController();

  Timer? _debounce;
  String? searchedName;
  bool isLoading = false;
  bool isMoreArticleLoading = false;
  int articleCount = 0;

  @override
  void initState() {
    _getArticleList();
    _scrollController.addListener(_onScroll);

    super.initState();
  }

  _onScroll() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      _getArticleList();
    }
  }

  Future _getArticleList() async {
    if (isMoreArticleLoading == false) {
      return;
    }
    articleCount = articleCount + 10;
    isMoreArticleLoading = false;
    try {
      setState(() {
        isLoading = true;
      });
      RecipeRes response =
          await ArticleRepository().getArticlesApiCall(count: articleCount);
      if (response.data.isNotEmpty) {
        articleList = response.data;
        _checkForUserArticleLike();
        if (articleList.length == articleCount) {
          isMoreArticleLoading = true;
        }
      }
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

  _checkForUserArticleLike() {
    for (int i = 0; i < articleList.length; i++) {
      var contain = articleList[i].likedUsers.where(
          (element) => element.id.toString() == AppConstant.userData!.id);
      if (contain.isNotEmpty) {
        articleList[i].isLikedByMe = true;
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
      setState(() {
        searchedName = query;
      });
      _getArticleSearchList();
    });
  }

  Future _getArticleSearchList() async {
    articleCount = articleCount + 10;
    isMoreArticleLoading = false;
    try {
      setState(() {
        isLoading = true;
      });
      RecipeRes response = await ArticleRepository()
          .getArticlesApiCall(count: articleCount, search: searchedName);
      if (response.data.isNotEmpty) {
        articleList = response.data;
        _checkForUserArticleLike();

        if (articleList.length == articleCount) {
          isMoreArticleLoading = true;
        }
      }
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
          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: CustomSearchTextField(
                onChanged: _onSearchChanged,
                context: context,
                hintText: 'Search for Community',
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
            isLoading == false
                ? ListView.builder(
                    itemCount: articleList.length + 1,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return (index < articleList.length)
                          ? searchedName == null || searchedName == ""
                              ? GestureDetector(
                                  onTap: () async {
                                    var response = await Navigator.push(
                                      context,
                                      PageTransition(
                                        type: PageTransitionType.leftToRight,
                                        duration: Duration(
                                            milliseconds: AppConstant
                                                .pageAnimationDuration),
                                        child: ArticleDetailScreen(
                                          articleDate: articleList[index],
                                        ),
                                      ),
                                    );
                                    if (response != null) {
                                      if (response == 0 &&
                                          articleList[index].isLikedByMe ==
                                              false) {
                                        articleList[index].isLikedByMe = true;
                                        articleList[index].likeCount =
                                            articleList[index].likeCount! + 1;
                                      } else if (response == 1 &&
                                          articleList[index].isLikedByMe ==
                                              true) {
                                        articleList[index].isLikedByMe = false;
                                        articleList[index].likeCount =
                                            articleList[index].likeCount! - 1;
                                      }
                                      setState(() {});
                                    }
                                  },
                                  child: recipeListWidget(
                                      context: context,
                                      recipeData: articleList[index],
                                      isFromRecipe: false,
                                      onTap: () {
                                        if (articleList[index].isLikedByMe ==
                                            true) {
                                          _articleUnlike(
                                              articleID: articleList[index].id,
                                              index: index);
                                        } else {
                                          _articleLike(
                                            articleID: articleList[index].id,
                                            index: index,
                                          );
                                        }
                                      }),
                                )
                              : articleList[index]
                                      .nameDish!
                                      .toString()
                                      .toLowerCase()
                                      .contains(searchedName!.toLowerCase())
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
                                            child: ArticleDetailScreen(
                                              articleDate: articleList[index],
                                            ),
                                          ),
                                        );
                                        if (response != null) {
                                          if (response == 0 &&
                                              articleList[index].isLikedByMe ==
                                                  false) {
                                            articleList[index].isLikedByMe =
                                                true;
                                            articleList[index].likeCount =
                                                articleList[index].likeCount! +
                                                    1;
                                          } else if (response == 1 &&
                                              articleList[index].isLikedByMe ==
                                                  true) {
                                            articleList[index].isLikedByMe =
                                                false;
                                            articleList[index].likeCount =
                                                articleList[index].likeCount! -
                                                    1;
                                          }
                                          setState(() {});
                                        }
                                      },
                                      child: recipeListWidget(
                                          context: context,
                                          recipeData: articleList[index],
                                          isFromRecipe: false,
                                          onTap: () {
                                            if (articleList[index]
                                                    .isLikedByMe ==
                                                true) {
                                              _articleUnlike(
                                                  articleID:
                                                      articleList[index].id,
                                                  index: index);
                                            } else {
                                              _articleLike(
                                                articleID:
                                                    articleList[index].id,
                                                index: index,
                                              );
                                            }
                                          }),
                                    )
                                  : const SizedBox()
                          : (isMoreArticleLoading)
                              ? recipeSkeleton()
                              : const SizedBox();
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
          ],
        ),
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

  _articleLike({String? articleID, int? index}) async {
    try {
      setState(() {
        isLoading = true;
      });
      LikeUnlikeRes response =
          await ArticleRepository().articleLikeApiCall(articleID: articleID);
      if (response.success == true) {
        articleList[index!].likeCount = articleList[index].likeCount! + 1;
        articleList[index].isLikedByMe = true;
        // toastShow(message: response.message);
      } else {
        toastShow(message: response.message);
        if (response.message!.trim() == "You are already Like This Artical.") {
          articleList[index!].likeCount = articleList[index].likeCount! + 1;
          articleList[index].isLikedByMe = true;
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

  _articleUnlike({String? articleID, int? index}) async {
    try {
      setState(() {
        isLoading = true;
      });
      LikeUnlikeRes response =
          await ArticleRepository().articleUnlikeApiCall(articleID: articleID);
      if (response.success == true) {
        articleList[index!].likeCount = articleList[index].likeCount! - 1;
        articleList[index].isLikedByMe = false;
        // toastShow(message: response.message);
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
