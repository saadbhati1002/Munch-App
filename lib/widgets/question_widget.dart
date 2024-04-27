import 'package:app/models/q_and_a/question_model.dart';
import 'package:app/utility/color.dart';
import 'package:app/utility/constant.dart';
import 'package:app/widgets/custom_image_view_circular.dart';
import 'package:flutter/material.dart';

Widget questionWidget(
    {BuildContext? context,
    bool? isReply,
    QuestionData? questionData,
    VoidCallback? onLikeUnlikeTap}) {
  return Container(
    width: MediaQuery.of(context!).size.width * 1,
    color: ColorConstant.white,
    child: Column(
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
                imagePath: questionData!.userImage,
                height: 25,
                width: 25,
              ),
              const SizedBox(
                width: 7,
              ),
              Text(
                questionData.user ?? AppConstant.appName,
                style: const TextStyle(
                    fontSize: 13,
                    color: ColorConstant.black,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            questionData.questionTitle ?? AppConstant.appName,
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: ColorConstant.black),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            questionData.questionAnswer ?? AppConstant.appName,
            style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: ColorConstant.black),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: onLikeUnlikeTap,
                    child: Icon(
                      Icons.favorite,
                      color: questionData.isLikedByMe
                          ? ColorConstant.mainColor
                          : ColorConstant.greyColor,
                      size: 17,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    "${questionData.likeCount} Likes",
                    style: const TextStyle(
                        fontSize: 12,
                        color: ColorConstant.black,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              Text(
                "${questionData.replyCount} Reply",
                style: const TextStyle(
                    fontSize: 12,
                    color: ColorConstant.black,
                    fontWeight: FontWeight.w700),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    ),
  );
}
