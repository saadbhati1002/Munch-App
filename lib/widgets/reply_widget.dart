import 'package:app/models/q_and_a/reply/reply_model.dart';
import 'package:app/utility/color.dart';
import 'package:app/utility/constant.dart';
import 'package:app/widgets/custom_image_view_circular.dart';
import 'package:app/widgets/micro_loader.dart';
import 'package:flutter/material.dart';

Widget replyWidget(
    {BuildContext? context,
    ReplyData? replyData,
    VoidCallback? onLikeUnlikeTap}) {
  return Container(
    width: MediaQuery.of(context!).size.width * 1,
    color: Colors.transparent,
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
                imagePath: replyData!.userImage,
                height: 25,
                width: 25,
              ),
              const SizedBox(
                width: 7,
              ),
              Text(
                replyData.user ?? AppConstant.appName,
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
            replyData.replyText ?? AppConstant.appName,
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              !replyData.isLoading
                  ? GestureDetector(
                      onTap: onLikeUnlikeTap,
                      child: Icon(
                        Icons.favorite,
                        color: replyData.isLikedByMe
                            ? ColorConstant.mainColor
                            : ColorConstant.greyColor,
                        size: 17,
                      ),
                    )
                  : microLoader(height: 16, width: 16),
              const SizedBox(
                width: 5,
              ),
              Text(
                (int.parse(replyData.likeCount!) == 0 ||
                        int.parse(replyData.likeCount!) == 1)
                    ? "${replyData.likeCount} Like"
                    : "${replyData.likeCount} Likes",
                style: const TextStyle(
                    fontSize: 12,
                    color: ColorConstant.black,
                    fontWeight: FontWeight.w500),
              ),
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
