import 'package:app/api/repository/article/article.dart';
import 'package:app/models/recipe/like_unlike/like_unlike_model.dart';
import 'package:app/models/recipe/recipe_model.dart';
import 'package:app/screen/article/comments/comments_screen.dart';
import 'package:app/screen/video_player/video_player_screen.dart';
import 'package:app/utility/color.dart';
import 'package:app/utility/constant.dart';
import 'package:app/widgets/app_bar_back.dart';
import 'package:app/widgets/custom_image_view.dart';
import 'package:app/widgets/custom_image_view_circular.dart';
import 'package:app/widgets/micro_loader.dart';
import 'package:app/widgets/show_progress_bar.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';

class ArticleDetailScreen extends StatefulWidget {
  final RecipeData? articleDate;
  const ArticleDetailScreen({super.key, this.articleDate});

  @override
  State<ArticleDetailScreen> createState() => _ArticleDetailScreenState();
}

class _ArticleDetailScreenState extends State<ArticleDetailScreen> {
  bool isLoading = false;
  @override
  void initState() {
    setState(() {});
    super.initState();
  }

  Future<bool> willPopScope() {
    Navigator.pop(context, widget.articleDate!.isLikedByMe == true ? 0 : 1);

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
                context, widget.articleDate!.isLikedByMe == true ? 0 : 1);
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
                          imagePath: widget.articleDate!.userImage,
                          height: 35,
                          width: 35,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          widget.articleDate!.user ?? AppConstant.appName,
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
                  if (widget.articleDate!.mediaType == "IMAGE") ...[
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 1,
                      height: MediaQuery.of(context).size.height * .45,
                      child: Swiper(
                        autoplay: false,
                        duration: 1000,
                        scale: 1,
                        pagination: const SwiperPagination(),
                        viewportFraction: 1,
                        itemCount: widget.articleDate!.media.length,
                        onTap: (index) {},
                        itemBuilder: (context, index) {
                          return CustomImage(
                            width: MediaQuery.of(context).size.width * 1,
                            height: MediaQuery.of(context).size.height * .45,
                            imagePath: widget.articleDate!.media[index],
                          );
                        },
                      ),
                    ),
                  ] else ...[
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.leftToRight,
                            duration: Duration(
                                milliseconds:
                                    AppConstant.pageAnimationDuration),
                            child: VideoPlayerScreen(
                              videoPath: widget.articleDate!.media.first,
                            ),
                          ),
                        );
                      },
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 1,
                        height: MediaQuery.of(context).size.height * .45,
                        child: Stack(
                          children: [
                            CustomImage(
                              width: MediaQuery.of(context).size.width * 1,
                              height: MediaQuery.of(context).size.height * .45,
                              imagePath: widget.articleDate!.thumbnail,
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
                    ),
                  ],
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        widget.articleDate!.isLoading == false
                            ? InkWell(
                                onTap: () {
                                  if (widget.articleDate!.isLikedByMe == true) {
                                    _articleUnlike(
                                        articleID: widget.articleDate!.id);
                                  } else {
                                    _articleLike();
                                  }
                                },
                                child: Text(
                                  (widget.articleDate!.likeCount == 0 ||
                                          widget.articleDate!.likeCount == 1)
                                      ? "${widget.articleDate!.likeCount}  Like"
                                      : "${widget.articleDate!.likeCount}  Likes",
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
                                child: ArticleCommentScreen(
                                  articleID: widget.articleDate!.id,
                                  count: widget.articleDate!.commentCount,
                                ),
                              ),
                            );
                            if (response != null && response != "0") {
                              widget.articleDate!.commentCount =
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
                                  (widget.articleDate!.commentCount == 0 ||
                                          widget.articleDate!.commentCount == 1)
                                      ? "${widget.articleDate!.commentCount} Comment"
                                      : "${widget.articleDate!.commentCount} Comment",
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
                    child: Text(
                      widget.articleDate!.nameDish ?? AppConstant.appName,
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
                      widget.articleDate!.tagLine ?? AppConstant.appName,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        color: ColorConstant.greyDarkColor,
                        fontSize: 10,
                      ),
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
                      itemCount: widget.articleDate!.categories!.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return categoryBox(
                            title: widget.articleDate!.categories![index],
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
                      widget.articleDate!.smallDesc ?? "",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
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

  _articleLike() async {
    try {
      setState(() {
        widget.articleDate!.isLoading = true;
      });
      LikeUnlikeRes response = await ArticleRepository()
          .articleLikeApiCall(articleID: widget.articleDate!.id);
      if (response.success == true) {
        widget.articleDate!.likeCount = widget.articleDate!.likeCount! + 1;
        widget.articleDate!.isLikedByMe = true;
      } else {
        if (response.message!.trim() == "You are already like this article.") {
          widget.articleDate!.likeCount = widget.articleDate!.likeCount! + 1;
          widget.articleDate!.isLikedByMe = true;
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        widget.articleDate!.isLoading = false;
      });
    }
  }

  _articleUnlike({
    String? articleID,
  }) async {
    try {
      setState(() {
        widget.articleDate!.isLoading = true;
      });
      LikeUnlikeRes response =
          await ArticleRepository().articleUnlikeApiCall(articleID: articleID);
      if (response.success == true) {
        widget.articleDate!.likeCount = widget.articleDate!.likeCount! - 1;
        widget.articleDate!.isLikedByMe = false;
      } else {}
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        widget.articleDate!.isLoading = false;
      });
    }
  }
}
