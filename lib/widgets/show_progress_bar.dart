import 'package:app/utility/color.dart';
import 'package:flutter/material.dart';

class ShowProgressBar extends StatelessWidget {
  const ShowProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.transparent,
        child: const Center(
          child: SizedBox(
            height: 120,
            width: 120,
            child: Image(
                image: AssetImage(
                  "assets/loader.gif",
                ),
                color: ColorConstant.mainColor,
                height: 120,
                width: 120),
          ),
        ),
      ),
    );
  }
}
