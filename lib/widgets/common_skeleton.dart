import 'package:app/utility/color.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class CommonSkeleton extends StatelessWidget {
  const CommonSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      child: Material(
        elevation: 1,
        borderRadius: BorderRadius.circular(10),
        shadowColor: ColorConstant.mainColor,
        child: Container(
          height: MediaQuery.of(context).size.height * .2,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
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
                          height: 10,
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
                      height: 10,
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
                      height: 10,
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
                      height: 10,
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
                          height: 10,
                          randomLength: false,
                          borderRadius: BorderRadius.circular(10),
                          width: MediaQuery.of(context).size.width * .35,
                        ),
                      ),
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
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
}
