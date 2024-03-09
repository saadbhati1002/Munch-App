import 'package:app/utility/color.dart';
import 'package:flutter/material.dart';

titleAppBar({
  BuildContext? context,
  VoidCallback? onTap,
  String? title,
}) {
  return AppBar(
    backgroundColor: Colors.transparent,
    automaticallyImplyLeading: false,
    title: SizedBox(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: onTap,
            child: Container(
              margin: const EdgeInsets.only(top: 10, left: 5),
              height: 23,
              width: 30,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: ColorConstant.black,
              ),
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: ColorConstant.white,
                size: 18,
              ),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              title!,
              style: const TextStyle(
                  fontSize: 14,
                  fontFamily: 'inter',
                  fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    ),
  );
}
