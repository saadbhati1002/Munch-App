import 'package:app/utility/color.dart';
import 'package:app/widgets/app_bar_back.dart';
import 'package:app/widgets/common_button.dart';
import 'package:app/widgets/search_text_field.dart';
import 'package:flutter/material.dart';

class AddQuestionsScreen extends StatefulWidget {
  const AddQuestionsScreen({super.key});

  @override
  State<AddQuestionsScreen> createState() => _AddQuestionsScreenState();
}

class _AddQuestionsScreenState extends State<AddQuestionsScreen> {
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
          children: [
            const SizedBox(
              height: 30,
            ),
            Container(
              alignment: Alignment.center,
              child: const Text(
                'POST YOUR QUESTION',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: ColorConstant.mainColor,
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: CustomSearchTextField(
                context: context,
                borderRadius: 10,
                hintText: "Write the title of the question",
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: CustomSearchTextField(
                context: context,
                borderRadius: 10,
                isMaxLine: true,
                hintText: "Write the description",
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: CommonButton(
                color: ColorConstant.mainColor,
                textColor: ColorConstant.white,
                title: "Submit",
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
