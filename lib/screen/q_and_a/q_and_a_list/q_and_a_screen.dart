import 'dart:async';
import 'package:app/api/repository/q_and_a/q_and_a.dart';
import 'package:app/models/q_and_a/question_model.dart';
import 'package:app/models/recipe/like_unlike/like_unlike_model.dart';
import 'package:app/screen/q_and_a/add_question/add_question.dart';
import 'package:app/utility/color.dart';
import 'package:app/utility/constant.dart';
import 'package:app/widgets/common_drawer.dart';
import 'package:app/widgets/common_skeleton.dart';
import 'package:app/widgets/custom_app_bar.dart';
import 'package:app/widgets/question_widget.dart';
import 'package:app/widgets/search_text_field.dart';
import 'package:app/widgets/show_progress_bar.dart';
import 'package:flutter/material.dart';

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
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddQuestionsScreen(),
            ),
          );
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
                    hintText: 'Search for Topics',
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
                    ? questionList.isNotEmpty
                        ? ListView.builder(
                            shrinkWrap: true,
                            itemCount: questionList.length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return searchedName == null || searchedName == ""
                                  ? questionWidget(
                                      context: context,
                                      isComment: true,
                                      questionData: questionList[index],
                                      onLikeUnlikeTap: () {
                                        if (questionList[index].isLikedByMe ==
                                            true) {
                                          _questionUnlike(index: index);
                                        } else {
                                          _questionLike(index: index);
                                        }
                                      },
                                    )
                                  : searchedName!.contains(
                                          questionList[index].questionTitle!)
                                      ? questionWidget(
                                          context: context,
                                          isComment: true,
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
                      )
              ],
            ),
          ),
          isApiLoading ? const ShowProgressBar() : const SizedBox()
        ],
      ),
    );
  }

  _questionLike({int? index}) async {
    try {
      setState(() {
        isApiLoading = true;
      });
      LikeUnlikeRes response = await QAndARepository()
          .questionLikeApiCall(questionID: questionList[index!].id.toString());
      if (response.success == true) {
        questionList[index].likeCount =
            (int.parse(questionList[index].likeCount!) + 1).toString();
        questionList[index].isLikedByMe = true;
        toastShow(message: response.message);
      } else {
        toastShow(message: response.message);
        if (response.message!.trim() == "You are already Like This Question.") {
          questionList[index].likeCount =
              (int.parse(questionList[index].likeCount!) + 1).toString();
          questionList[index].isLikedByMe = true;
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

  _questionUnlike({int? index}) async {
    try {
      setState(() {
        isApiLoading = true;
      });
      LikeUnlikeRes response = await QAndARepository().questionUnlikeApiCall(
          questionID: questionList[index!].id.toString());
      if (response.success == true) {
        questionList[index].likeCount =
            (int.parse(questionList[index].likeCount!) - 1).toString();
        questionList[index].isLikedByMe = true;
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
