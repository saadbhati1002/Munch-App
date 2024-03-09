import 'dart:async';
import 'dart:convert';

import 'package:app/api/repository/recipe/recipe.dart';
import 'package:app/models/recipe/comment/comment_model.dart';
import 'package:app/models/recipe/like_unlike/like_unlike_model.dart';
import 'package:app/screen/recipe/add_comment/add_comment_screen.dart';
import 'package:app/utility/color.dart';
import 'package:app/utility/constant.dart';
import 'package:app/widgets/app_bar_back.dart';
import 'package:app/widgets/common_comment_widget.dart';
import 'package:app/widgets/common_skeleton.dart';
import 'package:app/widgets/search_text_field.dart';
import 'package:app/widgets/show_progress_bar.dart';
import 'package:flutter/material.dart';

class RecipeCommentsScreen extends StatefulWidget {
  final String? recipeID;
  const RecipeCommentsScreen({super.key, this.recipeID});

  @override
  State<RecipeCommentsScreen> createState() => _RecipeCommentsScreenState();
}

class _RecipeCommentsScreenState extends State<RecipeCommentsScreen> {
  bool isLoading = false;
  bool isApiLoading = false;
  List<CommentData> commentList = [];
  Timer? _debounce;
  String? searchedName;

  @override
  void initState() {
    _getComments();
    super.initState();
  }

  Future _getComments() async {
    try {
      setState(() {
        isLoading = true;
      });
      CommentRes response = await RecipeRepository()
          .getCommentListApiCall(recipeID: widget.recipeID);
      if (response.comments.isNotEmpty) {
        commentList = response.comments;
        await _checkForUserCommentLike();
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future _checkForUserCommentLike() async {
    for (int i = 0; i < commentList.length; i++) {
      commentList[i].count = commentList[i].likedUsers.length;
      var contain = commentList[i].likedUsers.where(
          (element) => element.id.toString() == AppConstant.userData!.id);
      if (contain.isNotEmpty) {
        commentList[i].isLikedByMe = true;
      }
    }
    setState(() {});
    return commentList;
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
      floatingActionButton: GestureDetector(
        onTap: () async {
          var response = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddCommentScreen(
                recipeID: widget.recipeID,
              ),
            ),
          );

          if (response != null) {
            CommentData newComment = CommentData.fromJson(jsonDecode(response));
            commentList.add(newComment);
            setState(() {});
          }
        },
        child: Container(
            height: 38,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: ColorConstant.mainColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Add a Comment",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: ColorConstant.white),
                ),
              ],
            )),
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
                    'Comment',
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
                    'Write, communicate & express',
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
                    hintText: 'Search for User Comments',
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
                isLoading == false
                    ? commentList.isNotEmpty
                        ? ListView.builder(
                            shrinkWrap: true,
                            itemCount: commentList.length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return searchedName == null || searchedName == ""
                                  ? commonCommentWidget(
                                      context: context,
                                      isComment: true,
                                      commentData: commentList[index],
                                      onLikeUnlikeTap: () {
                                        if (commentList[index].isLikedByMe ==
                                            true) {
                                          _commentUnlike(index: index);
                                        } else {
                                          _commentLike(index: index);
                                        }
                                      },
                                    )
                                  : searchedName!.contains(
                                          commentList[index].userName!)
                                      ? commonCommentWidget(
                                          context: context,
                                          isComment: true,
                                          commentData: commentList[index],
                                          onLikeUnlikeTap: () {
                                            if (commentList[index]
                                                    .isLikedByMe ==
                                                true) {
                                              _commentUnlike(index: index);
                                            } else {
                                              _commentLike(index: index);
                                            }
                                          },
                                        )
                                      : const SizedBox();
                            },
                          )
                        : SizedBox(
                            height: MediaQuery.of(context).size.height * .45,
                            width: MediaQuery.of(context).size.width * 1,
                            child: const Center(
                              child: Text(
                                "No Comment Found",
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
          isApiLoading ? const ShowProgressBar() : const SizedBox()
        ],
      ),
    );
  }

  _commentLike({int? index}) async {
    try {
      setState(() {
        isApiLoading = true;
      });
      LikeUnlikeRes response = await RecipeRepository()
          .commentLikeApiCall(commentID: commentList[index!].id.toString());
      if (response.success == true) {
        commentList[index].count = commentList[index].count + 1;
        commentList[index].isLikedByMe = true;
        toastShow(message: response.message);
      } else {
        toastShow(message: response.message);
        if (response.message!.trim() == "You are already Like This Recipy.") {
          commentList[index].count = commentList[index].count + 1;
          commentList[index].isLikedByMe = true;
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isApiLoading = false;
      });
    }
  }

  _commentUnlike({int? index}) async {
    try {
      setState(() {
        isApiLoading = true;
      });
      LikeUnlikeRes response = await RecipeRepository()
          .commentUnlikeApiCall(commentID: commentList[index!].id.toString());
      if (response.success == true) {
        commentList[index].count = commentList[index].count - 1;
        commentList[index].isLikedByMe = false;
        toastShow(message: response.message);
      } else {
        toastShow(message: response.message);
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isApiLoading = false;
      });
    }
  }
}
