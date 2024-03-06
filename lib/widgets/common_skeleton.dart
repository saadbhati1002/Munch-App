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
        elevation: 2,
        borderRadius: BorderRadius.circular(10),
        shadowColor: ColorConstant.mainColor,
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 0.9, color: ColorConstant.mainColor),
          ),
          child: SkeletonTheme(
            themeMode: ThemeMode.light,
            child: SkeletonAvatar(
              style: SkeletonAvatarStyle(
                height: MediaQuery.of(context).size.height * .2,
                width: MediaQuery.of(context).size.width,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
