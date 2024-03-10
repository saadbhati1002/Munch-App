import 'dart:convert';

import 'package:app/api/repository/q_and_a/q_and_a.dart';
import 'package:app/models/q_and_a/question_model.dart';
import 'package:app/models/q_and_a/reply/reply_model.dart';
import 'package:app/models/q_and_a/reply_add/reply_add_model.dart';
import 'package:app/models/recipe/like_unlike/like_unlike_model.dart';
import 'package:app/utility/color.dart';
import 'package:app/utility/constant.dart';
import 'package:app/widgets/app_bar_back.dart';
import 'package:app/widgets/common_skeleton.dart';
import 'package:app/widgets/question_widget.dart';
import 'package:app/widgets/reply_widget.dart';
import 'package:app/widgets/search_text_field.dart';
import 'package:app/widgets/show_progress_bar.dart';
import 'package:flutter/material.dart';

class QuestionReplyScreen extends StatefulWidget {
  final QuestionData? questionData;
  const QuestionReplyScreen({super.key, this.questionData});

  @override
  State<QuestionReplyScreen> createState() => _QuestionReplyScreenState();
}

class _QuestionReplyScreenState extends State<QuestionReplyScreen> {
  TextEditingController replyController = TextEditingController();
  bool isLoading = false;
  bool isApiLoading = false;
  List<ReplyData> replyList = [];
  @override
  void initState() {
    _getReply();
    super.initState();
  }

  Future _getReply() async {
    try {
      setState(() {
        isLoading = true;
      });
      ReplyRes response = await QAndARepository()
          .getRelyListApiCall(questionID: widget.questionData!.id.toString());
      if (response.data!.isNotEmpty) {
        widget.questionData!.replyCount = response.data!.length.toString();
        replyList = response.data!;
        _checkForUserReplyLike();
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future _checkForUserReplyLike() async {
    for (int i = 0; i < replyList.length; i++) {
      var contain = replyList[i].likedUsers.where(
          (element) => element.id.toString() == AppConstant.userData!.id);
      if (contain.isNotEmpty) {
        replyList[i].isLikedByMe = true;
      }
    }
    setState(() {});
    return replyList;
  }

  Future<bool> willPopScope() {
    Navigator.pop(context, json.encode(widget.questionData));

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
            Navigator.pop(context, json.encode(widget.questionData));
          },
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(left: 30),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: CustomSearchTextField(
              controller: replyController,
              borderRadius: 10,
              context: context,
              hintText: "Write your reply",
              suffix: GestureDetector(
                onTap: () {
                  _questionReply();
                },
                child: const Icon(
                  Icons.send,
                  size: 23,
                  color: ColorConstant.black,
                ),
              ),
            ),
          ),
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  questionWidget(
                    context: context,
                    isReply: true,
                    questionData: widget.questionData,
                    onLikeUnlikeTap: () {
                      if (widget.questionData!.isLikedByMe == true) {
                        _questionUnlike();
                      } else {
                        _questionLike();
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  isLoading == false
                      ? replyList.isNotEmpty
                          ? ListView.builder(
                              shrinkWrap: true,
                              itemCount: replyList.length,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return replyWidget(
                                    context: context,
                                    replyData: replyList[index],
                                    onLikeUnlikeTap: () {
                                      if (replyList[index].isLikedByMe ==
                                          true) {
                                        _replyUnlike(index: index);
                                      } else {
                                        _replyLike(index: index);
                                      }
                                    });
                              },
                            )
                          : SizedBox(
                              height: MediaQuery.of(context).size.height * .45,
                              width: MediaQuery.of(context).size.width * 1,
                              child: const Center(
                                child: Text(
                                  "No Reply Found",
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
                ],
              ),
            ),
            isApiLoading ? const ShowProgressBar() : const SizedBox()
          ],
        ),
      ),
    );
  }

  _questionLike() async {
    try {
      setState(() {
        isApiLoading = true;
      });
      LikeUnlikeRes response = await QAndARepository()
          .questionLikeApiCall(questionID: widget.questionData!.id.toString());
      if (response.success == true) {
        widget.questionData!.likeCount =
            (int.parse(widget.questionData!.likeCount!) + 1).toString();
        widget.questionData!.isLikedByMe = true;
        toastShow(message: response.message);
      } else {
        toastShow(message: response.message);
        if (response.message!.trim() == "You are already Like This Question.") {
          widget.questionData!.likeCount =
              (int.parse(widget.questionData!.likeCount!) + 1).toString();
          widget.questionData!.isLikedByMe = true;
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

  _questionUnlike() async {
    try {
      setState(() {
        isApiLoading = true;
      });
      LikeUnlikeRes response = await QAndARepository().questionUnlikeApiCall(
          questionID: widget.questionData!.id.toString());
      if (response.success == true) {
        widget.questionData!.likeCount =
            (int.parse(widget.questionData!.likeCount!) - 1).toString();
        widget.questionData!.isLikedByMe = false;
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

  _replyLike({int? index}) async {
    try {
      setState(() {
        isApiLoading = true;
      });
      LikeUnlikeRes response = await QAndARepository()
          .replyLikeApiCall(replyID: replyList[index!].id.toString());
      if (response.success == true) {
        replyList[index].likeCount =
            (int.parse(replyList[index].likeCount!) + 1).toString();
        replyList[index].isLikedByMe = true;
        toastShow(message: response.message);
      } else {
        toastShow(message: response.message);
        if (response.message!.trim() == "You are already Like This Reply.") {
          replyList[index].likeCount =
              (int.parse(replyList[index].likeCount!) + 1).toString();
          replyList[index].isLikedByMe = true;
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

  _replyUnlike({int? index}) async {
    try {
      setState(() {
        isApiLoading = true;
      });
      LikeUnlikeRes response = await QAndARepository()
          .replyUnlikeApiCall(replyID: replyList[index!].id.toString());
      if (response.success == true) {
        replyList[index].likeCount =
            (int.parse(replyList[index].likeCount!) - 1).toString();
        replyList[index].isLikedByMe = false;
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

  Future _questionReply() async {
    if (replyController.text.isEmpty) {
      toastShow(message: "Please enter your reply");
      return;
    }
    try {
      FocusManager.instance.primaryFocus?.unfocus();

      setState(() {
        isApiLoading = true;
      });
      ReplyAddRes response = await QAndARepository().addReplyApiCall(
        questionID: widget.questionData!.id.toString(),
        reply: replyController.text.toString().trim(),
      );
      if (response.success == true) {
        replyList.add(ReplyData());
        replyController.clear();
        replyList[replyList.length - 1].id = response.data!.id;
        replyList[replyList.length - 1].isLikedByMe = false;
        replyList[replyList.length - 1].likeCount = '0';
        replyList[replyList.length - 1].likedUsers = [];
        replyList[replyList.length - 1].questionId =
            widget.questionData!.id.toString();
        replyList[replyList.length - 1].questionTitle =
            widget.questionData!.questionTitle;
        replyList[replyList.length - 1].replyText =
            replyController.text.toString().trim();
        replyList[replyList.length - 1].user = AppConstant.userData!.name;
        replyList[replyList.length - 1].userImage = AppConstant.userData!.image;

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
