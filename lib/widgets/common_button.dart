import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  const CommonButton(
      {Key? key,
      this.width,
      this.onTap,
      this.title,
      this.color,
      this.textColor})
      : super(key: key);
  final double? width;
  final Function()? onTap;
  final String? title;
  final Color? color;
  final Color? textColor;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30), color: color),
        alignment: Alignment.center,
        child: Text(
          title!,
          style: TextStyle(
              fontSize: 16,
              color: textColor!,
              fontFamily: "inter",
              fontWeight: FontWeight.w900),
        ),
      ),
    );
  }
}
