import 'package:app/utility/color.dart';
import 'package:flutter/material.dart';

Widget microLoader({double? height, double? width}) {
  return SizedBox(
    height: height,
    width: width,
    child: const CircularProgressIndicator(
      color: ColorConstant.mainColor,
      strokeWidth: 1.5,
    ),
  );
}
