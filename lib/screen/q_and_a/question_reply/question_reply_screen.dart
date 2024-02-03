import 'package:app/utility/color.dart';
import 'package:app/widgets/app_bar_back.dart';
import 'package:app/widgets/common_comment_widget.dart';
import 'package:app/widgets/search_text_field.dart';
import 'package:flutter/material.dart';

class QuestionReplyScreen extends StatefulWidget {
  const QuestionReplyScreen({super.key});

  @override
  State<QuestionReplyScreen> createState() => _QuestionReplyScreenState();
}

class _QuestionReplyScreenState extends State<QuestionReplyScreen> {
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
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 30),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: CustomSearchTextField(
            borderRadius: 10,
            context: context,
            hintText: "Write your reply",
            suffix: const Icon(
              Icons.send,
              size: 23,
              color: ColorConstant.black,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            commonCommentWidget(context: context, isComment: false),
            const SizedBox(
              height: 20,
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: 10,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return commonCommentWidget(
                    context: context, isComment: true, isQuestionReply: true);
              },
            )
          ],
        ),
      ),
    );
  }
}
