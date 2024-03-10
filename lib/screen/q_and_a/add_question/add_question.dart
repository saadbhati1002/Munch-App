import 'dart:convert';

import 'package:app/api/repository/q_and_a/q_and_a.dart';
import 'package:app/models/q_and_a/add/add_question_model.dart';
import 'package:app/utility/color.dart';
import 'package:app/utility/constant.dart';
import 'package:app/widgets/app_bar_back.dart';
import 'package:app/widgets/common_button.dart';
import 'package:app/widgets/search_text_field.dart';
import 'package:app/widgets/show_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddQuestionsScreen extends StatefulWidget {
  const AddQuestionsScreen({super.key});

  @override
  State<AddQuestionsScreen> createState() => _AddQuestionsScreenState();
}

class _AddQuestionsScreenState extends State<AddQuestionsScreen> {
  TextEditingController questionController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool isLoading = false;
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
      body: Stack(
        children: [
          SingleChildScrollView(
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
                    controller: questionController,
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
                    controller: descriptionController,
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
                      _addQuestion();
                    },
                  ),
                ),
              ],
            ),
          ),
          isLoading ? const ShowProgressBar() : const SizedBox()
        ],
      ),
    );
  }

  Future _addQuestion() async {
    if (questionController.text.isEmpty) {
      toastShow(message: "Please enter title");
      return;
    }
    if (descriptionController.text.isEmpty) {
      toastShow(message: "Please enter comment");
      return;
    }
    try {
      setState(() {
        isLoading = true;
      });
      FocusManager.instance.primaryFocus?.unfocus();
      AddQuestionRes response = await QAndARepository().addQuestionApiCall(
        description: descriptionController.text.trim(),
        question: questionController.text.trim(),
      );
      if (response.success == true) {
        toastShow(message: response.message);

        Get.back(result: jsonEncode(response.data));
      } else {
        toastShow(message: response.message);
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
