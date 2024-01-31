import 'package:app/utility/color.dart';
import 'package:flutter/material.dart';

Widget commonTextFieldText({String? title}) {
  return Text(
    title!,
    style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: ColorConstant.greyColor),
  );
}
