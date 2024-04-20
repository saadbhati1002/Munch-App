import 'package:app/utility/color.dart';
import 'package:app/widgets/app_bar_title.dart';
import 'package:flutter/material.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.backGroundColor,
      appBar: titleAppBar(
        context: context,
        onTap: () {
          Navigator.pop(context);
        },
        title: "Follow Us",
      ),
    );
  }
}
