import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

Widget recipeSkeleton({BuildContext? context}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SkeletonAvatar(
                style: SkeletonAvatarStyle(
                  width: 35,
                  height: 35,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 10),
              SkeletonLine(
                style: SkeletonLineStyle(
                  height: 15,
                  randomLength: false,
                  borderRadius: BorderRadius.circular(10),
                  width: MediaQuery.of(context!).size.width * .25,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * .025,
        ),
        SkeletonTheme(
          themeMode: ThemeMode.light,
          child: SkeletonAvatar(
            style: SkeletonAvatarStyle(
              height: MediaQuery.of(context).size.height * .4,
              width: MediaQuery.of(context).size.width,
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * .025,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SkeletonLine(
                style: SkeletonLineStyle(
                  height: 15,
                  randomLength: false,
                  borderRadius: BorderRadius.circular(10),
                  width: MediaQuery.of(context).size.width * .25,
                ),
              ),
              SkeletonLine(
                style: SkeletonLineStyle(
                  height: 15,
                  randomLength: false,
                  borderRadius: BorderRadius.circular(10),
                  width: MediaQuery.of(context).size.width * .25,
                ),
              ),
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
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * .025,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SkeletonLine(
            style: SkeletonLineStyle(
              height: 15,
              randomLength: false,
              borderRadius: BorderRadius.circular(10),
              width: MediaQuery.of(context).size.width,
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * .01,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SkeletonLine(
            style: SkeletonLineStyle(
              height: 15,
              randomLength: false,
              borderRadius: BorderRadius.circular(10),
              width: MediaQuery.of(context).size.width,
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * .025,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SkeletonLine(
                style: SkeletonLineStyle(
                  height: 30,
                  randomLength: false,
                  borderRadius: BorderRadius.circular(20),
                  width: MediaQuery.of(context).size.width * .25,
                ),
              ),
              SkeletonLine(
                style: SkeletonLineStyle(
                  height: 30,
                  randomLength: false,
                  borderRadius: BorderRadius.circular(20),
                  width: MediaQuery.of(context).size.width * .25,
                ),
              ),
              SkeletonLine(
                style: SkeletonLineStyle(
                  height: 30,
                  randomLength: false,
                  borderRadius: BorderRadius.circular(20),
                  width: MediaQuery.of(context).size.width * .25,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * .04,
        ),
      ],
    ),
  );
}
