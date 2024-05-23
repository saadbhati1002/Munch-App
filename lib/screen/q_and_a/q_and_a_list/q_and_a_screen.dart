import 'dart:async';
import 'dart:convert';
import 'package:app/api/repository/q_and_a/q_and_a.dart';
import 'package:app/models/q_and_a/add/add_question_model.dart';
import 'package:app/models/q_and_a/question_model.dart';
import 'package:app/models/recipe/like_unlike/like_unlike_model.dart';
import 'package:app/screen/q_and_a/add_question/add_question.dart';
import 'package:app/screen/q_and_a/question_reply/question_reply_screen.dart';
import 'package:app/utility/color.dart';
import 'package:app/utility/constant.dart';
import 'package:app/widgets/common_drawer.dart';
import 'package:app/widgets/common_skeleton.dart';

import 'package:app/widgets/custom_app_bar.dart';
import 'package:app/widgets/question_widget.dart';
import 'package:app/widgets/search_text_field.dart';
import 'package:app/widgets/show_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletons/skeletons.dart';

class QuestionAndAnswerScreen extends StatefulWidget {
  const QuestionAndAnswerScreen({super.key});

  @override
  State<QuestionAndAnswerScreen> createState() =>
      _QuestionAndAnswerScreenState();
}

class _QuestionAndAnswerScreenState extends State<QuestionAndAnswerScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  List<QuestionData> questionList = [];
  bool isLoading = false;
  bool isApiLoading = false;
  Timer? _debounce;
  String? searchedName;
  @override
  void initState() {
    _getQuestionList();
    super.initState();
  }

  _getQuestionList() async {
    try {
      setState(() {
        isLoading = true;
      });
      QuestionRes response = await QAndARepository().getQuestionListApiCall();
      if (response.data!.isNotEmpty) {
        setState(() {
          questionList = response.data!;
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
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
      endDrawer: const CommonDrawer(),
      key: _key,
      backgroundColor: ColorConstant.backGroundColor,
      appBar: customAppBar(
        _key,
        context: context,
      ),
      floatingActionButton: GestureDetector(
        onTap: () async {
          var response = await Get.to(
            () => const AddQuestionsScreen(),
          );

          if (response != null) {
            try {
              AddQuestionData addedQuestionData = AddQuestionData.fromJson(
                jsonDecode(response),
              );

              questionList.add(
                QuestionData(
                  id: addedQuestionData.id,
                  likeCount: "0",
                  likedUsers: [],
                  questionTitle: addedQuestionData.questionTitle,
                  questionAnswer: addedQuestionData.questionAnswer,
                  replyCount: "0",
                  user: AppConstant.userData!.name,
                  userImage: AppConstant.userData!.image,
                ),
              );
              questionList[questionList.length - 1].id = addedQuestionData.id;
              questionList[questionList.length - 1].likeCount = '0';
              questionList[questionList.length - 1].likedUsers = [];
              questionList[questionList.length - 1].questionTitle =
                  addedQuestionData.questionTitle;
              questionList[questionList.length - 1].questionAnswer =
                  addedQuestionData.questionAnswer;
              questionList[questionList.length - 1].user =
                  AppConstant.userData!.name;
              questionList[questionList.length - 1].userImage =
                  AppConstant.userData!.image;
            } catch (e) {
              debugPrint(e.toString());
            }

            setState(() {});
          }
        },
        child: Container(
            height: 38,
            margin: const EdgeInsets.only(bottom: 60),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: ColorConstant.mainColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Add a question",
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
                    'Q&A',
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
                    hintText: 'Search for Topics',
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
                    ? questionList.isNotEmpty
                        ? ListView.builder(
                            shrinkWrap: true,
                            itemCount: questionList.length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return searchedName == null || searchedName == ""
                                  ? GestureDetector(
                                      onTap: () async {
                                        var response = await Get.to(
                                          () => QuestionReplyScreen(
                                            questionData: questionList[index],
                                          ),
                                        );
                                        if (response != null) {
                                          QuestionData questionResponse =
                                              QuestionData.fromJson(
                                                  jsonDecode(response));
                                          questionList[index].isLikedByMe =
                                              questionResponse.isLikedByMe;
                                          questionList[index].likeCount =
                                              questionResponse.likeCount;
                                          questionList[index].replyCount =
                                              questionResponse.replyCount;
                                          setState(() {});
                                        }
                                      },
                                      child: questionWidget(
                                        context: context,
                                        isReply: false,
                                        questionData: questionList[index],
                                        onLikeUnlikeTap: () {
                                          if (questionList[index].isLikedByMe ==
                                              true) {
                                            _questionUnlike(index: index);
                                          } else {
                                            _questionLike(index: index);
                                          }
                                        },
                                      ),
                                    )
                                  : searchedName!.contains(
                                          questionList[index].questionTitle!)
                                      ? GestureDetector(
                                          onTap: () async {
                                            var response = await Get.to(
                                              () => QuestionReplyScreen(
                                                questionData:
                                                    questionList[index],
                                              ),
                                            );
                                            if (response != null) {
                                              QuestionData questionResponse =
                                                  QuestionData.fromJson(
                                                      jsonDecode(response));
                                              questionList[index].isLikedByMe =
                                                  questionResponse.isLikedByMe;
                                              questionList[index].likeCount =
                                                  questionResponse.likeCount;
                                              questionList[index].replyCount =
                                                  questionResponse.replyCount;
                                              setState(() {});
                                            }
                                          },
                                          child: questionWidget(
                                            context: context,
                                            isReply: false,
                                            questionData: questionList[index],
                                            onLikeUnlikeTap: () {
                                              if (questionList[index]
                                                      .isLikedByMe ==
                                                  true) {
                                                _questionUnlike(index: index);
                                              } else {
                                                _questionLike(index: index);
                                              }
                                            },
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
                                "No Question Found",
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
                      ),
                const SizedBox(
                  height: 60,
                ),
              ],
            ),
          ),
          isApiLoading ? const ShowProgressBar() : const SizedBox()
        ],
      ),
    );
  }

  Widget questionSkeleton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      child: Material(
        elevation: 1,
        borderRadius: BorderRadius.circular(10),
        shadowColor: ColorConstant.mainColor,
        child: Container(
          height: MediaQuery.of(context).size.height * .23,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 0.5, color: ColorConstant.mainColor),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SkeletonAvatar(
                        style: SkeletonAvatarStyle(
                          width: 30,
                          height: 30,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 10),
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 15,
                          randomLength: false,
                          borderRadius: BorderRadius.circular(10),
                          width: MediaQuery.of(context).size.width * .25,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .025,
                  ),
                  SkeletonLine(
                    style: SkeletonLineStyle(
                      height: 15,
                      randomLength: false,
                      borderRadius: BorderRadius.circular(10),
                      width: MediaQuery.of(context).size.width * .85,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .01,
                  ),
                  SkeletonLine(
                    style: SkeletonLineStyle(
                      height: 15,
                      randomLength: false,
                      borderRadius: BorderRadius.circular(10),
                      width: MediaQuery.of(context).size.width * .85,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .01,
                  ),
                  SkeletonLine(
                    style: SkeletonLineStyle(
                      height: 15,
                      randomLength: true,
                      borderRadius: BorderRadius.circular(10),
                      width: MediaQuery.of(context).size.width * .85,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 15,
                          randomLength: false,
                          borderRadius: BorderRadius.circular(10),
                          width: MediaQuery.of(context).size.width * .35,
                        ),
                      ),
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 15,
                          randomLength: false,
                          borderRadius: BorderRadius.circular(10),
                          width: MediaQuery.of(context).size.width * .35,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _questionLike({int? index}) async {
    try {
      setState(() {
        questionList[index!].isLoading = true;
      });
      LikeUnlikeRes response = await QAndARepository()
          .questionLikeApiCall(questionID: questionList[index!].id.toString());
      if (response.success == true) {
        questionList[index].likeCount =
            (int.parse(questionList[index].likeCount!) + 1).toString();
        questionList[index].isLikedByMe = true;
        // toastShow(message: response.message);
      } else {
        toastShow(message: response.message);
        if (response.message!.trim() == "You are already like this question.") {
          questionList[index].likeCount =
              (int.parse(questionList[index].likeCount!) + 1).toString();
          questionList[index].isLikedByMe = true;
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        questionList[index!].isLoading = false;
      });
    }
  }

  _questionUnlike({int? index}) async {
    try {
      setState(() {
        questionList[index!].isLoading = true;
      });
      LikeUnlikeRes response = await QAndARepository().questionUnlikeApiCall(
          questionID: questionList[index!].id.toString());
      if (response.success == true) {
        questionList[index].likeCount =
            (int.parse(questionList[index].likeCount!) - 1).toString();
        questionList[index].isLikedByMe = false;
        // toastShow(message: response.message);
      } else {
        toastShow(message: response.message);
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        questionList[index!].isLoading = false;
      });
    }
  }
}
