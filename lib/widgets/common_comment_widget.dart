import 'package:app/models/recipe/comment/comment_model.dart';
import 'package:app/utility/color.dart';
import 'package:app/utility/constant.dart';

import 'package:app/widgets/custom_image_view_circular.dart';
import 'package:flutter/material.dart';

Widget commonCommentWidget(
    {BuildContext? context,
    bool? isComment,
    CommentData? commentData,
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
                imagePath: commentData!.userImage,
                height: 25,
                width: 25,
              ),
              const SizedBox(
                width: 7,
              ),
              Text(
                commentData.userName ?? AppConstant.appName,
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
            commentData.title ?? AppConstant.appName,
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
            commentData.description ?? AppConstant.appName,
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
                      color: commentData.isLikedByMe
                          ? ColorConstant.mainColor
                          : ColorConstant.greyColor,
                      size: 17,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    "${commentData.count} Likes",
                    style: const TextStyle(
                        fontSize: 12,
                        color: ColorConstant.black,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              isComment == false
                  ? const Text(
                      "20 Replays",
                      style: TextStyle(
                          fontSize: 12,
                          color: ColorConstant.black,
                          fontWeight: FontWeight.w700),
                    )
                  : const SizedBox()
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
