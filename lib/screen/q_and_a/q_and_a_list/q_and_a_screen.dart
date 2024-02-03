import 'package:app/screen/q_and_a/add_question/add_question.dart';
import 'package:app/utility/color.dart';
import 'package:app/widgets/app_bar_back.dart';
import 'package:app/widgets/common_comment_widget.dart';
import 'package:app/widgets/search_text_field.dart';
import 'package:flutter/material.dart';

class QuestionAndAnswerScreen extends StatefulWidget {
  const QuestionAndAnswerScreen({super.key});

  @override
  State<QuestionAndAnswerScreen> createState() =>
      _QuestionAndAnswerScreenState();
}

class _QuestionAndAnswerScreenState extends State<QuestionAndAnswerScreen> {
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
      floatingActionButton: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddQuestionsScreen(),
            ),
          );
        },
        child: Container(
            height: 38,
            margin: const EdgeInsets.only(bottom: 60),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: ColorConstant.mainColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Add a question",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: ColorConstant.white),
                ),
              ],
            )),
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
                'Q&A',
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
                hintText: 'Search for Topics',
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
                return commonComment(context: context, isComment: false);
              },
            )
          ],
        ),
      ),
    );
  }
}
