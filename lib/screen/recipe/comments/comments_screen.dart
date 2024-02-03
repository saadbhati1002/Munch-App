import 'package:app/utility/color.dart';
import 'package:app/widgets/app_bar_back.dart';
import 'package:app/widgets/common_comment_widget.dart';
import 'package:app/widgets/search_text_field.dart';
import 'package:flutter/material.dart';

class RecipeCommentsScreen extends StatefulWidget {
  const RecipeCommentsScreen({super.key});

  @override
  State<RecipeCommentsScreen> createState() => _RecipeCommentsScreenState();
}

class _RecipeCommentsScreenState extends State<RecipeCommentsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.backGroundColor,
      appBar: customAppBarBack(
        context: context,
        onTap: () {
          Navigator.pop(context);
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            Container(
              alignment: Alignment.center,
              child: const Text(
                'Comment',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: ColorConstant.organColor,
                  fontSize: 20,
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: const Text(
                'Write, communicate & express',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: ColorConstant.greyColor,
                  fontSize: 10,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: CustomSearchTextField(
                context: context,
                hintText: 'Search for Comments',
                prefix: const Icon(
                  Icons.search,
                  size: 25,
                  color: ColorConstant.greyColor,
                ),
                suffix: const Icon(
                  Icons.filter_alt_rounded,
                  size: 25,
                  color: ColorConstant.greyColor,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: 10,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return commonComment(context: context);
              },
            )
          ],
        ),
      ),
    );
  }
}
