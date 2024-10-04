import 'package:app/api/repository/article/article.dart';
import 'package:app/api/repository/banner/banner.dart';
import 'package:app/api/repository/recipe/recipe.dart';
import 'package:app/models/banner/banner_model.dart';
import 'package:app/models/recipe/like_unlike/like_unlike_model.dart';
import 'package:app/models/recipe/recipe_model.dart';
import 'package:app/screen/article/detail/article_detail_screen.dart';
import 'package:app/screen/article/search/search_screen.dart';
import 'package:app/screen/recipe/detail/recipe_detail_screen.dart';
import 'package:app/screen/search/search_screen.dart';
import 'package:app/utility/color.dart';
import 'package:app/utility/constant.dart';
import 'package:app/utility/images.dart';
import 'package:app/widgets/common_drawer.dart';
import 'package:app/widgets/custom_app_bar.dart';
import 'package:app/widgets/recipe_list_widget.dart';
import 'package:app/widgets/recipe_skeleton.dart';
import 'package:app/widgets/show_progress_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:page_transition/page_transition.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List mainBannerList = [Images.slider, Images.slider, Images.slider];
  List<BannerData> bannerList = [];
  List<RecipeData> recipeList = [];
  List<RecipeData> articleList = [];
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final ScrollController _scrollController = ScrollController();
  bool isRecipe = true;
  bool isBannerLoading = false;
  bool isRecipeLoading = false;
  bool isLoading = false;
  bool isMoreRecipeLoading = false;
  bool isMoreArticleLoading = false;
  int recipeCount = 0;
  int articleCount = 0;
  @override
  void initState() {
    _getData();
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  _getData() async {
    setState(() {
      isBannerLoading = true;
      isRecipeLoading = true;
    });
    await _getBanners();
    await _getRecipeList();
    await _getArticleList();
  }

  Future _getBanners() async {
    try {
      BannerRes response = await BannerRepository().getBannerApiCall();
      if (response.data.isNotEmpty) {
        bannerList = response.data;
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      if (mounted) {
        setState(() {
          isBannerLoading = false;
        });
      }
    }
  }

  Future _getRecipeList() async {
    recipeCount = recipeCount + 10;
    isMoreRecipeLoading = false;
    try {
      RecipeRes response =
          await RecipeRepository().getRecipesApiCall(count: recipeCount);
      if (response.data.isNotEmpty) {
        recipeList = response.data;
        _checkForUserRecipeLike();

        if (recipeList.length == recipeCount) {
          isMoreRecipeLoading = true;
        }
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

  Future _getArticleList() async {
    articleCount = articleCount + 10;
    isMoreArticleLoading = false;
    try {
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
          isRecipeLoading = false;
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

  Future<void> _pullRefresh() async {
    setState(() {
      isRecipeLoading = true;
    });
    await _getRecipeList();
    await _getArticleList();
  }

  _onScroll() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      if (isRecipe) {
        _getRecipeList();
      } else {
        _getArticleList();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _pullRefresh,
      child: Scaffold(
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
              controller: _scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (isRecipe) {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.leftToRight,
                            duration: Duration(
                                milliseconds:
                                    AppConstant.pageAnimationDuration),
                            child: const SearchScreen(),
                          ),
                        );
                      } else {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.leftToRight,
                            duration: Duration(
                                milliseconds:
                                    AppConstant.pageAnimationDuration),
                            child: const ArticleSearchScreen(),
                          ),
                        );
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      width: MediaQuery.of(context).size.width,
                      height: 45,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        color: ColorConstant.white,
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(
                            width: 1, color: ColorConstant.greyColor),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            Icon(
                              Icons.search,
                              color: ColorConstant.greyColor,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Search for Recipes/Community",
                              style: TextStyle(
                                  fontSize: 12,
                                  color: ColorConstant.greyColor,
                                  fontWeight: FontWeight.w400),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: isBannerLoading ? errorImageBuilder() : mainSlider(),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * .75,
                          height: 35,
                          decoration: BoxDecoration(
                            color: ColorConstant.greyColor.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if (isRecipe == false) {
                                    setState(() {
                                      isRecipeLoading = true;
                                      isRecipe = true;
                                    });
                                    Future.delayed(const Duration(seconds: 1))
                                        .then((value) {
                                      setState(() {
                                        isRecipeLoading = false;
                                      });
                                    });
                                  }
                                },
                                child: Container(
                                  height: 35,
                                  width:
                                      MediaQuery.of(context).size.width * .375,
                                  decoration: BoxDecoration(
                                    color: isRecipe
                                        ? ColorConstant.mainColor
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Recipe",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: isRecipe
                                            ? ColorConstant.white
                                            : ColorConstant.black,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (isRecipe == true) {
                                    setState(() {
                                      isRecipeLoading = true;
                                      isRecipe = false;
                                    });
                                    Future.delayed(
                                      const Duration(seconds: 1),
                                    ).then((value) {
                                      setState(() {
                                        isRecipeLoading = false;
                                      });
                                    });
                                  }
                                },
                                child: Container(
                                  height: 35,
                                  width:
                                      MediaQuery.of(context).size.width * .375,
                                  decoration: BoxDecoration(
                                    color: !isRecipe
                                        ? ColorConstant.mainColor
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Community",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: !isRecipe
                                            ? ColorConstant.white
                                            : ColorConstant.greyDarkColor,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  isRecipeLoading == false
                      ? isRecipe
                          ? ListView.builder(
                              itemCount: recipeList.length + 1,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return (index < recipeList.length)
                                    ? recipeList[index].isApproved == "1"
                                        ? GestureDetector(
                                            onTap: () async {
                                              var response =
                                                  await Navigator.push(
                                                context,
                                                PageTransition(
                                                  type: PageTransitionType
                                                      .leftToRight,
                                                  duration: Duration(
                                                      milliseconds: AppConstant
                                                          .pageAnimationDuration),
                                                  child: RecipeDetailScreen(
                                                    recipeData:
                                                        recipeList[index],
                                                  ),
                                                ),
                                              );
                                              if (response != null) {
                                                if (response == 0 &&
                                                    recipeList[index]
                                                            .isLikedByMe ==
                                                        false) {
                                                  recipeList[index]
                                                      .isLikedByMe = true;
                                                  recipeList[index].likeCount =
                                                      recipeList[index]
                                                              .likeCount! +
                                                          1;
                                                } else if (response == 1 &&
                                                    recipeList[index]
                                                            .isLikedByMe ==
                                                        true) {
                                                  recipeList[index]
                                                      .isLikedByMe = false;
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
                                                            recipeList[index]
                                                                .id,
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
                                        : const SizedBox()
                                    : (isMoreRecipeLoading)
                                        ? recipeSkeleton(context: context)
                                        : const SizedBox();
                              },
                            )
                          : ListView.builder(
                              itemCount: articleList.length + 1,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return (index < articleList.length)
                                    ? GestureDetector(
                                        onTap: () async {
                                          if (articleList[index].featured ==
                                              1) {
                                          } else {
                                            var response = await Navigator.push(
                                              context,
                                              PageTransition(
                                                type: PageTransitionType
                                                    .leftToRight,
                                                duration: Duration(
                                                    milliseconds: AppConstant
                                                        .pageAnimationDuration),
                                                child: ArticleDetailScreen(
                                                  articleDate:
                                                      articleList[index],
                                                ),
                                              ),
                                            );
                                            if (response != null) {
                                              if (response == 0 &&
                                                  articleList[index]
                                                          .isLikedByMe ==
                                                      false) {
                                                articleList[index].isLikedByMe =
                                                    true;
                                                articleList[index].likeCount =
                                                    articleList[index]
                                                            .likeCount! +
                                                        1;
                                              } else if (response == 1 &&
                                                  articleList[index]
                                                          .isLikedByMe ==
                                                      true) {
                                                articleList[index].isLikedByMe =
                                                    false;
                                                articleList[index].likeCount =
                                                    articleList[index]
                                                            .likeCount! -
                                                        1;
                                              }
                                              setState(() {});
                                            }
                                          }
                                        },
                                        child: recipeListWidget(
                                            isArticle: true,
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
                                    : (isMoreArticleLoading)
                                        ? recipeSkeleton(context: context)
                                        : const SizedBox();
                              },
                            )
                      : ListView.builder(
                          itemCount: 10,
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
      ),
    );
  }

  Widget mainSlider() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 1,
      height: MediaQuery.of(context).size.height * .23,
      child: Swiper(
        autoplay: true,
        duration: 1000,
        scale: 0.75,
        pagination: const SwiperPagination(),
        viewportFraction: 1,
        itemCount: bannerList.length,
        onTap: (index) {
          print("saad ${bannerList[index].bannerType}");
          if (bannerList[index].bannerType == "link") {
            launchUrl(Uri.parse(bannerList[index].url!));
          } else if (bannerList[index].bannerType == "recipe") {
            for (int i = 0; i < recipeList.length; i++) {
              if (bannerList[index].recipeID == recipeList[i].id) {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.leftToRight,
                    duration: Duration(
                        milliseconds: AppConstant.pageAnimationDuration),
                    child: RecipeDetailScreen(
                      recipeData: recipeList[i],
                    ),
                  ),
                );
              }
            }
          } else if (bannerList[index].bannerType == "artical") {
            for (int i = 0; i < articleList.length; i++) {
              if (bannerList[index].articleID == articleList[i].id) {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.leftToRight,
                    duration: Duration(
                        milliseconds: AppConstant.pageAnimationDuration),
                    child: ArticleDetailScreen(
                      articleDate: articleList[i],
                    ),
                  ),
                );
              }
            }
          } else if (bannerList[index].bannerType == "home_maker") {
            // for (int i = 0; i < articleList.length; i++) {
            //   if (bannerList[index].articleID == articleList[i].id) {
            //     Navigator.push(
            //       context,
            //       PageTransition(
            //         type: PageTransitionType.leftToRight,
            //         duration: Duration(
            //             milliseconds: AppConstant.pageAnimationDuration),
            //         child: ArticleDetailScreen(
            //           articleDate: articleList[i],
            //         ),
            //       ),
            //     );
            //   }
            // }
          }
        },
        itemBuilder: (context, index) {
          return CachedNetworkImage(
            imageUrl: "${AppConstant.imagePath}${bannerList[index].image!}",
            imageBuilder: (context, imageProvider) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  width: MediaQuery.of(context).size.width * .75,
                  height: MediaQuery.of(context).size.height * .25,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(5),
                    ),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
            placeholder: (context, url) {
              return errorImageBuilder();
            },
            errorWidget: (context, url, error) {
              return errorImageBuilder();
            },
          );
        },
      ),
    );
  }

  Widget errorImageBuilder() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(right: 10, left: 10, top: 10, bottom: 10),
      child: SkeletonTheme(
        themeMode: ThemeMode.light,
        child: SkeletonAvatar(
          style: SkeletonAvatarStyle(
            shape: BoxShape.rectangle,
            height: MediaQuery.of(context).size.height * .24,
            width: MediaQuery.of(context).size.width * 1,
          ),
        ),
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
        toastShow(message: response.message);
        if (response.message!.trim() == "You are already like this recipe.") {
          recipeList[index!].likeCount = recipeList[index].likeCount! + 1;
          recipeList[index].isLikedByMe = true;
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        recipeList[index!].isLoading = false;
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
      } else {
        toastShow(message: response.message);
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        recipeList[index!].isLoading = false;
      });
    }
  }

  _articleLike({String? articleID, int? index}) async {
    try {
      setState(() {
        articleList[index!].isLoading = true;
      });
      LikeUnlikeRes response =
          await ArticleRepository().articleLikeApiCall(articleID: articleID);
      if (response.success == true) {
        articleList[index!].likeCount = articleList[index].likeCount! + 1;
        articleList[index].isLikedByMe = true;
      } else {
        toastShow(message: response.message);
        if (response.message!.trim() == "You are already like this article.") {
          articleList[index!].likeCount = articleList[index].likeCount! + 1;
          articleList[index].isLikedByMe = true;
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        articleList[index!].isLoading = false;
      });
    }
  }

  _articleUnlike({String? articleID, int? index}) async {
    try {
      setState(() {
        articleList[index!].isLoading = true;
      });
      LikeUnlikeRes response =
          await ArticleRepository().articleUnlikeApiCall(articleID: articleID);
      if (response.success == true) {
        articleList[index!].likeCount = articleList[index].likeCount! - 1;
        articleList[index].isLikedByMe = false;
      } else {
        toastShow(message: response.message);
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        articleList[index!].isLoading = false;
      });
    }
  }
}
