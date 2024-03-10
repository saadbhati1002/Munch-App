import 'package:app/models/contest/contest_model.dart';
import 'package:app/utility/color.dart';
import 'package:app/utility/constant.dart';
import 'package:flutter/material.dart';

Widget contestListWidget({BuildContext? context, ContestData? contestData}) {
  return Container(
    width: MediaQuery.of(context!).size.width * 1,
    color: ColorConstant.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 1,
          width: MediaQuery.of(context).size.width * 1,
          color: ColorConstant.greyColor,
        ),
        const SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            contestData!.title ?? AppConstant.appName,
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
            contestData.titleTagline ?? AppConstant.appName,
            maxLines: 4,
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
              Text(
                "${contestData.numOfParticipate} Participant",
                style: const TextStyle(
                    fontSize: 12,
                    color: ColorConstant.black,
                    fontWeight: FontWeight.w700),
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Participate",
                    style: TextStyle(
                        height: 1,
                        fontSize: 12,
                        color: ColorConstant.black,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  Icon(
                    Icons.arrow_right,
                    color: ColorConstant.mainColor,
                  ),
                ],
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
