import 'package:app/screen/q_and_a/add_question/add_question.dart';
import 'package:app/screen/q_and_a/question_reply/question_reply_screen.dart';
import 'package:app/utility/color.dart';
import 'package:app/widgets/common_comment_widget.dart';
import 'package:app/widgets/common_drawer.dart';
import 'package:app/widgets/contest_list_widget.dart';
import 'package:app/widgets/custom_app_bar.dart';
import 'package:app/widgets/search_text_field.dart';
import 'package:flutter/material.dart';

class ContestListScreen extends StatefulWidget {
  const ContestListScreen({super.key});

  @override
  State<ContestListScreen> createState() => _ContestListScreenState();
}

class _ContestListScreenState extends State<ContestListScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const CommonDrawer(),
      key: _key,
      backgroundColor: ColorConstant.backGroundColor,
      appBar: customAppBar(
        _key,
        context: context,
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: CustomSearchTextField(
                context: context,
                hintText: 'Search for contest',
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
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const QuestionReplyScreen(),
                      ),
                    );
                  },
                  child: contestListWidget(
                    context: context,
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
